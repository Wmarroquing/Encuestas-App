import 'package:devel_app/common/dialogs/custom_alert_dialog.dart';
import 'package:devel_app/common/dialogs/survey_code_modal.dart';
import 'package:devel_app/common/loader/custom_loader.dart';
import 'package:devel_app/common/model/survey_args.dart';
import 'package:devel_app/common/model/survey_model.dart';
import 'package:devel_app/common/resources/app_constants.dart';
import 'package:devel_app/common/routes/landing_routes.dart';
import 'package:devel_app/common/theme/custom_colors.dart';
import 'package:devel_app/home/bloc/home_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_bar.dart';
part 'custom_card.dart';
part 'user_survey_list.dart';
part 'complete_survey_list.dart';
part 'bottom_sheet.dart';

class HomeBody extends StatefulWidget {
  final User authenticatedUser;

  const HomeBody({super.key, required this.authenticatedUser});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> with TickerProviderStateMixin {
  final GlobalKey<FormState> _surveyFormKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  List<SurveyModel> _surveys = <SurveyModel>[];
  List<SurveyModel> _completeSurveys = <SurveyModel>[];
  late final TabController _tabController;
  late HomeBloc _homeBloc;
  late String _appBarTitle;
  late String _appBarSubtitle;

  @override
  void initState() {
    super.initState();
    _homeBloc = context.read<HomeBloc>();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabController);
    _appBarTitle = 'Mis Encuestas';
    _appBarSubtitle = 'Administra todas las encuestas que has creado.';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _subscribeToFirebaseDB();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        switch (state) {
          case HomeSurveysLoadedSuccess(:final List<SurveyModel> surveys):
            setState(() => _surveys = surveys);
            break;
          case HomeCompleteSurveysLoadedSuccess(
            :final List<SurveyModel> surveys,
          ):
            setState(() => _completeSurveys = surveys);
            break;
          case HomeSurveysException(:final String message):
            _showExceptionMessage(message);
            break;
          case HomeLoggedOutSuccess():
            Navigator.of(context).pushNamedAndRemoveUntil(
              LandingRoutes.loginRoute,
              (Route<dynamic> route) => false,
            );
            break;
          case SurveyObtainedSuccess(:final SurveyModel survey):
            Navigator.pushNamed(
              context,
              LandingRoutes.surveyRoute,
              arguments: SurveyArgs(isOnlyView: false, surveyModel: survey),
            );
          default:
        }
      },
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: CustomAppBar(
              title: _appBarTitle,
              subtitle: _appBarSubtitle,
              currentTab: _tabController.index,
              fnOnCreateTap: _navigateToCreateSurvey,
              fnOnCompleteTap: _openSurveyCodeModal,
              fnOnLogoutTap: _logout,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.appPadding,
              ),
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  UserSurveyList(
                    surveys: _surveys,
                    fnOnDetailTap: _navigateToDetailSurvey,
                    fnOnEditTap: _navigateToEditSurvey,
                    fnOnDeleteTap: _showDeleteSurveyDialog,
                    fnOnCopyCode: _handleCopySurveyCode,
                  ),
                  CompleteSurveyList(
                    completeSurveys: _completeSurveys,
                    fnOnDetailTap: _navigateToDetailSurvey,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: HomeBottomSheet(tabController: _tabController),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (BuildContext context, HomeState state) {
              if (state is HomeInProgress) {
                return const CustomLoader();
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  void _subscribeToFirebaseDB() {
    _homeBloc.add(SubscribeSurveys());
    _homeBloc.add(SubscribeCompleteSurveys());
  }

  void _handleTabController() {
    final List<Map<String, String>> titles = <Map<String, String>>[
      <String, String>{
        'title': 'Mis Encuestas',
        'subtitle': 'Administra todas las encuestas que has creado.',
      },
      <String, String>{
        'title': 'Completadas',
        'subtitle': 'Completa encuestas ingresando el código de encuesta.',
      },
    ];
    if (_tabController.indexIsChanging == false) {
      setState(() {
        _appBarTitle = titles[_tabController.index]['title'] ?? '';
        _appBarSubtitle = titles[_tabController.index]['subtitle'] ?? '';
      });
    }
  }

  void _handleCopySurveyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Texto copiado al portapapeles')));
  }

  void _navigateToDetailSurvey(SurveyModel survey) {
    Navigator.pushNamed(
      context,
      LandingRoutes.surveyRoute,
      arguments: SurveyArgs(isOnlyView: true, surveyModel: survey),
    ).then((Object? result) => _subscribeToFirebaseDB());
  }

  void _navigateToCreateSurvey() {
    Navigator.pushNamed(
      context,
      LandingRoutes.surveyAdminRoute,
    ).then((Object? result) => _subscribeToFirebaseDB());
  }

  void _navigateToEditSurvey(SurveyModel surveyModel) {
    Navigator.pushNamed(
      context,
      LandingRoutes.surveyAdminRoute,
      arguments: surveyModel,
    ).then((Object? result) => _subscribeToFirebaseDB());
  }

  void _verifySurveyCode() {
    if (_surveyFormKey.currentState!.validate()) {
      Navigator.pop(context);
      _homeBloc.add(
        SurveyGetByCodeEvent(
          code: _codeController.text,
          currentSurveys: _surveys,
        ),
      );
    }
  }

  void _showDeleteSurveyDialog(String surveyId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          isConfirmDialog: true,
          title: 'Borrar encuesta',
          description:
              'Está seguro que desea borrar esta encuesta?\nTodos los datos se perderán.',
          fnOnConfirmPressed: () {
            _homeBloc.add(SurveyDeletedEvent(surveyId: surveyId));
          },
        );
      },
    );
  }

  void _showExceptionMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Error de recuperación',
          description: message,
        );
      },
    );
  }

  void _openSurveyCodeModal() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SurveyCodeModal(
          surveyFormKey: _surveyFormKey,
          codeController: _codeController,
          fnOnPressButton: _verifySurveyCode,
        );
      },
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Salir',
          description: 'Deseas salir de la aplicación?',
          isConfirmDialog: true,
          fnOnConfirmPressed: () {
            _homeBloc.add(FirebaseAuthLoggedOut());
          },
        );
      },
    );
  }
}

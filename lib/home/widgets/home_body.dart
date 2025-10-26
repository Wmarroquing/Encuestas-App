import 'dart:ui';

import 'package:devel_app/common/dialogs/custom_alert_dialog.dart';
import 'package:devel_app/common/loader/custom_loader.dart';
import 'package:devel_app/common/model/survey_request.dart';
import 'package:devel_app/common/resources/app_constants.dart';
import 'package:devel_app/common/routes/landing_routes.dart';
import 'package:devel_app/common/theme/custom_colors.dart';
import 'package:devel_app/home/bloc/home_bloc.dart';
import 'package:devel_app/common/model/survey_arguments.dart';
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
  List<SurveyModel> _surveys = <SurveyModel>[];
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
    _homeBloc.add(SubscribeSurveys());
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
          case HomeSurveysLoadedError(:final String message):
            _showExceptionMessage(message);
            break;
          case HomeLoggedOutSuccess():
            Navigator.of(context).pushNamedAndRemoveUntil(
              LandingRoutes.loginRoute,
              (Route<dynamic> route) => false,
            );
            break;
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
              fnOnCompleteTap: () {},
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
                  CompleteSurveyList(fnOnDetailTap: _navigateToDetailSurvey),
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

  void _handleCopySurveyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Texto copiado al portapapeles')));
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

  void _navigateToCreateSurvey() {
    Navigator.pushNamed(
      context,
      LandingRoutes.surveyRoute,
      arguments: SurveyArguments(authenticatedUser: widget.authenticatedUser),
    );
  }

  void _navigateToDetailSurvey() {}

  void _navigateToEditSurvey(SurveyModel surveyModel) {
    Navigator.pushNamed(
      context,
      LandingRoutes.surveyRoute,
      arguments: SurveyArguments(
        authenticatedUser: widget.authenticatedUser,
        surveyModel: surveyModel,
      ),
    );
  }

  void _showDeleteSurveyDialog(String surveyId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          isConfirmDialog: true,
          title: 'title',
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

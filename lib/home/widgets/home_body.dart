import 'package:devel_app/common/dialogs/custom_alert_dialog.dart';
import 'package:devel_app/common/resources/app_constants.dart';
import 'package:devel_app/common/theme/custom_colors.dart';
import 'package:flutter/material.dart';

part 'app_bar.dart';
part 'custom_card.dart';
part 'user_survey_list.dart';
part 'complete_survey_list.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(fnOnLogoutTap: _logout),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.appPadding,
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            UserSurveyList(
              fnOnDetailTap: _navigateToDetailSurvey,
              fnOnEditTap: _navigateToEditSurvey,
              fnOnDeleteTap: _showDeleteSurveyDialog,
            ),
            CompleteSurveyList(fnOnDetailTap: _navigateToDetailSurvey),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          top: 8.0,
          left: 4.0,
          right: 4.0,
          bottom: 32.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TabBar(
          controller: _tabController,
          tabs: [Tab(text: 'Mis encuestas'), Tab(text: 'Completadas')],
        ),
      ),
    );
  }

  void _logout() {}

  void _navigateToDetailSurvey() {}

  void _navigateToEditSurvey() {}

  void _showDeleteSurveyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          isConfirmDialog: true,
          title: 'title',
          description:
              'Está seguro que desea borrar esta encuesta?\nTodos los datos se perderán.',
        );
      },
    );
  }
}

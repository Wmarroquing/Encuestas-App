part of 'home_body.dart';

class UserSurveyList extends StatelessWidget {
  final List<SurveyModel> surveys;
  final void Function(SurveyModel) fnOnDetailTap;
  final void Function(SurveyModel) fnOnEditTap;
  final void Function(String) fnOnDeleteTap;
  final void Function(String) fnOnCopyCode;

  const UserSurveyList({
    super.key,
    required this.surveys,
    required this.fnOnDetailTap,
    required this.fnOnEditTap,
    required this.fnOnDeleteTap,
    required this.fnOnCopyCode,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      itemBuilder: (BuildContext context, int index) {
        final SurveyModel currentSurvey = surveys[index];
        return CustomCard(
          isManagementView: true,
          currentSurvey: currentSurvey,
          fnOnDetailTap: fnOnDetailTap,
          fnOnEditTap: fnOnEditTap,
          fnOnDeleteTap: fnOnDeleteTap,
          fnOnCopyCode: fnOnCopyCode,
        );
      },
      itemCount: surveys.length,
    );
  }
}

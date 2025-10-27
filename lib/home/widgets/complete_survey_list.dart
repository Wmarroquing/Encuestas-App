part of 'home_body.dart';

class CompleteSurveyList extends StatelessWidget {
  final List<SurveyModel> completeSurveys;
  final void Function(SurveyModel) fnOnDetailTap;

  const CompleteSurveyList({
    super.key,
    required this.completeSurveys,
    required this.fnOnDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      itemBuilder: (BuildContext context, int index) {
        final SurveyModel currentSurvey = completeSurveys[index];
        return CustomCard(
          isManagementView: false,
          currentSurvey: currentSurvey,
          fnOnDetailTap: fnOnDetailTap,
        );
      },
      itemCount: completeSurveys.length,
    );
  }
}

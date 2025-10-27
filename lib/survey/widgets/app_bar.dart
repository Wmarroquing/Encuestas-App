part of 'survey_body.dart';

class SurveyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String surveyTitle;
  final String surveySubtitile;

  const SurveyAppBar({
    super.key,
    required this.surveyTitle,
    required this.surveySubtitile,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(surveyTitle),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            surveySubtitile,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: CustomColors.textSecondary),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110.0);
}

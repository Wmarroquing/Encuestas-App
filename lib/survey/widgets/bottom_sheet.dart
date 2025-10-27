part of 'survey_body.dart';

class SurveyBottomSheet extends StatelessWidget {
  final void Function()? fnOnCompletePressed;

  const SurveyBottomSheet({super.key, required this.fnOnCompletePressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: fnOnCompletePressed,
            child: Text('Completar'),
          ),
        ),
      ),
    );
  }
}

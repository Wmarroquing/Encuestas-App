part of 'survey_body.dart';

class CustomBottomSheet extends StatelessWidget {
  final bool isEditView;
  final void Function() fnOnCreatePressed;

  const CustomBottomSheet({
    super.key,
    required this.isEditView,
    required this.fnOnCreatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: fnOnCreatePressed,
            child: Text(isEditView ? 'Editar' : 'Crear'),
          ),
        ),
      ),
    );
  }
}

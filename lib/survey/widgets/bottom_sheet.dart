part of 'survey_body.dart';

class CustomBottomSheet extends StatelessWidget {
  final bool isEditView;
  final void Function() fnOnCancelPressed;
  final void Function() fnOnCreatePressed;

  const CustomBottomSheet({
    super.key,
    required this.isEditView,
    required this.fnOnCancelPressed,
    required this.fnOnCreatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 140.0,
              child: OutlinedButton(
                onPressed: fnOnCancelPressed,
                child: Text('Cancelar'),
              ),
            ),
            SizedBox(
              width: 140.0,
              child: OutlinedButton(
                onPressed: fnOnCreatePressed,
                child: Text(isEditView ? 'Editar' : 'Crear'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

part of 'survey_body.dart';

class SurveyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isEditView;
  final void Function() fnOnCancelPressed;

  const SurveyAppBar({
    super.key,
    required this.isEditView,
    required this.fnOnCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(onPressed: fnOnCancelPressed),
      title: Text(isEditView ? 'Editar encuesta' : 'Crear nueva encuesta'),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 8.0,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Diseña tu encuesta con campos personalizados y genera u código de acceso único para compartir',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: CustomColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110.0);
}

part of 'login_body.dart';

class SurveyCodeModal extends StatelessWidget {
  final GlobalKey<FormState> surveyFormKey;
  final void Function() fnOnPressButton;

  const SurveyCodeModal({
    super.key,
    required this.surveyFormKey,
    required this.fnOnPressButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 22.0),
        child: Form(
          key: surveyFormKey,
          child: Column(
            spacing: 16.0,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.key),
              Text(
                'Acceder a encuesta',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Por favor ingresa el código de acceso para completar la encuesta.',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: CustomColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Ej: ABC123XYZ'),
                validator: emptyFieldValidator,
              ),
              ElevatedButton(
                onPressed: fnOnPressButton,
                child: Text('Cargar encuesta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

part of 'survey_body.dart';

class SurveyTitleForm extends StatelessWidget {
  final GlobalKey<FormState> surveyFormKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const SurveyTitleForm({
    super.key,
    required this.surveyFormKey,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.appPadding),
        child: Form(
          key: surveyFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Información básica',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16.0),
              Text('Titulo de la encuesta'),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: titleController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Ingresa el titulo de tu encesta',
                ),
                validator: emptyFieldValidator,
              ),
              const SizedBox(height: 16.0),
              Text('Descripción'),
              TextFormField(
                minLines: 3,
                maxLines: 5,
                controller: descriptionController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText:
                      'Describe el propósito y contexto de esta encuesta...',
                ),
                validator: emptyFieldValidator,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

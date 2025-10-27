part of 'survey_body.dart';

class SurveyFieldsList extends StatefulWidget {
  final List<SurveyQuestionModel> questionsFields;
  final void Function(SurveyQuestionModel) fnOnEditPressed;
  final void Function(SurveyQuestionModel) fnOnDeletePressed;

  const SurveyFieldsList({
    super.key,
    required this.questionsFields,
    required this.fnOnEditPressed,
    required this.fnOnDeletePressed,
  });

  @override
  State<SurveyFieldsList> createState() => _SurveyFieldsListState();
}

class _SurveyFieldsListState extends State<SurveyFieldsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(widget.questionsFields.length, (
        int index,
      ) {
        final SurveyQuestionModel questionField = widget.questionsFields[index];
        return Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(questionField.text),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => widget.fnOnEditPressed(questionField),
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () => widget.fnOnDeletePressed(questionField),
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
              ListTile(
                dense: true,
                title: Text('Tipo de dato:'),
                trailing: Text(questionField.type),
              ),
              SwitchListTile(
                dense: true,
                value: questionField.isRequired,
                onChanged: (bool value) {
                  setState(() => questionField.isRequired = value);
                },
                title: Text('Campo requerido'),
              ),
            ],
          ),
        );
      }),
    );
  }
}

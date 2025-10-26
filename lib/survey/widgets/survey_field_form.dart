part of 'survey_body.dart';

class SurveyFieldForm extends StatefulWidget {
  final SurveyQuestionModel? questionField;
  final void Function(SurveyQuestionModel) fnOnAddPressed;
  final void Function(SurveyQuestionModel) fnOnEditPressed;

  const SurveyFieldForm({
    super.key,
    required this.questionField,
    required this.fnOnAddPressed,
    required this.fnOnEditPressed,
  });

  @override
  State<SurveyFieldForm> createState() => _SurveyFieldFormState();
}

class _SurveyFieldFormState extends State<SurveyFieldForm> {
  final GlobalKey<FormState> _fieldFormKey = GlobalKey<FormState>();
  final TextEditingController _fieldNameController = TextEditingController();
  final TextEditingController _optionController = TextEditingController();
  final List<String> _multipleOptions = <String>[];
  bool _isRequiredField = false;
  String? _fieldType;

  @override
  void initState() {
    super.initState();
    if (widget.questionField != null) {
      setState(() {
        _fieldNameController.text = widget.questionField!.text;
        _fieldType = widget.questionField!.type;
        _isRequiredField = widget.questionField!.isRequired;
        _multipleOptions.addAll(widget.questionField!.options);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fieldFormKey,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppConstants.appPadding),
          child: Column(
            spacing: 4.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Agregar campo',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Define las caracteristicas del nuevo campo de la encuesta',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: CustomColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16.0),
              Text('Etiqueta del campo'),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: _fieldNameController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'EJ: cual es tu nombre?'),
                validator: emptyFieldValidator,
              ),
              const SizedBox(height: 16.0),
              Text('Tipo de campo'),
              DropdownMenu<String>(
                initialSelection: _fieldType,
                width: double.infinity,
                hintText: 'Selecciona un tipo',
                dropdownMenuEntries: <DropdownMenuEntry<String>>[
                  DropdownMenuEntry<String>(value: 'text', label: 'Texto'),
                  DropdownMenuEntry<String>(value: 'boolean', label: 'Sí/No'),
                  DropdownMenuEntry<String>(value: 'number', label: 'Número'),
                  DropdownMenuEntry<String>(
                    value: 'option',
                    label: 'Opción múltiple',
                  ),
                ],
                onSelected: (String? selectedValue) {
                  setState(() => _fieldType = selectedValue);
                },
              ),
              Visibility(
                visible: _fieldType == 'option',
                child: TextFormField(
                  controller: _optionController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Ingresa en nombre de una opción',
                  ),
                  onFieldSubmitted: _addOptiontext,
                  validator:
                      _multipleOptions.isEmpty ? emptyFieldValidator : null,
                ),
              ),
              Visibility(
                visible: _multipleOptions.isNotEmpty,
                child: Column(
                  children: List<Widget>.generate(_multipleOptions.length, (
                    int index,
                  ) {
                    final String option = _multipleOptions[index];
                    return ListTile(
                      dense: true,
                      title: Text(option),
                      leading: Text('${index + 1}) '),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            _multipleOptions.removeAt(index);
                          });
                        },
                        icon: Icon(Icons.cancel_outlined),
                      ),
                    );
                  }),
                ),
              ),
              CheckboxListTile(
                dense: true,
                value: _isRequiredField,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text('Campo requerido'),
                onChanged: (bool? value) {
                  setState(() => _isRequiredField = value!);
                },
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _fieldType != null ? _createNewSurveyField : null,
                  child: Text('Agregar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createNewSurveyField() {
    if (_fieldFormKey.currentState!.validate()) {
      if (_fieldType == 'option' && _multipleOptions.isEmpty) return;
      final SurveyQuestionModel questionfield = SurveyQuestionModel(
        id: widget.questionField?.id ?? DateTime.now().millisecondsSinceEpoch,
        text: _fieldNameController.text,
        type: _fieldType!,
        isRequired: _isRequiredField,
        options: _multipleOptions,
      );
      if (widget.questionField != null) {
        widget.fnOnEditPressed(questionfield);
      } else {
        widget.fnOnAddPressed(questionfield);
      }
      Navigator.pop(context);
    }
  }

  void _addOptiontext(String? text) {
    if (text != null && _optionController.text.trim().isNotEmpty) {
      _optionController.clear();
      _multipleOptions.add(text);
    }
  }
}

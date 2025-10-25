String? emptyFieldValidator(String? text) {
  if (text == null || text.isEmpty) {
    return 'Campo requerido';
  }
  return null;
}

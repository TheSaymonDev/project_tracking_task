String? startDateValidator(value) {
  if (value!.isEmpty) {
    return 'Please select start date';
  }
  return null;
}

String? endDateValidator(value) {
  if (value!.isEmpty) {
    return 'Please select end date';
  }
  return null;
}

String? projectNameValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter project name';
  }
  return null;
}
String? projectUpdateValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter project update details';
  }
  return null;
}
String? assignedEngineerValidator(value) {
  if (value!.isEmpty) {
    return 'Please select start date';
  }
  return null;
}
String? assignedTechnicianValidator(value) {
  if (value!.isEmpty) {
    return 'Please select start date';
  }
  return null;
}

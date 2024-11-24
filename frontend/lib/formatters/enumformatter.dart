import 'package:flutter/services.dart';

class EnumFormatter extends TextInputFormatter {
  late final Set<String> values;

  EnumFormatter({required Iterable<String> values}) {
    this.values = Set.from(values);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return (values.contains(newValue.text) || newValue.text.isEmpty)
        ? newValue
        : oldValue;
  }
}

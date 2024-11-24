import 'package:flutter/services.dart';

class NameFormatter extends TextInputFormatter {
  static NameFormatter? _instance;

  factory NameFormatter.get(){
    _instance ??= NameFormatter._();
    return _instance!;
  }

  NameFormatter._();

  String capitalize(String str) {
    return str.isEmpty
        ? ""
        : str[0].toUpperCase() + str.substring(1).toLowerCase();
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return RegExp(r"^[a-zA-Zа-яА-Я]*$").hasMatch(newValue.text)
        ? TextEditingValue(
            text: capitalize(newValue.text),
            composing: newValue.composing,
            selection: newValue.selection)
        : oldValue;
  }
}

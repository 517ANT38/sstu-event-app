import 'package:flutter/services.dart';

class IntMinMaxFormatter extends TextInputFormatter {
  final int min;
  final int max;

  IntMinMaxFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    var parsed = int.tryParse(newValue.text);

    if (parsed == null) return oldValue;

    if (parsed > max || parsed < min) return oldValue;

    return TextEditingValue(
        text: parsed.toString(),
        composing: newValue.composing,
        selection: newValue.selection);
  }
}

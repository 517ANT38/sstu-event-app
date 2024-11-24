import 'package:flutter/services.dart';

class LengthFormatter extends TextInputFormatter {
  final int length;

  LengthFormatter({required this.length});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.text.length <= length ? newValue : oldValue;
  }
}

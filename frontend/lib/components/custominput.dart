import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;

  const CustomInput(
      {super.key,
      this.controller,
      this.placeholder,
      this.keyboardType,
      this.onChanged,
      this.enabled,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
          constraints: const BoxConstraints.tightFor(height: 30),
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.5),
              borderSide: BorderSide.none),
          fillColor: Theme.of(context).colorScheme.secondaryContainer,
          hintText: placeholder,
          enabled: enabled ?? true),
    );
  }
}

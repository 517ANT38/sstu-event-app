import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final bool required;

  const CustomInput(
      {super.key,
      this.controller,
      this.placeholder,
      this.keyboardType,
      this.onChanged,
      this.enabled,
      this.inputFormatters,
      this.required = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            color: Theme.of(context).colorScheme.secondaryContainer),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
                child: TextField(
              controller: controller,
              inputFormatters: inputFormatters,
              onChanged: onChanged,
              keyboardType: keyboardType,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration.collapsed(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                  hintText: placeholder,
                  enabled: enabled ?? true),
            )),
            required
                ? ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 20),
                    child: Text("*",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error)))
                : const SizedBox(width: 20)
          ],
        ));
  }
}

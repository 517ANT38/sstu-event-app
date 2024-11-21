import 'dart:math';

import 'package:flutter/material.dart';

class EventForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EventFormState();
  }
}

class EventFormState extends State<EventForm> {
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final thirdNameController = TextEditingController();
  final schoolController = TextEditingController();
  final phoneController = TextEditingController();
  final countController = TextEditingController();
  final class1Controller = TextEditingController();
  final class2Controller = TextEditingController();

  final fkey = GlobalKey<FormState>();

  final emptyFieldError = "Заполните поле";

  String? emptyValidator(String? value) {
    return (value ?? '').isEmpty ? emptyFieldError : null;
  }

  final countType =
      const TextInputType.numberWithOptions(signed: false, decimal: false);

  var classDiff = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: fkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // Имя
                TextFormField(
                  controller: firstNameController,
                  validator: emptyValidator,
                  keyboardType: TextInputType.name,
                ),
                const Text('Имя'),

                // Фамилия
                TextFormField(
                  controller: secondNameController,
                  validator: emptyValidator,
                  keyboardType: TextInputType.name,
                ),
                const Text('Фамилия'),

                // Отчество
                TextFormField(
                  controller: thirdNameController,
                  keyboardType: TextInputType.name,
                ),
                const Text('Отчество'),

                // Учебное заведение
                TextFormField(
                  controller: schoolController,
                  validator: emptyValidator,
                ),
                const Text('Учебное заведение'),

                // Номер телефона
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),
                const Text('Номер телефона'),

                // Кол-во детей
                TextFormField(
                  controller: countController,
                  keyboardType: countType,
                  validator: emptyValidator,
                ),
                const Text('Кол-во детей'),

                const SizedBox(height: 20),

                // Класс(ы)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownMenu(
                      controller: class1Controller,
                      hintText: "с",
                      dropdownMenuEntries: List.generate(
                          11,
                          (index) => DropdownMenuEntry(
                              value: index + 1, label: (index + 1).toString())),
                      onSelected: (value) {
                        setState(() {
                          classDiff = 11 -
                              (class1Controller.text.isNotEmpty
                                  ? int.parse(class1Controller.text)
                                  : 11);
                          if (class2Controller.text.isNotEmpty &&
                              class1Controller.text.isNotEmpty &&
                              int.parse(class2Controller.text) <=
                                  int.parse(class1Controller.text)) {
                            class2Controller.clear();
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 10.0),
                    const Text('-'),
                    const SizedBox(width: 10.0),
                    DropdownMenu(
                        controller: class2Controller,
                        hintText: 'по',
                        dropdownMenuEntries: List.generate(
                            max(0, classDiff),
                            (index) => DropdownMenuEntry(
                                value: 12 - classDiff + index,
                                label: (12 - classDiff + index).toString())))
                  ],
                ),
                const Text('Класс(ы)'),

                const SizedBox(height: 20),

                TextButton(
                    onPressed: () => {if (fkey.currentState!.validate()) {}},
                    child: const Text("Отправить")),
              ],
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sstu_event_app/components/custominput.dart';
import 'package:sstu_event_app/formatters/enumformatter.dart';
import 'package:sstu_event_app/formatters/intminmaxformatter.dart';
import 'package:sstu_event_app/formatters/lengthformatter.dart';
import 'package:sstu_event_app/formatters/nameformatter.dart';

class EventForm extends StatefulWidget {
  const EventForm({super.key});

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

  String sel1Value = "";
  String sel2Value = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: fkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const Text("What is your name?"),

                // Имя
                CustomInput(
                  controller: firstNameController,
                  keyboardType: TextInputType.name,
                  placeholder: "First name",
                  inputFormatters: [NameFormatter.get()],
                ),

                const SizedBox(height: 10),

                // Фамилия
                CustomInput(
                  controller: secondNameController,
                  keyboardType: TextInputType.name,
                  placeholder: "Last name",
                  inputFormatters: [NameFormatter.get()],
                ),

                const SizedBox(height: 10),

                // Отчество
                CustomInput(
                  controller: thirdNameController,
                  keyboardType: TextInputType.name,
                  placeholder: "Middle name",
                  inputFormatters: [NameFormatter.get()],
                ),

                const SizedBox(height: 20),

                const Text("Where are you from?"),

                // Учебное заведение
                CustomInput(
                  controller: schoolController,
                  placeholder: "School",
                ),

                const SizedBox(height: 20),

                const Text("How many kids want to visit us?"),

                // Кол-во детей
                CustomInput(
                  controller: countController,
                  keyboardType: countType,
                  placeholder: "Count",
                  inputFormatters: [IntMinMaxFormatter(min: 1, max: 100)],
                ),

                const SizedBox(height: 20),

                const Text("What classes of children are coming to us?"),

                // Класс(ы)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 100),
                      child: CustomInput(
                        controller: class1Controller,
                        placeholder: "min",
                        keyboardType: countType,
                        inputFormatters: [IntMinMaxFormatter(min: 1, max: 11)],
                        onChanged: (value) {
                          setState(() {
                            sel1Value = value;
                            if (sel2Value.isNotEmpty &&
                                value.isNotEmpty &&
                                int.parse(sel2Value) <= int.parse(value)) {
                              class2Controller.clear();
                              sel2Value = "";
                            }
                          });
                        },
                      )),
                  const SizedBox(width: 10.0),
                  const Text('-'),
                  const SizedBox(width: 10.0),
                  ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 100),
                      child: CustomInput(
                        enabled:
                            sel1Value.isNotEmpty && int.parse(sel1Value) != 11,
                        controller: class2Controller,
                        placeholder: 'max',
                        keyboardType: countType,
                        onChanged: (value) {
                          setState(() {
                            sel2Value = value;
                          });
                        },
                        inputFormatters: [
                          EnumFormatter(values: [
                            "1",
                            "10",
                            ...List.generate(
                                11 - (int.tryParse(sel1Value) ?? 11),
                                (index) => (11 - index).toString())
                          ])
                        ],
                      ))
                ]),

                const SizedBox(height: 20),

                const Text("What is your phone number?"),

                // Номер телефона
                CustomInput(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  placeholder: "8 888 909-11-22",
                  inputFormatters: [LengthFormatter(length: 20)],
                ),

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: TextButton(
                      onPressed: () {
                        List<String> errors = [];

                        if (phoneController.text.isEmpty) {
                          errors.add("Empty phone number");
                        } else if (!RegExp(
                                r"^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$")
                            .hasMatch(phoneController.text)) {
                          errors.add("Incorrect phone number");
                        }

                        if (firstNameController.text.isEmpty) {
                          errors.add("Empty first name");
                        }

                        if (secondNameController.text.isEmpty) {
                          errors.add("Empty last name");
                        }

                        if (schoolController.text.isEmpty) {
                          errors.add("Empty school name");
                        }

                        if (countController.text.isEmpty) {
                          errors.add("Empty kids count");
                        }

                        if (sel1Value.isEmpty) {
                          errors.add("Empty min class");
                        } else if (sel2Value.isNotEmpty &&
                            int.parse(sel2Value) <= int.parse(sel1Value)) {
                          errors.add("Max class must be less than min class");
                        }

                        if (errors.isNotEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: errors.map((e) => Text(e)).toList(),
                                ));
                              });
                        }
                      },
                      child: const Text("Отправить")),
                ),
              ],
            ),
          )),
    );
  }
}

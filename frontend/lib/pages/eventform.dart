import 'package:flutter/material.dart';
import 'package:sstu_event_app/components/bottomnavbar.dart';
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

  final fInterval = const SizedBox(height: 15);
  final sInterval = const SizedBox(height: 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: Image.asset("assets/images/notify.png"))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: fkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        "Enter data in form for subscribe. We callback you after few time."),

                    sInterval,

                    const Text("What is your name?"),

                    sInterval,

                    // Имя
                    CustomInput(
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      placeholder: "First name",
                      inputFormatters: [NameFormatter.get()],
                      required: true,
                    ),

                    fInterval,

                    // Фамилия
                    CustomInput(
                      controller: secondNameController,
                      keyboardType: TextInputType.name,
                      placeholder: "Last name",
                      inputFormatters: [NameFormatter.get()],
                      required: true,
                    ),

                    fInterval,

                    // Отчество
                    CustomInput(
                      controller: thirdNameController,
                      keyboardType: TextInputType.name,
                      placeholder: "Middle name",
                      inputFormatters: [NameFormatter.get()],
                    ),

                    fInterval,

                    sInterval,

                    const Text("Where are you from?"),

                    sInterval,

                    // Учебное заведение
                    CustomInput(
                      controller: schoolController,
                      placeholder: "School",
                      required: true,
                    ),

                    fInterval,

                    sInterval,

                    const Text("How many kids want to visit us?"),

                    sInterval,

                    // Кол-во детей
                    CustomInput(
                      controller: countController,
                      keyboardType: countType,
                      placeholder: "Count",
                      inputFormatters: [IntMinMaxFormatter(min: 1, max: 100)],
                      required: true,
                    ),

                    sInterval,

                    const Text("What classes of children are coming to us?"),

                    sInterval,

                    // Класс(ы)
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      ConstrainedBox(
                          constraints:
                              const BoxConstraints.tightFor(width: 120),
                          child: CustomInput(
                            controller: class1Controller,
                            placeholder: "min",
                            keyboardType: countType,
                            required: true,
                            inputFormatters: [
                              IntMinMaxFormatter(min: 1, max: 11)
                            ],
                            onChanged: (value) {
                              setState(() {
                                if (class2Controller.text.isNotEmpty &&
                                    value.isNotEmpty &&
                                    int.parse(class2Controller.text) <=
                                        int.parse(value)) {
                                  class2Controller.clear();
                                }
                              });
                            },
                          )),
                      const SizedBox(width: 10.0),
                      const Text('-'),
                      const SizedBox(width: 10.0),
                      ConstrainedBox(
                          constraints:
                              const BoxConstraints.tightFor(width: 120),
                          child: CustomInput(
                            enabled: class1Controller.text.isNotEmpty &&
                                int.parse(class1Controller.text) != 11,
                            controller: class2Controller,
                            placeholder: 'max',
                            keyboardType: countType,
                            inputFormatters: [
                              EnumFormatter(values: [
                                "1",
                                "10",
                                ...List.generate(
                                    11 -
                                        (int.tryParse(class1Controller.text) ??
                                            11),
                                    (index) => (11 - index).toString())
                              ])
                            ],
                          ))
                    ]),

                    fInterval,

                    sInterval,

                    const Text("What is your phone number?"),

                    sInterval,

                    // Номер телефона
                    CustomInput(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      placeholder: "8 888 909-11-22",
                      inputFormatters: [LengthFormatter(length: 20)],
                      required: true,
                    ),

                    fInterval,

                    sInterval,

                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        constraints: const BoxConstraints.tightFor(height: 45),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            borderRadius: BorderRadius.circular(15)),
                        child: TextButton(
                            onPressed: () {
                              List<String> errors = [];

                              if (phoneController.text.isEmpty) {
                                errors.add("Empty phone number");
                              } else if (!RegExp(r"^(7|8)\d{10}$")
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

                              if (class1Controller.text.isEmpty) {
                                errors.add("Empty min class");
                              } else if (class2Controller.text.isNotEmpty &&
                                  int.parse(class2Controller.text) <=
                                      int.parse(class1Controller.text)) {
                                errors.add(
                                    "Max class must be less than min class");
                              }

                              if (errors.isNotEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children:
                                            errors.map((e) => Text(e)).toList(),
                                      ));
                                    });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Success")));
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              }
                            },
                            child: const Text("Отправить")),
                      )
                    ]),
                  ],
                ),
              )),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sstu_event_app/api/eventrequests.dart';
import 'package:sstu_event_app/components/bottomnavbar.dart';
import 'package:sstu_event_app/components/custominput.dart';
import 'package:sstu_event_app/formatters/enumformatter.dart';
import 'package:sstu_event_app/formatters/intminmaxformatter.dart';
import 'package:sstu_event_app/formatters/lengthformatter.dart';
import 'package:sstu_event_app/formatters/nameformatter.dart';
import 'package:sstu_event_app/models/eventrequest.dart';
import 'package:sstu_event_app/services/sharedpreferencesservice.dart';

class EventForm extends StatefulWidget {
  final String idEvent;

  const EventForm({super.key, required this.idEvent});

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
  bool _isChecked = false;

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
        title: const Text("Регистрация"),
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
                        "Введите данные в форму для регистрации на мероприятие. Мы свяжемся с вами позднее."),

                    sInterval,

                    const Text("Как вас зовут?"),

                    sInterval,

                    // Имя
                    CustomInput(
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      placeholder: "Имя",
                      inputFormatters: [NameFormatter.get()],
                      required: true,
                    ),

                    fInterval,

                    // Фамилия
                    CustomInput(
                      controller: secondNameController,
                      keyboardType: TextInputType.name,
                      placeholder: "Фамилия",
                      inputFormatters: [NameFormatter.get()],
                      required: true,
                    ),

                    fInterval,

                    // Отчество
                    CustomInput(
                      controller: thirdNameController,
                      keyboardType: TextInputType.name,
                      placeholder: "Отчество",
                      inputFormatters: [NameFormatter.get()],
                    ),

                    fInterval,

                    sInterval,

                    const Text("Откуда вы?"),

                    sInterval,

                    // Учебное заведение
                    CustomInput(
                      controller: schoolController,
                      placeholder: "Учебное заведение",
                      required: true,
                    ),

                    fInterval,

                    sInterval,

                    const Text("Сколько детей посетят нас?"),

                    sInterval,

                    // Кол-во детей
                    CustomInput(
                      controller: countController,
                      keyboardType: countType,
                      placeholder: "Количество детей",
                      inputFormatters: [IntMinMaxFormatter(min: 1, max: 100)],
                      required: true,
                    ),

                    sInterval,

                    const Text("Какие классы придут к нам?"),

                    sInterval,

                    // Класс(ы)
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      ConstrainedBox(
                          constraints:
                              const BoxConstraints.tightFor(width: 120),
                          child: CustomInput(
                            controller: class1Controller,
                            placeholder: "С",
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
                            placeholder: 'По',
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

                    const Text("Ваш номер телефона?"),

                    sInterval,

                    // Номер телефона
                    CustomInput(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      placeholder: "88889091122",
                      inputFormatters: [LengthFormatter(length: 20)],
                      required: true,
                    ),

                    fInterval,

                    sInterval,
                    CheckboxListTile(
                      title:const Text("Я родитель/опекун/официальный представитель даю согласие на обработку своих персональных данных и персональных данных ребенка согласно [политике] об обработке персональных данных"),
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false; // Обновляем состояние CheckBox
                        });
                      },
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
                                errors.add("Введите номер телефона");
                              } else if (!RegExp(r"^(7|8)\d{10}$")
                                  .hasMatch(phoneController.text)) {
                                errors.add("Номер телефона указан в неверном формате");
                              }

                              if (firstNameController.text.isEmpty) {
                                errors.add("Введите имя");
                              }

                              if (secondNameController.text.isEmpty) {
                                errors.add("Введите фамилию");
                              }

                              if (schoolController.text.isEmpty) {
                                errors.add("Введите название школы");
                              }

                              if (countController.text.isEmpty) {
                                errors.add("Введите количество детей");
                              }

                              if (class1Controller.text.isEmpty) {
                                errors.add("Введите минимальный класс");
                              } else if (class2Controller.text.isNotEmpty &&
                                  int.parse(class2Controller.text) <=
                                      int.parse(class1Controller.text)) {
                                errors.add(
                                    "Максимальный класс должен быть больше минимального");
                              }

                              if (!_isChecked) {
                                errors.add("Необходимо ваше согласие на обработку данных");
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
                                final evreq =EventRequest(
                                        secondName: secondNameController.text,
                                        firstName: firstNameController.text,
                                        middleName: thirdNameController.text,
                                        edu: schoolController.text,
                                        phone: phoneController.text,
                                        countChild:
                                            int.parse(countController.text),
                                        fromClass:
                                            int.parse(class1Controller.text),
                                        toClass: class2Controller
                                                .text.isNotEmpty
                                            ? int.parse(class2Controller.text)
                                            : null,
                                        idEvent: widget.idEvent,
                                        isRepresentative: _isChecked);
                                final serv = Sharedpreferencesservice.get();
                                EventRequestsAgent.add(evreq)
                                    .then((value) {
                                  if (value.statusCode == 201) {
                                    serv.addSubscriptions(evreq);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Вы зарегистрированы на мероприятие!")));
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                  }
                                  else if(value.statusCode == 422) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Проверьте корректность заполнения формы")));
                                  }
                                });
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
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

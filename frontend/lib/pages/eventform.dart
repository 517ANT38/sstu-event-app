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
  final classController = TextEditingController();

  final fkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: fkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Имя
              TextFormField(
                controller: firstNameController,
              ),
              const Text('Имя'),
              // Фамилия
              TextFormField(
                controller: secondNameController,
              ),
              const Text('Фамилия'),
              // Отчество
              TextFormField(
                controller: thirdNameController,
              ),
              const Text('Отчество'),
              // Учебное заведение
              TextFormField(
                controller: schoolController,
              ),
              const Text('Учебное заведение'),
              // Номер телефона
              TextFormField(
                controller: phoneController,
              ),
              const Text('Номер телефона'),
              // Кол-во детей
              TextFormField(
                controller: countController,
              ),
              const Text('Кол-во детей'),
              // Класс(ы)
              TextFormField(
                controller: classController,
              ),
              const Text('Класс(ы)'),

              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextButton(
                    onPressed: () => {if (fkey.currentState!.validate()) {}},
                    child: const Text("Отправить")),
              )
            ],
          ),
        ));
  }
}

class EventRequest {
  final String secondName;
  final String firstName;
  final String middleName;
  final String edu;
  final String phone;
  final int countChild;
  final int fromClass;
  final int toClass;

  EventRequest(
      {required this.secondName,
      required this.firstName,
      required this.middleName,
      required this.edu,
      required this.phone,
      required this.countChild,
      required this.fromClass,
      required this.toClass});

  factory EventRequest.fromJson(Map<String, dynamic> data) {
    return switch (data) {
      {
        'firstName': String firstName,
        'secondName': String secondName,
        'middleName': String middleName,
        'edu': String edu,
        'phone': String phone,
        'countChild': int countChild,
        'fromClass': int fromClass,
        'toClass': int toClass
      } =>
        EventRequest(
            secondName: secondName,
            firstName: firstName,
            middleName: middleName,
            edu: edu,
            phone: phone,
            countChild: countChild,
            fromClass: fromClass,
            toClass: toClass),
      _ => throw const FormatException("Failed to load EventRequest")
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "secondName": secondName,
      "middleName": middleName,
      "edu": edu,
      "phone": phone,
      "countChild": countChild,
      "fromClass": fromClass,
      "toClass": toClass
    };
  }
}
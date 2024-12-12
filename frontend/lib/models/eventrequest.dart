class EventRequest {
  final String secondName;
  final String firstName;
  final String? middleName;
  final String edu;
  final String phone;
  final int countChild;
  final int fromClass;
  final int? toClass;
  final String idEvent;
  final bool isRepresentative;

  EventRequest(
      {required this.secondName,
      required this.firstName,
      this.middleName,
      required this.edu,
      required this.phone,
      required this.countChild,
      required this.fromClass,
      this.toClass,
      required this.idEvent,
      required this.isRepresentative
      });

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
        'toClass': int toClass,
        'idEvent': String idEvent,
        'isRepresentative':bool isRepresentative
      } =>
        EventRequest(
            secondName: secondName,
            firstName: firstName,
            middleName: middleName,
            edu: edu,
            phone: phone,
            countChild: countChild,
            fromClass: fromClass,
            toClass: toClass,
            idEvent: idEvent,
            isRepresentative: isRepresentative
            ),
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
      "toClass": toClass,
      "idEvent": idEvent,
      "isRepresentative": isRepresentative
    };
  }
}

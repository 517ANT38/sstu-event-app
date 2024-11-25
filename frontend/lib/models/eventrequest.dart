class EventRequest {
  final String secondName;
  final String firstName;
  final String middleName;
  final String edu;
  final String phone;
  final String countChild;
  final String fromClass;
  final String toClass;

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
    return EventRequest(
      firstName: data['firstName'] as String,
      secondName: data['secondName'] as String,
      middleName: data['middleName'] as String,
      edu: data['edu'] as String,
      phone: data['phone'] as String,
      countChild: data['countChild'] as String,
      fromClass: data['fromClass'] as String,
      toClass: data['toClass'] as String,
    );
  }
}

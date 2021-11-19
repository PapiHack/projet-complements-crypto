import 'models.dart';

class User {
  final int id;
  final String name;
  final String phoneNumber;
  final String pin;
  final List<CodeOTP> codes; 

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.pin,
    required this.codes,
  });

  factory User.fromJSON(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      pin: data['pin'],
      codes: CodeOTP.resolveList(data['codes']),
    );
  }

  Map<String, dynamic> toJSON() => {
    'id': this.id,
    'name': this.name,
    'phoneNumber': this.phoneNumber,
    'codes': (this.codes.map((codeOTP) => codeOTP.toJSON())).toList(),
  };

  static List<User> resolveList(List<dynamic> data) {
    List<User> users = [];
    data.forEach(
      (user) {
        users.add(User.fromJSON(user));
      },
    );
    return users;
  }

}
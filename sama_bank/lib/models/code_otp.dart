import 'models.dart';

class CodeOTP {
  final int id;
  final String code;
  final bool isUsed;
  final User user;

  CodeOTP({
    required this.id,
    required this.code,
    required this.isUsed,
    required this.user,
  });

  factory CodeOTP.fromJSON(Map<String, dynamic> data) {
    return CodeOTP(
      id: data['id'],
      code: data['code'],
      isUsed: data['isUsed'],
      user: User.fromJSON(data['client']),
    );
  }

  Map<String, dynamic> toJSON() => {
    'id': this.id,
    'code': this.code,
    'isUsed': this.isUsed,
    'client': this.user.toJSON(),
  };

  static List<CodeOTP> resolveList(List<dynamic> data) {
    List<CodeOTP> codes = [];
    data.forEach(
      (codeOTP) {
        codes.add(CodeOTP.fromJSON(codeOTP));
      },
    );
    return codes;
  }
}
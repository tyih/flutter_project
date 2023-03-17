class LoginModel {
  String? userName;
  int? id;

  LoginModel.fromJson(Map<String, dynamic> json)
      : userName = json.containsKey('userName') ? json['userName'] : null,
        id = json.containsKey('id') ? json['id'] : null;
}

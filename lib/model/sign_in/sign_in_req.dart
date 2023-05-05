class SignInReqModel {
  SignInReqModel({required this.phone, required this.password});
  String phone;
  String password;
  factory SignInReqModel.fromJson(Map<String, dynamic> json) =>
      SignInReqModel(phone: json["phone_no"], password: json["password"]);
  Map<String, dynamic> toJson() => {"phone_no": phone, "password": password};
}

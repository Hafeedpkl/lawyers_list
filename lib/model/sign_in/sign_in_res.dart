class SignInResModel {
  SignInResModel({required this.message, required this.token});
  String message;
  String token;
  factory SignInResModel.fromJson(Map<String, dynamic> json) =>
      SignInResModel(message: json['message'], token: json["access_token"]);
  Map<String, dynamic> tojson() => {"message": message, "access_token": token};
}

// To parse this JSON data, do
//
//     final loginError = loginErrorFromJson(jsonString);

import 'dart:convert';

LoginError loginErrorFromJson(String str) => LoginError.fromJson(json.decode(str));

String loginErrorToJson(LoginError data) => json.encode(data.toJson());

class LoginError {
  Error error;

  LoginError({
    required this.error,
  });

  factory LoginError.fromJson(Map<String, dynamic> json) => LoginError(
    error: Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error.toJson(),
  };
}

class Error {
  String code;
  String message;

  Error({
    required this.code,
    required this.message,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}

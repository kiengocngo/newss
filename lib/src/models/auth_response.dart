class AuthResponse {
  bool isSuccess;
  String data;
  AuthResponse({
    required this.isSuccess,
    required this.data,
  });
}

class SignUpResponse {
  bool isSuccess;
  String uid;
  SignUpResponse({
    required this.isSuccess,
    required this.uid,
  });
}

class UpdateResponse {
  bool isSuccess;
  String message;
  UpdateResponse({
    required this.isSuccess,
    required this.message,
  });
}

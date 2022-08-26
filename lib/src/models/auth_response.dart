import 'package:news_app/src/models/my_user.dart';

class AuthResponse {
  bool isSuccess;
  String data;
  AuthResponse({
    required this.isSuccess,
    required this.data,
  });
}

class FriendsListResponse {
  bool isSuccess;
  List<String> friends;
  FriendsListResponse({
    required this.isSuccess,
    required this.friends,
  });
}

class SearchResponse {
  bool isSuccess;
  List<MyUser> data;
  SearchResponse({
    required this.isSuccess,
    required this.data,
  });


}

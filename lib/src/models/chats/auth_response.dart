import 'package:news_app/src/models/chats/friends_models.dart';
import 'package:news_app/src/models/chats/my_user.dart';

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

class FriendsResponse {
  bool isSuccess;
  List<FriendModel> friendModel;
  FriendsResponse({
    required this.isSuccess,
    required this.friendModel,
  });
}

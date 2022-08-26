import 'package:news_app/src/models/chats/friends_models.dart';
import 'package:news_app/src/models/chats/my_user.dart';

class AuthResponse {
  final bool isSuccess;
  final String data;
  const AuthResponse({
    required this.isSuccess,
    required this.data,
  });
}

class FriendsListResponse {
  final bool isSuccess;
  final List<String> friends;
  const FriendsListResponse({
    required this.isSuccess,
    required this.friends,
  });
}

class SearchResponse {
  final bool isSuccess;
  final List<MyUser> data;
  const SearchResponse({
    required this.isSuccess,
    required this.data,
  });
}

class FriendsResponse {
  final bool isSuccess;
  final List<FriendModel> friendModel;
  const FriendsResponse({
    required this.isSuccess,
    required this.friendModel,
  });
}

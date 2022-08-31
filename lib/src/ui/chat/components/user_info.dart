import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/friend_request_bloc/friend_request_bloc.dart';
import 'package:news_app/services/firebase_services/firestore_services.dart';
import 'package:news_app/src/models/chats/user_details_screen_model.dart';
import 'package:news_app/src/ui/chat/screens/user_details.dart';

class UserInfo extends StatelessWidget {
  final String userName;
  final String userImage;
  final String userUid;
  final String detailUserUid;
  const UserInfo({
    Key? key,
    required this.userName,
    required this.userImage,
    required this.userUid,
    required this.detailUserUid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onChangeToUserDetails(context);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              size: const Size(50, 50), // Image radius
              child: Image.memory(
                base64.decode(
                  userImage,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          BlocBuilder<FriendRequestBloc, FriendRequestState>(
            builder: (context, state) {
              return Text(
                userName,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              );
            },
          ),
        ],
      ),
    );
  }

  _onChangeToUserDetails(BuildContext context) async {
    context.read<FriendRequestBloc>().add(FriendRequestEventInit(
        currentUserUid: userUid, targetUserUid: detailUserUid));
    final tmp = await FireStoreService().getUserByUid(userUid);
    if (tmp.isSuccess) {
      final UserDetailsModel userDetailsModel = UserDetailsModel(
        currentUserName: tmp.data.first.name,
        currentUserUid: userUid,
        detailsUserUid: detailUserUid,
        detailsUserName: userName,
        detailsUserImage: userImage,
        image: tmp.data.first.base64Image,
      );

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserDetails(
                  userDetailsModel: userDetailsModel,
                )),
      );
    }
  }
}

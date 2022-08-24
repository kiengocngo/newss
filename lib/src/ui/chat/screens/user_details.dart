import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/friend_request_bloc/friend_request_bloc.dart';

class UserDetails extends StatelessWidget {
  String image;
  String currentUserUid;
  String detailsUserUid;
  String userName;
  List<String> currentUserList;
  List<String> userNameFriends;
  UserDetails({
    Key? key,
    required this.image,
    required this.currentUserUid,
    required this.detailsUserUid,
    required this.userName,
    required this.currentUserList,
    required this.userNameFriends,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size(50, 50), // Image radius
                child: Image.memory(
                  base64.decode(
                    image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BlocBuilder<FriendRequestBloc, FriendRequestState>(
              builder: (context, state) {
                switch (state.status) {
                  case FriendState.noRequest:
                    return InkWell(
                      onTap: () {
                        context.read<FriendRequestBloc>().add(
                            FriendRequestEventSubmit(
                                firstUid: currentUserUid,
                                secondUid: detailsUserUid));
                      },
                      child: Text("Add"),
                    );
                  case FriendState.firstRequest:
                    return Text("Request has sended");

                  case FriendState.seccondRequest:
                    return InkWell(
                      onTap: () {
                        context.read<FriendRequestBloc>().add(
                            FriendRequestEventSubmit(
                                firstUid: currentUserUid,
                                secondUid: detailsUserUid));
                      },
                      child: Text("Accept ?"),
                    );
                  case FriendState.accept:
                    return Text("you guys are friend");
                  default:
                    return Icon(Icons.error);
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}

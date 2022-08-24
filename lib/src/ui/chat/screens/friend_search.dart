import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:news_app/blocs/friend_search_bloc/friend_search_bloc.dart';
import 'package:news_app/src/components/input_text/text_field.dart';
import 'package:news_app/src/ui/chat/components/user_info.dart';

// ignore: must_be_immutable
class FriendSearch extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  String uid;
  FriendSearch({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(CupertinoIcons.back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextInputField(
                text: "Enter name here",
                type: TextInputType.text,
                prefixIcon: const Icon(Icons.search),
                controller: _searchController),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<FriendSearchBloc>()
                      .add(FriendSearchSubmit(name: _searchController.text));
                },
                child: const Text("Submit")),
            BlocBuilder<FriendSearchBloc, FriendSearchState>(
              builder: (context, state) {
                switch (state.searchStatus) {
                  case SearchStatus.init:
                    return Container();
                  case SearchStatus.loading:
                    return const Center(
                        child: SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 50.0,
                    ));
                  case SearchStatus.loaded:
                    return SizedBox(
                      height: size.height * 0.7,
                      child: ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          log("uid in friend search $uid");
                          return UserInfo(
                            userUid: uid,
                            userName: state.users[index].name,
                            userImage: state.users[index].base64Image,
                            detailUserUid: state.users[index].uid,
                          );
                        },
                      ),
                    );
                  default:
                    return const Text(
                      "error",
                      style: TextStyle(color: Colors.white),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

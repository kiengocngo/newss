import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:news_app/blocs/friend_search_bloc/friend_search_bloc.dart';
import 'package:news_app/src/components/constant.dart';
import 'package:news_app/src/components/input_text/text_field.dart';
import 'package:news_app/src/ui/chat/components/user_info.dart';
import 'package:news_app/theme/news_theme_data.dart';

class FriendSearch extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final String uid;
  FriendSearch({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Search",
          style: NewsThemeData.fromContext(context).textAppBar,
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        bottomOpacity: 0.0,
        elevation: 0.25,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              TextInputField(
                  text: "Enter name here",
                  type: TextInputType.text,
                  prefixIcon: const Icon(Icons.search),
                  controller: _searchController),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<FriendSearchBloc>()
                        .add(FriendSearchSubmit(name: _searchController.text));
                  },
                  child: Text(
                    "Submit",
                    style: NewsThemeData.fromContext(context).textButton,
                  )),
              BlocBuilder<FriendSearchBloc, FriendSearchState>(
                builder: (context, state) {
                  switch (state.searchStatus) {
                    case CustomStatus.init:
                      return Container();
                    case CustomStatus.loading:
                      return const Center(
                          child: SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 50.0,
                      ));
                    case CustomStatus.loaded:
                      return SizedBox(
                        height: size.height * 0.7,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 12,
                            );
                          },
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
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
      ),
    );
  }
}

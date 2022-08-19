import 'package:flutter/material.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _adddressController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nameController.text = 'ngo ngoc kien';
    _phoneController.text = '0123456789';
    _adddressController.text = 'Ha Noi';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Center(
              child: CircleAvatar(
                radius: 50,
                // backgroundImage: ,
                backgroundColor: Colors.blue,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () {},
            child: Container(
                height: size.height * 0.05,
                width: size.width * 0.4,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    gradient: NewsColor.tuGradient),
                child: Center(
                    child: Text(
                  "Choose your image",
                  style: NewsThemeData.fromContext(context).textTButton,
                ))),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
                label: Text(
                  'Name',
                  style: NewsThemeData.fromContext(context).textTButton,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
                label: Text(
                  'Phone',
                  style: NewsThemeData.fromContext(context).textTButton,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _adddressController,
            decoration: InputDecoration(
                label: Text(
                  'Address',
                  style: NewsThemeData.fromContext(context).textTButton,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {},
            child: Center(
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(16)),
                child: const Center(
                    child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

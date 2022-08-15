import 'package:flutter/material.dart';
// ignore: must_be_immutable
class SenderMessage extends StatelessWidget {
  String sendMessage;
 
  SenderMessage({
    Key? key,
    required this.sendMessage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                 borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
        ),
               border: Border.all(color: Colors.blueAccent),
                color: Colors.blue[300]),
               constraints: BoxConstraints(maxWidth: size.width*0.8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(sendMessage),
                )),
            const Text("Aug 15,2022",style: TextStyle(color: Colors.grey),),
          ],
        ),
      ),
    );
  }
}

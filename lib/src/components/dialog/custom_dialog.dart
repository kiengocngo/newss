import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  final String title, descriptions, okText, cancelText;
  final VoidCallback okHandle;

  final Image img;

  const CustomDialogBox(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.okText,
      required this.cancelText,
      required this.img,
      required this.okHandle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(left: 20, top: 64, right: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                descriptions,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                        onTap: okHandle,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1 / 4,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(width: 0.25, color: Colors.grey)),
                          child: Center(
                            child: Text(
                              okText,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1 / 4,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(width: 0.25, color: Colors.grey)),
                          child: Center(
                            child: Text(
                              cancelText,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                child: img),
          ),
        ),
      ],
    );
  }
}

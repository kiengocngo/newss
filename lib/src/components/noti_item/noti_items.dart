import 'package:flutter/material.dart';

class NotiItems extends StatelessWidget {
  final String title;
  final DateTime dataTime;
  final String image;
  final String body;
  final VoidCallback onTap;
  const NotiItems(
      {Key? key,
      required this.title,
      required this.dataTime,
      required this.image,
      required this.body,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              width: 0.25, color: const Color.fromARGB(255, 246, 233, 184)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.green),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    dataTime.toString(),
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(body),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

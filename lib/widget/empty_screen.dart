import 'package:flutter/material.dart';

class EmptyNewWidget extends StatelessWidget {
  const EmptyNewWidget({super.key, required this.text, required this.imagePath});

  final String text, imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Image.asset(imagePath),
        ),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }
}

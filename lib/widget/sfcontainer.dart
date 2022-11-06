import 'package:flutter/material.dart';

class SfContainer extends StatelessWidget {
  const SfContainer({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 210,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade900),
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(.5),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 10,
            child: Text(
              title,
              style: const TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

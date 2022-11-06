import 'package:flutter/material.dart';

class ContainerBackgraund extends StatelessWidget {
  const ContainerBackgraund({Key? key, required this.altura}) : super(key: key);
  final double altura;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.955,
      height: altura,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 2, color: Colors.green),
      ),
    );
  }
}

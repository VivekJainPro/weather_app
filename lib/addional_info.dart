import 'package:flutter/material.dart';

class AddInfo extends StatelessWidget {
  final String infoOf;
  final IconData icun;
  final String data;

  const AddInfo({
    super.key,
    required this.infoOf,
    required this.icun,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      // width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icun,
            size: 50,
          ),
          Text(
            infoOf,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            data,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          )
        ],
      ),
    );
  }
}

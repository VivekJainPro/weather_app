import "package:flutter/material.dart";

class HourlyForecast extends StatelessWidget {
  final String time;
  final IconData icun;
  final String data;
  const HourlyForecast(
      {super.key, required this.data, required this.icun, required this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        shadowColor: const Color.fromARGB(255, 2, 2, 2),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(children: [
            Text(
              time,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Icon(
              icun,
              size: 50,
            ),
            Text(
              data,
              textAlign: TextAlign.center,
              style: const TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ]),
        ),
      ),
    );
  }
}

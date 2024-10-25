import 'package:flutter/material.dart';

class TopicOfTheHourWidget extends StatelessWidget {
  const TopicOfTheHourWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          ),
          height: 250,
        ),
        Positioned(
          left: 10,
          top: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.6),
            ),
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: Text('topic of the hour'),
            ),
          ),
        ),
        const Positioned(
          left: 10,
          bottom: 10,
          child: Text(
            'Title',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class RequestTabStatus extends StatelessWidget {
  final String title;
  final IconData icon;

  const RequestTabStatus({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 7),
          Text(title),
        ],
      ),
    );
  }
}

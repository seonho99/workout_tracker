import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  Icon icon;
  Text title;
  Text info;
  Color? backgroundColor;
  DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.info,
    this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColor??Colors.grey.shade300,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  icon,
                  SizedBox(width: 10),
                  title,
                ],
              ),
            ],
          ),
          Expanded(
            child: Center(
                child: info
            ),
          ),
        ],
      ),
    );
  }
}


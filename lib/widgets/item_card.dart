import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {

  ItemCard({super.key, required this.title, required this.color, this.rightWidget, required this.callback, this.textColor});

  final Color color;
  final Color? textColor;
  final String title;
  final Widget? rightWidget;
  final Function() callback;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 60,
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 24),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: textColor??Colors.black54,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 24),
              child: rightWidget,
            )
          ],
        ),
      ),
    );
  }
}
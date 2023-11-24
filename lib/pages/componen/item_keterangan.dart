import 'package:flutter/material.dart';

class ItemKeterangan extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;
  ItemKeterangan(
      {required this.icon, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 60,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(height: 0, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

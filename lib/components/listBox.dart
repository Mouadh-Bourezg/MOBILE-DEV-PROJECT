import 'package:flutter/material.dart';

class ListBox extends StatefulWidget {
  const ListBox({super.key});

  @override
  State<ListBox> createState() => _ListBoxState();
}

class _ListBoxState extends State<ListBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          Container(
            height: 110,
            width: double.infinity, // Ensure the width is constrained
            clipBehavior: Clip.hardEdge, // Prevent overflow
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Match the parent's borderRadius
            ),
            child: FittedBox(
              fit: BoxFit.cover, // Keeps aspect ratio while covering the container
              child: Image.asset('assets/glasses-1052010_640.jpg'),
            ),
          ),
          Container(
            height: 46,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title of the list'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DocumentActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ActionIcon(icon: Icons.download, label: 'Download (0.3MB)'),
        //ActionIcon(icon: Icons.save, label: 'Save'),
        ActionIcon(icon: Icons.playlist_add, label: 'Add to list'),
      ],
    );
  }
}

class ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  ActionIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.black),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import './components/listBox.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  String? listName; // Store the input list name.

  void _showCreateListDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create a New List'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Enter list name'),
            onChanged: (value) {
              setState(() {
                listName = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog.
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform list creation logic
                if (listName != null && listName!.trim().isNotEmpty) {
                  //todo: Add logic for adding the new list
                  print('List created: $listName'); // Replace with your logic.
                  listName = null;
                  Navigator.of(context).pop(); // Close the dialog.
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid list name.')),
                  );
                }
              },
              child: Text('Create List'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          GestureDetector(
            onTap: _showCreateListDialog,
            child: ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Create a List'),
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          ListBox(),
        ],
      ),
    );
  }
}

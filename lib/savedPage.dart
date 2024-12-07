import 'package:flutter/material.dart';
import 'components/listBox.dart';
import 'components/bottomBar.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  String? listName; // Store the input list name.
  List<String> savedLists = [
    'Demo List 1',
    'Demo List 2',
    'Demo List 3'
  ]; // Store the saved lists

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
                  savedLists.add(listName!.trim());
                  print('List created: $listName'); // Replace with your logic.
                  listName = null;
                  Navigator.of(context).pop(); // Close the dialog.
                  setState(() {});
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
      appBar: AppBar(
        title: Text('Saved'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
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
          Column(
            children: savedLists.map((listName) {
              return DocumentCard(
                title: listName,
                uploaderName:
                    'Uploader Name', // Replace with actual uploader name
                imageUrl:
                    'assets/glasses-1052010_640.jpg', // Replace with actual image URL
                status: 'continueReading', // Replace with actual status
              );
            }).toList(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3, // Update index for saved page
        onItemSelected: (index) {
          setState(() {
            // Handle navigation
          });
        },
      ),
    );
  }
}

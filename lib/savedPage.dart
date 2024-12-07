import 'package:flutter/material.dart';
import 'components/listBox.dart';
import 'components/bottomBar.dart';
import 'components/documentCardInList.dart'; // Import the new component

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  static Map<String, List<Map<String, String>>> savedLists = {
    'Demo List 1': [],
    'Demo List 2': [],
    'Demo List 3': []
  }; // Store the saved lists with documents

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
            decoration: InputDecoration(
              hintText: 'Enter list name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                listName = value;
              });
            },
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // Text color
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog.
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Button color
                foregroundColor: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Perform list creation logic
                if (listName != null && listName!.trim().isNotEmpty) {
                  SavedPage.savedLists[listName!.trim()] = [];
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

  void _navigateToListDetails(String listName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListDetailsPage(listName: listName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          SizedBox(height: 20),
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
            children: SavedPage.savedLists.keys.map((listName) {
              return GestureDetector(
                onTap: () => _navigateToListDetails(listName),
                child: DocumentCard(
                  title: listName,
                  numberoftitles: SavedPage.savedLists[listName]?.length ?? 0,
                  imageUrl:
                      'assets/glasses-1052010_640.jpg', // Replace with actual image URL
                ),
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

class ListDetailsPage extends StatelessWidget {
  final String listName;

  const ListDetailsPage({required this.listName});

  @override
  Widget build(BuildContext context) {
    final documents = SavedPage.savedLists[listName] ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(listName),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: documents.map((document) {
          return DocumentCardInList(
            title: document['title'] ?? 'Unknown Title',
            uploaderName: document['uploaderName'] ?? 'Unknown Uploader',
            description: document['description'] ?? 'No Description',
            imageUrl: document['imageUrl'] ?? '',
            status: document['status'] ?? 'readNow',
          );
        }).toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'components/DocumentHeader.dart';
import 'components/DocumentActions.dart';
import 'components/DocumentDetails.dart';
import 'components/DocumentTags.dart';
import 'components/DocumentDescription.dart';
import 'components/CustomAppBar.dart';
import 'styles.dart';
import 'components/bottomBar.dart';
import 'screens/pdf_reader_page.dart'; // Import the PdfReaderPage
import 'savedPage.dart'; // Import SavedPage to access savedLists

class DocumentPage2 extends StatelessWidget {
  static final pageRoute = '/DocumentPage';
  final Map<String, String> document;
  final int currentIndex;

  DocumentPage2({required this.document, required this.currentIndex});

  void _showAddToListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add to List'),
          content: Container(
            width: double.minPositive,
            child: ListView(
              shrinkWrap: true,
              children: SavedPage.savedLists.keys.map((listName) {
                return ListTile(
                  title: Text(listName),
                  onTap: () {
                    try {
                      // Check if the document title already exists in the selected list
                      bool exists = SavedPage.savedLists[listName]!.any((doc) => doc['title'] == document['title']);
                      if (exists) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Document already exists in $listName')),
                        );
                      } else {
                        // Add document to the selected list
                        SavedPage.savedLists[listName]?.add({
                          'title': document['title'] ?? 'Unknown Title',
                          'uploaderName': document['uploaderName'] ?? 'Unknown Uploader',
                          'description': document['description'] ?? 'No Description',
                          'imageUrl': document['imageUrl'] ?? '',
                          'status': 'readNow',
                        });
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Document added to $listName')),
                        );
                      }
                    } catch (e) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Something went wrong')),
                      );
                    }
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          DocumentHeader(document: document),
          SizedBox(height: 16),
          DocumentActions(
            onAddToList: () => _showAddToListDialog(context),
          ),
          Divider(height: 32, thickness: 1, color: Colors.black26),
          DocumentDetails(),
          SizedBox(height: 8),
          DocumentTags(),
          Divider(height: 32, thickness: 1, color: Colors.black26),
          DocumentDescription(),
          
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<String> _loadPdfFromAssets(String assetPath) async {
    final fileName = assetPath.split('/').last;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');

    if (!await file.exists()) {
      ByteData bytes = await rootBundle.load(assetPath);
      await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
    }

    return file.path;
  }
}

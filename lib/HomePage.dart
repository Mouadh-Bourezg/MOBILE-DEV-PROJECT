import 'package:flutter/material.dart';
import 'components/DocumentCard.dart';
import 'components/bottomBar.dart';
import 'documentPage2.dart';

class HomePage extends StatefulWidget {
  static final pageRoute = '/HomePage';
  final bool showBottomBar;

  HomePage({this.showBottomBar = true});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Map<String, String>> documents = [
    {
      "title": "Business Plan - Template: Professional",
      "uploader": "Anes Abderrahim Chahira",
      "imageUrl": "data:image/jpeg;base64,...", // Truncated for brevity
    },
    {
      "title": "Market Analysis Report",
      "uploader": "John Doe",
      "imageUrl": "data:image/jpeg;base64,...", // Truncated for brevity
    },
    {
      "title": "Startup Guide",
      "uploader": "Jane Smith",
      "imageUrl": "data:image/jpeg;base64,...", // Truncated for brevity
    },
    // Add more documents as needed
  ];

  void _navigateToDocumentPage(Map<String, String> document) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocumentPage2(document: document, currentIndex: _currentIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildCategory("Latest Uploads"),
                  _buildDocumentRow(),
                  SizedBox(height: 16),
                  _buildCategory("Saved Documents"),
                  _buildDocumentRow(),
                  SizedBox(height: 16),
                  _buildCategory("Recommended"),
                  _buildDocumentRow(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: 430,
      height: 130,
      alignment: Alignment.center,
      child: Image.asset(
        '../assets/logo.png', // Replace with your logo asset path
        width: 120,
        height: 110,
      ),
    );
  }

  Widget _buildCategory(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
      ),
    );
  }

  Widget _buildDocumentRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: documents.map((doc) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => _navigateToDocumentPage(doc),
              child: DocumentCard(
                title: doc["title"]!,
                uploaderName: doc["uploader"]!,
                imageUrl: doc["imageUrl"]!,
                isPdf: true,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

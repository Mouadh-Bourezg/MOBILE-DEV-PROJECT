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
      "imageUrl": "../assets/glasses-1052010_640.jpg",
    },
    {
      "title": "Market Analysis Report",
      "uploader": "John Doe",
      "imageUrl": "../assets/glasses-1052010_640.jpg",
    },
    {
      "title": "Startup Guide",
      "uploader": "Jane Smith",
      "imageUrl": "../assets/glasses-1052010_640.jpg",
    },
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
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          // Optionally handle scroll events here
          return false;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 130.0,
              floating: false,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate the collapse progress
                  double collapseProgress =
                  (1.0 - (constraints.maxHeight - kToolbarHeight) / (130.0 - kToolbarHeight))
                      .clamp(0.0, 1.0);

                  return Stack(
                    children: [
                      // Logo (fades out as scrolling progresses)
                      Opacity(
                        opacity: (1.0 - collapseProgress).clamp(0.0, 1.0),
                        child: Center(
                          child: Image.asset(
                            '../assets/logo.png',
                            width: 120,
                            height: 110,
                          ),
                        ),
                      ),
                      // App name (fades in as scrolling progresses)
                      Opacity(
                        opacity: collapseProgress,
                        child: Center(
                          child: Text(
                            'BiblioMate',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // Main content
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 10),
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
      bottomNavigationBar: widget.showBottomBar
          ? CustomBottomNavigationBar(
              currentIndex: _currentIndex,
              onItemSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            )
          : null,
    );
  }

  Widget _buildCategory(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black,
        ),
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

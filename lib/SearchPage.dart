import 'package:flutter/material.dart';
import 'components/DocumentCard.dart';
import 'components/bottomBar.dart';
import 'styles.dart';
import 'documentPage2.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _showResults = false;
  List<Map<String, String>> _searchResults = [];
  int _currentIndex = 1;

  final List<Map<String, String>> documents = [
    {
      "title": "Business Plan - Template: Professional",
      "uploader": "Anes Abderrahim Chahira",
      "description": "A comprehensive business plan template.",
      "imageUrl": "data:image/jpeg;base64,...", // Truncated for brevity
    },
    {
      "title": "Market Analysis Report",
      "uploader": "John Doe",
      "description": "Detailed market analysis report.",
      "imageUrl": "data:image/jpeg;base64,...", // Truncated for brevity
    },
    {
      "title": "Startup Guide",
      "uploader": "Jane Smith",
      "description": "A guide for startups.",
      "imageUrl": "data:image/jpeg;base64,...", // Truncated for brevity
    },
    // Add more documents as needed
  ];

  void _onSearchChanged(String query) {
    setState(() {
      _showResults = query.isNotEmpty;
      _searchResults = documents
          .where((doc) =>
              doc["title"]!.toLowerCase().contains(query.toLowerCase()) ||
              doc["uploader"]!.toLowerCase().contains(query.toLowerCase()) ||
              doc["description"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _showResults = false;
    });
  }

  void _navigateToDocumentPage(Map<String, String> document) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DocumentPage2(document: document, currentIndex: _currentIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          // Search Bar
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: "Title, author, genre, topic",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 0.5, color: Colors.black), // Enabled border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 2, color: Colors.orange), // Focused border
                ),
                prefixIcon: Icon(Icons.search, color: Colors.orange),
                fillColor: Colors.white,
                suffixIcon: _showResults
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: _clearSearch,
                      )
                    : null,
              ),
              cursorColor: Colors.orange,
              cursorWidth: 0.7,

            ),
          ),
          // Category List or Search Results
          Expanded(
            child: Container(
              color: Colors.white,
              child: _showResults
                  ? ListView(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      children: _searchResults.map((doc) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
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
                    )
                  : ListView.builder(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      itemCount: 10, // Example category count
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            "Category $index",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            // Placeholder for action when a category is tapped
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Tapped on Category $index")),
                            );
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
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
}

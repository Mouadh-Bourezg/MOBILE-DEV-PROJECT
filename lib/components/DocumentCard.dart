import 'package:flutter/material.dart';

class DocumentCard extends StatelessWidget {
  final String title;
  final String uploaderName;
  final String imageUrl;
  final bool isPdf;

  DocumentCard({
    required this.title,
    required this.uploaderName,
    required this.imageUrl,
    this.isPdf = false,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Set fixed height and width for the card as a fraction of the screen size
    final cardHeight = screenHeight * 0.45; // 30% of screen height
    final cardWidth = screenWidth * 0.3; // 40% of screen width

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  height: cardHeight * 0.6, // Set image height as a percentage of card height
                  width: cardWidth,
                  fit: BoxFit.cover, // Ensures tall images are cropped to fit
                  errorBuilder: (context, error, stackTrace) {
                    // Placeholder if the image fails to load
                    return Container(
                      height: cardHeight * 0.6,
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (isPdf)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      'PDF',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'Uploaded by: $uploaderName',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

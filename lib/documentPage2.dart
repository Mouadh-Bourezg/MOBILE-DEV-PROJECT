import 'package:flutter/material.dart';
import 'components/DocumentHeader.dart';
import 'components/DocumentActions.dart';
import 'components/DocumentDetails.dart';
import 'components/DocumentTags.dart';
import 'components/DocumentDescription.dart';
import 'components/ReviewContainer.dart';
import 'components/bottomBar.dart';
import 'components/CustomAppBar.dart';
import 'styles.dart';

class DocumentPage2 extends StatelessWidget {
  static final pageRoute = '/DocumentPage';
  final Map<String, String> document;
  final int currentIndex;

  DocumentPage2({required this.document, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          DocumentHeader(document: document),
          SizedBox(height: 16),
          DocumentActions(),
          Divider(height: 32, thickness: 1, color: Colors.black26),
          DocumentDetails(),
          SizedBox(height: 8),
          DocumentTags(),
          Divider(height: 32, thickness: 1, color: Colors.black26),
          DocumentDescription(),
          Divider(height: 32, thickness: 1, color: Colors.black26),
          SizedBox(height: 16),
          ReviewContainer(),
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
}

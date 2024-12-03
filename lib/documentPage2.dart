import 'package:flutter/material.dart';
import 'components/DocumentHeader.dart';
import 'components/DocumentActions.dart';
import 'components/DocumentDetails.dart';
import 'components/DocumentTags.dart';
import 'components/DocumentDescription.dart';
import 'components/ReviewContainer.dart';

class DocumentPage2 extends StatelessWidget {
  static final pageRoute = '/DocumentPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          DocumentHeader(),
          SizedBox(height: 16),
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
    );
  }
}

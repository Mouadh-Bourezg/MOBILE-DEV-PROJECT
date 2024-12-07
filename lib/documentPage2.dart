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
import 'components/ReviewContainer.dart';
import 'components/CustomAppBar.dart';
import 'styles.dart';
import 'components/bottomBar.dart';
import 'screens/pdf_reader_page.dart'; // Import the PdfReaderPage

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
          ElevatedButton(
            onPressed: () async {
              String pdfPath = await _loadPdfFromAssets('assets/demo.pdf');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfReaderPage(pdfPath: pdfPath),
                ),
              );
            },
            child: Text('Read Now'),
          ),
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

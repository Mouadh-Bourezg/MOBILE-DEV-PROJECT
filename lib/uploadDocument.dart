import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'components/bottomBar.dart';
import 'styles.dart';

class uploadDocumentPage extends StatefulWidget {
  @override
  _uploadDocumentPageState createState() => _uploadDocumentPageState();
}

class _uploadDocumentPageState extends State<uploadDocumentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  String? _uploadedFilePath;
  int _currentIndex = 2;

  final List<String> _categories = [
    "Software Engineering",
    "Data Science",
    "Mathematics",
    "Physics",
  ];

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _uploadedFilePath = result.files.single.path;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("File selected: ${result.files.single.name}"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No file selected."),
        ),
      );
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_uploadedFilePath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please upload a PDF document."),
          ),
        );
        return;
      }

      // Process the form data (send it to a server, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Document submitted successfully!"),
        ),
      );

      // Clear the form after submission
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedCategory = null;
        _uploadedFilePath = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Document"),
        backgroundColor: secondaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Document Title",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Enter document title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                "Select Category",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a category.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                "Add Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: "Enter a description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickFile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  _uploadedFilePath == null
                      ? "Upload PDF"
                      : "File Selected: ${_uploadedFilePath!.split('/').last}",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("SUBMIT"),
              ),
            ],
          ),
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
}

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'components/bottomBar.dart';
import 'styles.dart';
import 'package:flutter/animation.dart';

class uploadDocumentPage extends StatefulWidget {
  @override
  _uploadDocumentPageState createState() => _uploadDocumentPageState();
}

class _uploadDocumentPageState extends State<uploadDocumentPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  String? _uploadedFilePath;
  int _currentIndex = 2;
  bool _isUploadPressed = false;
  bool _isSubmitPressed = false;
  bool _isCategoryExpanded = false;

  final List<String> _categories = [
    "Software Engineering",
    "Data Science",
    "Mathematics",
    "Physics",
  ];

  // Define the new color palette
  final Color _backgroundColor = Color(0xFFF5F7FA); // #f5f7fa
  final Color _primaryColor = Color(0xFF207BFF);    // #207bff
  final Color _accentColor = Color(0xFF4EA5FF);     // #4ea5ff

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
      backgroundColor: _backgroundColor, // Update background color
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            // Updated header with new color
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: _primaryColor, // Use _primaryColor
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  "Upload Document",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Updated Card widgets with new color
                    Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: "Add Document Title",
                            hintText: "Enter document title",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey),
                            labelStyle: TextStyle(color: Colors.grey),
                            floatingLabelStyle: TextStyle(color: _primaryColor), // Use _primaryColor
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a title.";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Custom-styled category dropdown
                    // Updated category dropdown
                    Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isCategoryExpanded = !_isCategoryExpanded;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _selectedCategory ?? 'Select Category',
                                    style: TextStyle(
                                      color: _selectedCategory == null
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    _isCategoryExpanded
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    color: _primaryColor, // Use _primaryColor instead of orange
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Animated expansion of the dropdown
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            height: _isCategoryExpanded
                                ? _categories.length * 50.0
                                : 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white, // Set dropdown background to white
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(0),
                                children: _categories.map((category) {
                                  return RadioListTile<String>(
                                    title: Text(category),
                                    value: category,
                                    groupValue: _selectedCategory,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCategory = value;
                                        _isCategoryExpanded = false;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Updated description field
                    Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: "Add Description",
                            hintText: "Enter description",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey),
                            labelStyle: TextStyle(color: Colors.grey),
                            floatingLabelStyle: TextStyle(color: _primaryColor), // Use _primaryColor
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a description.";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Updated upload button
                    GestureDetector(
                      onTapDown: (_) => setState(() => _isUploadPressed = true),
                      onTapUp: (_) {
                        setState(() => _isUploadPressed = false);
                        _pickFile();
                      },
                      child: AnimatedScale(
                        scale: _isUploadPressed ? 0.95 : 1.0,
                        duration: Duration(milliseconds: 1000),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.upload_file),
                          label: Text(
                            _uploadedFilePath == null
                                ? "Upload PDF"
                                : "File Selected: ${_uploadedFilePath!.split('/').last}",
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _accentColor, // Use _accentColor
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: null, // Handled by GestureDetector
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Updated submit button
                    GestureDetector(
                      onTapDown: (_) => setState(() => _isSubmitPressed = true),
                      onTapUp: (_) {
                        setState(() => _isSubmitPressed = false);
                        _submitForm();
                      },
                      child: AnimatedScale(
                        scale: _isSubmitPressed ? 0.95 : 1.0,
                        duration: Duration(milliseconds: 100),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.send),
                          label: Text("SUBMIT"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryColor, // Use _primaryColor
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: null, // Handled by GestureDetector
                        ),
                      ),
                    ),
                  ],
                ),
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
}

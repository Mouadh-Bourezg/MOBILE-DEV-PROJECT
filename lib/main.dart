import 'package:flutter/material.dart';
import './HomePage.dart';
import './savedPage.dart';
import './SearchPage.dart';
import './uploadDocument.dart';
import './documentPage.dart';
import './myProfilePage.dart';
import './styles.dart';
import 'components/bottomBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(), // Keep showBottomBar parameter if needed
    SearchPage(),
    uploadDocumentPage(),
    documentPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      // Remove bottomNavigationBar
    );
  }
}

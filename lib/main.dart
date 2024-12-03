import 'package:flutter/material.dart';
import './documentPage.dart';
import './documentPage2.dart';
import './HomePage.dart';
import './SignUpPage.dart';
import './SignInPage.dart';
import './myProfilePage.dart';
import './savedPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SavedPage(),
      /*routes: {
        SignUpPage.pageRoute: (ctx)=>SignUpPage(),
        SignInPage.pageRoute: (ctx)=>SignInPage(),
        HomePage.pageRoute: (ctx)=>HomePage(),
        DocumentPage2.pageRoute: (ctx)=>DocumentPage2(),
      },*/

    );
  }
}

class _MainPage extends StatefulWidget {
  const _MainPage({super.key});

  @override
  State<_MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage> {
  int _currentIndex = 0;

  // List of pages for the navigation bar
  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    SignUpPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex, // Controls which page is visible
        children: [
          NavigatorPage(HomePage(), 'Home'),
          NavigatorPage(SignInPage(), 'Sign In'),
          NavigatorPage(ProfilePage(), 'Profile'),
          NavigatorPage(SignUpPage(), 'Sign Up'),
    ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class NavigatorPage extends StatelessWidget {
  final Widget child;
  final String pageTitle;

  NavigatorPage(this.child, this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }
}




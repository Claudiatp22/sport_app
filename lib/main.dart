import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/pages/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github funciona!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [HomePage(),HomePage(),HomePage()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Entrenamientos',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.star),
            title: new Text('Retos'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), title: Text('Amigos'))
        ],
      ),
    );
  }
}

//Text(user['fullName']),
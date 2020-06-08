import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_app/pages/amigos_page.dart';
import 'package:sports_app/pages/home_page.dart';
import 'package:sports_app/pages/retos_page.dart';
import 'package:sports_app/pages/entrenamiento_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// https://github.com/minidosis/flutter_firebase_auth

void main() => runApp(App());

/*class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitwiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Home(),
    );
  }
}
*/

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .document('OUDFzPPc1AFNMvLUHOQQ')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // Què fem mentre carrega...
        }
        DocumentSnapshot doc = snapshot.data;
        // User user = User(doc);
        Map<String, dynamic> userData = doc.data;
        return Provider.value(
          value: userData,
          builder: (context, widget) {
            return MaterialApp(
              title: 'Fitwiz',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.orange,
              ),
              home: Home(),
            );
          },
        );
      },
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
  final List<Widget> _children = [
    HomePage(),
    RetosPage(),
    AmigosPage(),
    EntrenamientoPage(),
  ];
  List<String> _titles = ["Entrenamientos", "Retos", "Amigos", "Entrenamiento"];

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
          _titles[_currentIndex],
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
            icon: Icon(Icons.people),
            title: Text('Amigos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Amigos'),
          ),
        ],
      ),
    );
  }
}

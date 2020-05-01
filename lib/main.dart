import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github funciona!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fitwiz'),
        ),
        body: FutureBuilder<DocumentSnapshot>(
            future: Firestore.instance.document('/users/OUDFzPPc1AFNMvLUHOQQ').get(),
            //future: Firestore.instance.collection('users').document('OUDFzPPc1AFNMvLUHOQQ').get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              final DocumentSnapshot doc = snapshot.data;
              Map<String, dynamic> user = doc.data;
              return Center(
                child: Text(user['fullName']),
              );
            }
        ),
    );
  }
}

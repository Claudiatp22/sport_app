import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmigosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot mainUser = Provider.of<DocumentSnapshot>(context);
    Map<String, dynamic> user = mainUser.data;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemExtent: 60.0,
                itemCount: user['friends'].length,
                itemBuilder: (context, index) {
                  return StreamBuilder(
                      stream: Firestore.instance
                          .collection('users')
                          .document(user['friends'][index])
                          .snapshots(),
                      builder: (context, userSnapshot) {
                        if (!userSnapshot.hasData) {
                          return Text("Loading...");
                        }
                        DocumentSnapshot doc = userSnapshot.data;
                        Map<String, dynamic> userData = doc.data;
                        return ListTile(
                          title: Text(userData['fullname']),
                          leading: Icon(Icons.account_circle)
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

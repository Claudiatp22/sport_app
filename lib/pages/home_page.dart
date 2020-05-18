import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text(document['name']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('trainings').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading...");
          }
          return SafeArea(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('5',
                                style: TextStyle(
                                  fontSize: 30,
                                )),
                            Text('Entrenamentos realizados'),
                          ],
                        ),
                        Container(
                          height: 70,
                          child: VerticalDivider(
                            color: Colors.black,
                            width: 10,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text('1',
                                style: TextStyle(
                                  fontSize: 30,
                                )),
                            Text('Retos realizados'),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemExtent: 80.0,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return _buildList(
                              context, snapshot.data.documents[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future:
              Firestore.instance.document('/users/OUDFzPPc1AFNMvLUHOQQ').get(),
          //future: Firestore.instance.collection('users').document('OUDFzPPc1AFNMvLUHOQQ').get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final DocumentSnapshot doc = snapshot.data;
            Map<String, dynamic> user = doc.data;
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
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('Entrenamiento 1'),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}

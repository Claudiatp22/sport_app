import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_app/pages/entrenamiento_page.dart';

//Map<String, dynamic> training

class HomePage extends StatelessWidget {
  _addEntrenamiento(String id) {
    //var _training = training.values.toList();
    //print('training. $_training');

    final CollectionReference userTrainings = Firestore.instance
        .collection('users')
        .document('OUDFzPPc1AFNMvLUHOQQ')
        .collection('trainings');

    Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    //userTrainings.document(id).setData(data, merge: false);
    userTrainings.document().setData(data);
  }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => EntrenamientoPage(
                entrenamientoId: document.documentID, name: document['name']),
          ),
        )
            .then((result) {
          if (result != null) {
            _addEntrenamiento(result);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: Image.network(
              document['urlImage'],
            ).image,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                document['name'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.send,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = Provider.of<Map<String, dynamic>>(context);

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
                            StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection('users')
                                    .document('OUDFzPPc1AFNMvLUHOQQ')
                                    .collection('trainings')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("Loading...");
                                  } else {
                                    QuerySnapshot querySnap = snapshot.data;
                                    final numberOfDocs =
                                        querySnap.documents.length;
                                    return Text(
                                      numberOfDocs.toString(),
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                    );
                                  }
                                }),
                            /*Text(
                              user['fullName'],
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),*/
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
                            StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection('users')
                                    .document('OUDFzPPc1AFNMvLUHOQQ')
                                    .collection('challenges')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("Loading...");
                                  } else {
                                    QuerySnapshot querySnap = snapshot.data;
                                    final numberOfDocs =
                                        querySnap.documents.length;
                                    return Text(
                                      numberOfDocs.toString(),
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                    );
                                  }
                                }),
                            /*Text('1',
                                style: TextStyle(
                                  fontSize: 30,
                                )),*/
                            Text('Retos realizados'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemExtent: 120.0,
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

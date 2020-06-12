import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_app/pages/entrenamiento_page.dart';

class HomePage extends StatelessWidget {
  _addEntrenamiento(String id) {
    final CollectionReference userTrainings = Firestore.instance
        .collection('users')
        .document('OUDFzPPc1AFNMvLUHOQQ')
        .collection('trainings');

    Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;

    userTrainings.document().setData(data);
  }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    DocumentSnapshot mainUser = Provider.of<DocumentSnapshot>(context);

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
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: () => {
                  showSimpleCustomDialog(context, mainUser, document.documentID)
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSimpleCustomDialog(
      BuildContext context, DocumentSnapshot mainUser, String trainingId) {
    Map<String, dynamic> user = mainUser.data;

    _sendChallenge(int index) {
      final CollectionReference userChallenges = Firestore.instance
          .collection('users')
          .document(user['friends'][index])
          .collection('challenges');

      Map<String, dynamic> data = new Map<String, dynamic>();
      data["challengerId"] = mainUser.documentID;
      data["trainingId"] = trainingId;
      userChallenges.document().setData(data);
    }

    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 15.0),
              child: Text(
                '¡Reta a uno de tus amigos!',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
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
                      return GestureDetector(
                        onTap: () {
                          _sendChallenge(index);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          child: ListTile(
                            title: Text(userData['fullname']),
                            leading: Icon(Icons.account_circle),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
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

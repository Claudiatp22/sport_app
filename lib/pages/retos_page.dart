import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/pages/entrenamiento_page.dart';

class RetosPage extends StatelessWidget {
  Widget _buildList(BuildContext context, DocumentSnapshot document, String challengeID) {
    _deleteChallenge() {
      final CollectionReference userChallenges = Firestore.instance
          .collection('users')
          .document('OUDFzPPc1AFNMvLUHOQQ')
          .collection('challenges');

      userChallenges.document(challengeID).delete();
    }

    _addEntrenamiento(String id) {
      final CollectionReference userTrainings = Firestore.instance
          .collection('users')
          .document('OUDFzPPc1AFNMvLUHOQQ')
          .collection('trainings');

      Map<String, dynamic> data = new Map<String, dynamic>();
      data["id"] = id;
      userTrainings.document().setData(data);

      _deleteChallenge();
    }

    return Container(
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
                Icons.done,
                color: Colors.white,
              ),
              onPressed: () => {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => EntrenamientoPage(
                        entrenamientoId: document.documentID,
                        name: document['name']),
                  ),
                )
                    .then((result) {
                  if (result != null) {
                    _addEntrenamiento(result);
                  }
                })
              },
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () => _deleteChallenge(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document('OUDFzPPc1AFNMvLUHOQQ')
            .collection('challenges')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading...");
          }
          return SafeArea(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemExtent: 120.0,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder(
                              stream: Firestore.instance
                                  .collection('trainings')
                                  .document(snapshot.data.documents[index]
                                      ['trainingId'])
                                  .snapshots(),
                              builder: (context, trainingSnapshot) {
                                if (!trainingSnapshot.hasData) {
                                  return Text("Loading...");
                                }
                                return _buildList(
                                    context, trainingSnapshot.data, snapshot.data.documents[index].documentID);
                              });
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

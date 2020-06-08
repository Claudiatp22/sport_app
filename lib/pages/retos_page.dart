import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RetosPage extends StatelessWidget {


  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    _challengeDone() {
      /*check adding Id to user trainings
        Firestore.instance
          .collection('users')
          .document('OUDFzPPc1AFNMvLUHOQQ')
          .collection('trainings')
          .add('trainingId');
          */
    }
    _deleteChallenge() {
      //check challengeDocumentId
        Firestore.instance
          .collection('users')
          .document('OUDFzPPc1AFNMvLUHOQQ')
          .collection('challenges')
          .document('challengeDocumentId')
          .delete();
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: Image.network(
            document['urlImage'],
          ).image,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
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
              onPressed: () => _challengeDone(),
            ),
            IconButton(
              icon: Icon(
                Icons.remove,
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
        stream: Firestore.instance.collection('users').document('OUDFzPPc1AFNMvLUHOQQ').collection('challenges').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading...");
          }
          return SafeArea(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemExtent: 120.0,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return StreamBuilder(
                            stream: Firestore.instance.collection('trainings').document(snapshot.data.documents[index]['trainingId']).snapshots(),
                            builder: (context, trainingSnapshot) {
                              return _buildList(
                                context, trainingSnapshot.data.documents[index]);
                            }
                          );
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
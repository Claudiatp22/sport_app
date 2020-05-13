import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  /*Stream<List<Todo>> todoListSnapshots() {
  return Firestore.instance
      .collection('todos')
      .orderBy('createdAt')
      .snapshots()
      .map((QuerySnapshot query) {
    final List<DocumentSnapshot> docs = query.documents;
    return docs.map((doc) => Todo.fromFirestore(doc)).toList();
  });
}

Stream<int> timedCounter(Duration interval, [int maxCount]) async* {
    int i = 0;
    while (true) {
      await Future.delayed(interval);
      yield i++;
      if (i == maxCount) break;
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: StreamBuilder(
        stream: ,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('ERROR: ${snapshot.error.toString()}'));
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return _buildBody(snapshot.data);
              /*final FirebaseUser user = snapshot.data;
              return user == null
                  ? Provider<SignInConfig>.value(
                      value: signInConfig,
                      child: SignInFlowApp(),
                    )
                  : Provider<FirebaseUser>.value(
                      value: user,
                      child: this.app,
                    );*/
            case ConnectionState.done:
              return Center(child: Text("done??"));
            case ConnectionState.none:
            default:
              return Center(child: Text("no hi ha stream??"));
          }
        },
      ),*/
      /*FutureBuilder<DocumentSnapshot>(
          future:
              Firestore.instance.document('/users/OUDFzPPc1AFNMvLUHOQQ').get(),
          //future: Firestore.instance.collection('users').document('OUDFzPPc1AFNMvLUHOQQ').get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final DocumentSnapshot doc = snapshot.data;
            Map<String, dynamic> user = doc.data;*/
            
            //Text(user['fullName']),
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

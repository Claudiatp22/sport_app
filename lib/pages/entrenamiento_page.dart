import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EntrenamientoPage extends StatefulWidget {
  @override
  EntrenamientoPageState createState() => new EntrenamientoPageState();
}

class EntrenamientoPageState extends State<EntrenamientoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('trainings')
            .document('7vP2IFRoKx9zWMAgBENV')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading...");
          }
          Map<dynamic, dynamic> map = snapshot.data['steps'];
          return SafeArea(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemExtent: 120.0,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return _buildList(
                              context, map.values.toList()[index]);
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

  Widget _buildList(BuildContext context, Map<String, dynamic> step) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  step["urlImage"],
                  width: 160,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          step["name"],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Text(
                          step["reps"].toString() + " repeticiones",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        step["time"].toString() + " segundos",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ProgressIndicatorDemo(time: step["time"]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProgressIndicatorDemo extends StatefulWidget {
  final int time;

  ProgressIndicatorDemo({
        @required this.time,
    });

  @override
  _ProgressIndicatorDemoState createState() =>
      new _ProgressIndicatorDemoState();
}

class _ProgressIndicatorDemoState extends State<ProgressIndicatorDemo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  int _duration;

  @override
  void initState() {
    super.initState();
    _duration = widget.time;
    controller = AnimationController(
        duration: Duration(seconds: _duration), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
      child: LinearProgressIndicator(
        value: animation.value,
        backgroundColor: Colors.grey[300],
      ),
    ),);
  }
}

/*LinearProgressIndicator(
                    value: 0.5, // percent filled
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    backgroundColor: Colors.grey[300],
                  ),*/

//return _buildList(context, snapshot.data['steps'][index]);

//return Text(snapshot.data['steps'][index]['name']);

// return Text(map.values.toList()[index]["name"]);

/*Container(
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    map.values.toList()[index]["name"],
                                    style: TextStyle(
                                      color: Colors.black,
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
                          );*/

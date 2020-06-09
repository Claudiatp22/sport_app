import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'dart:io';

class EntrenamientoPage extends StatefulWidget {
  final String entrenamientoId;

  EntrenamientoPage({@required this.entrenamientoId});

  @override
  EntrenamientoPageState createState() => new EntrenamientoPageState();
}

class EntrenamientoPageState extends State<EntrenamientoPage> {
  String _id;

  @override
  void initState() {
    super.initState();
    _id = widget.entrenamientoId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('trainings')
            .document(_id)
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
                              context, map.values.toList()[index], index, map);
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

  Widget _buildList(BuildContext context, Map<String, dynamic> step, int index,
      Map<String, dynamic> steps) {
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
                      Text(
                        index.toString(),
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
                  child: ProgressIndicatorDemo(
                      time: step["time"], i: index, previousItem: steps),
                ),
                /*if (index == 0)
                Expanded(
                  child: ProgressIndicatorDemo(
                      time: step["time"],
                      i: index,
                      previousItem: steps.values.toList()[index]),
                ),
                if (index >= 1)
                Expanded(
                  child: ProgressIndicatorDemo(
                      time: step["time"],
                      i: index,
                      previousItem: steps.values.toList()[index-1]),
                ),*/
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
  final int i;
  final Map<String, dynamic> previousItem;

  ProgressIndicatorDemo(
      {@required this.time, @required this.i, @required this.previousItem});

  @override
  _ProgressIndicatorDemoState createState() =>
      new _ProgressIndicatorDemoState();
}

class _ProgressIndicatorDemoState extends State<ProgressIndicatorDemo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  int _duration;
  int _index;
  Map<String, dynamic> _previous;
  //_previous.values.toList()[index]

  //int _istate = 0;

  @override
  void initState() {
    super.initState();
    _duration = widget.time;
    _index = widget.i;
    _previous = widget.previousItem;
    controller = AnimationController(
        duration: Duration(seconds: _duration), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    if (_index == 0) {
      controller.forward();
      print('entro. index: $_index');
      /*controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print('acaba. index: $_index');
          setState(() {
            this._istate++;
          });
        }
      });*/
    }

    if (_index == 1) {
      print('entro. index: $_index');
      int counter = _previous.values.toList()[0]["time"];
      Future.delayed(Duration(seconds: counter), () {
        controller.forward();
      });
    }

    if (_index == 2) {
      print('entro. index: $_index');
      int counter = _previous.values.toList()[0]["time"] +
          _previous.values.toList()[1]["time"];
      Future.delayed(Duration(seconds: counter), () {
        controller.forward();
      });
    }

    if (_index == 3) {
      print('entro. index: $_index');
      int counter = _previous.values.toList()[0]["time"] +
          _previous.values.toList()[1]["time"] +
          _previous.values.toList()[2]["time"];
      Future.delayed(Duration(seconds: counter), () {
        controller.forward();
      });
    }

    if (_index == 4) {
      print('entro. index: $_index');
      int counter = _previous.values.toList()[0]["time"] +
          _previous.values.toList()[1]["time"] +
          _previous.values.toList()[2]["time"] +
          _previous.values.toList()[3]["time"];
      Future.delayed(Duration(seconds: counter), () {
        controller.forward();
      });
    }
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  startProgress() {
    controller.forward();
  }

  stopProgress() {
    controller.stop();
  }

  resetProgress() {
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        child: LinearProgressIndicator(
          value: animation.value,
          backgroundColor: Colors.grey[300],
        ),
      ),
    );
  }
}

// return Text(map.values.toList()[index]["name"]);

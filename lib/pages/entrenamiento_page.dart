import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EntrenamientoPage extends StatefulWidget {
  final String entrenamientoId;
  final String name;

  EntrenamientoPage({@required this.entrenamientoId, @required this.name});

  @override
  EntrenamientoPageState createState() => new EntrenamientoPageState();
}

class EntrenamientoPageState extends State<EntrenamientoPage> {
  String _id;
  String _name;

  @override
  void initState() {
    super.initState();
    _id = widget.entrenamientoId;
    _name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _name,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
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
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ProgressIndicatorDemo(
                      time: step["time"],
                      i: index,
                      steps: steps,
                      id: _id),
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
  final int i;
  final Map<String, dynamic> steps;
  final String id;

  ProgressIndicatorDemo(
      {@required this.time,
      @required this.i,
      @required this.steps,
      @required this.id});

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
  Map<String, dynamic> _steps;
  String _id;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _duration = widget.time;
    _index = widget.i;
    _steps = widget.steps;
    _id = widget.id;

    controller = AnimationController(
        duration: Duration(seconds: _duration), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        if (this.mounted) {
          setState(() {
          });
        }
      });

    if (_index == 0) {
      controller.forward();
    }

    if (_index == 1) {
      int counter = _steps.values.toList()[0]["time"];
      Future.delayed(Duration(seconds: counter), () {
        controller.forward();
      });
    }

    if (_index == 2) {
      int counter = _steps.values.toList()[0]["time"] +
          _steps.values.toList()[1]["time"];
      Future.delayed(Duration(seconds: counter), () {
        controller.forward();
      });
    }

    if (_index == 3) {
      int counter = _steps.values.toList()[0]["time"] +
          _steps.values.toList()[1]["time"] +
          _steps.values.toList()[2]["time"];
      Future.delayed(Duration(seconds: counter), () {
        controller.forward();
      });
    }

    if (_index == 4) {
      int counter = _steps.values.toList()[0]["time"] +
          _steps.values.toList()[1]["time"] +
          _steps.values.toList()[2]["time"] +
          _steps.values.toList()[3]["time"];
      Future.delayed(Duration(seconds: counter), () {
        controller.forward();
        Future.delayed(Duration(seconds: _duration), () {
          _done = true;
          if (_done == true) {
            Navigator.of(context).pop(_id);
          }
        });
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
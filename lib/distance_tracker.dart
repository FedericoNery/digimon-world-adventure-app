import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'training.dart';

class DistanceTracker extends StatefulWidget {
  @override
  _DistanceTrackerState createState() => _DistanceTrackerState();
}

class _DistanceTrackerState extends State<DistanceTracker> {
  double _totalDistance = 0.0;
  double _previousValue = 0.0;
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    accelerometerEvents.listen(_onAccelerometerEvent);
  }

  void _onAccelerometerEvent(AccelerometerEvent event) {
    if (_isMounted) {
      double currentValue = event.x + event.y + event.z;
      double delta = (currentValue - _previousValue).abs();
      setState(() {
        _totalDistance += delta;
        _previousValue = currentValue;
      });
    }
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    void _redirectToTraining() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Training(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Distance Tracker'),
      ),
      body: Column(
        children: [
          Text(
            'Total Distance: ${_totalDistance.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _redirectToTraining,
        tooltip: 'Training Area',
        child: const Icon(Icons.fitness_center),
      ),
    );
  }
}


/*

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distance Tracker Example',
      home: DistanceTracker(),
    );
  }
}

*/
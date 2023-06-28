import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Training extends StatefulWidget {
  @override
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  double _totalDistance = 0.0;
  double _previousValue = 0.0;
  static const botamonImage = Image(image: AssetImage('static_images/Botamon.jpg'));
  static const koromonImage = Image(image: AssetImage('static_images/Koromon.jpg'));
  static const agumonImage = Image(image: AssetImage('static_images/Agumon.jpg'));
  static const greymonImage = Image(image: AssetImage('static_images/Greymon.jpg'));
  static const metalGreymonImage = Image(image: AssetImage('static_images/MetalGreymon (Vaccine).jpg'));
  static const warGreymonImage = Image(image: AssetImage('static_images/WarGreymon.jpg'));

  Image digimonImage = botamonImage;
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
      _onUpdateImage();
    }
  }

  void _onUpdateImage(){
    switch (_totalDistance) {
      case <= 100:
        digimonImage = botamonImage;
      case <= 150:
        digimonImage = koromonImage;
      case <= 200:
        digimonImage = agumonImage;
      case <= 250:
        digimonImage = greymonImage;
      case <= 300:
        digimonImage = metalGreymonImage;
      case <= 350:
        digimonImage = warGreymonImage;
    };
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Training'),
      ),
      body: Column(
        children: [
          Text(
          'Total Distance: ${_totalDistance.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 24),
        ),
          digimonImage
        ],
      ),
    );
  }
}
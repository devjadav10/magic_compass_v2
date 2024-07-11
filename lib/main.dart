import 'package:flutter/material.dart';
import './models/location.dart';
import './services/calibration_service.dart';
import './services/navigation_service.dart';
import './views/navigation_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Compass Indoor Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final NavigationService navigationService = NavigationService();
  final CalibrationService calibrationService = CalibrationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magic Compass Indoor Navigation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Start Navigation'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NavigationView(
                          navigationService: navigationService,
                          calibrationService: calibrationService)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<Node> nodes = [
  Node(name: 'Lab003', x: 10.0, y: -6.0),
  Node(name: 'Lab002', x: 10.0, y: 0),
  Node(name: 'Lab001', x: 10.0, y: 6),
  Node(name: 'Lab012', x: 6.0, y: 10.0),
  Node(name: 'Lab011', x: 0.0, y: 10.0),
  Node(name: 'Lab010', x: -5.0, y: 10.0),
  Node(name: 'Lab009', x: -7.0, y: 10.0),
  Node(name: 'Lab008', x: -10.0, y: 6.0),
  Node(name: 'Lab007', x: -10.0, y: 0.0),
  Node(name: 'Lab006', x: -10.0, y: -6.0),
  Node(name: 'Lab005', x: -5.0, y: -10.0),
  Node(name: 'Lab004', x: 5.0, y: -10.0),
  // Add more nodes as needed
];

void connectNodes() {
  nodes[0].connect(nodes[1], 5.0);
  nodes[1].connect(nodes[2], 5.0);
  nodes[2].connect(nodes[3], 7.0);
  nodes[3].connect(nodes[4], 5.0);
  nodes[4].connect(nodes[5], 4.0);
  nodes[5].connect(nodes[6], 1.0);
  nodes[6].connect(nodes[7], 6.0);
  nodes[7].connect(nodes[8], 5.0);
  nodes[8].connect(nodes[9], 5.0);
  nodes[9].connect(nodes[10], 7.0);
  nodes[10].connect(nodes[11], 10.0);
}

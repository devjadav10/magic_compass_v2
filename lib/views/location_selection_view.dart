import 'package:flutter/material.dart';
import '../services/navigation_service.dart';
import '../models/location.dart';
import '../main.dart';

class LocationSelectionView extends StatefulWidget {
  final NavigationService navigationService;

  LocationSelectionView({required this.navigationService});

  @override
  _LocationSelectionViewState createState() => _LocationSelectionViewState();
}

class _LocationSelectionViewState extends State<LocationSelectionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Destination'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: nodes.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: Text(nodes[index].name, style: TextStyle(fontSize: 20)),
              onTap: () {
                widget.navigationService.setDestination(nodes[index]);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}

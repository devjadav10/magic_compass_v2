import '../models/location.dart';
import '../models/step_detector.dart';
import '../models/orientation_detector.dart';
import 'dart:math';

class NavigationService {
  StepDetector _stepDetector = StepDetector();
  OrientationDetector _orientationDetector = OrientationDetector();
  Node? _origin;
  Node? _currentLocation;
  Node? _destination;
  final double _strideLength =
      0.75; // You can estimate this value based on the user's height
  List<Node> _path = []; // The path from the origin to the destination

  void startNavigation({Node? destination}) {
    if (destination != null) {
      _destination = destination;
    }
    _currentLocation ??= Node(name: 'Current Location', x: 0.0, y: 0.0);
    _stepDetector.startListening(onStepDetected: _onStepDetected);
    _orientationDetector.startListening(
        onOrientationChanged: _onOrientationChanged);
  }

  void stopNavigation() {
    _stepDetector.stopListening();
    _orientationDetector.stopListening();
  }

  void _onStepDetected(int stepCount) {
    // Update _currentLocation based on the step count and orientation
    double stepDistance = _strideLength; // The distance covered in one step
    double orientationInRadians =
        _orientationDetector.getOrientation() * (3.14159 / 180);
    double deltaX = stepDistance * cos(orientationInRadians);
    double deltaY = stepDistance * sin(orientationInRadians);
    _currentLocation = Node(
      name: 'Current Location',
      x: _currentLocation!.x + deltaX,
      y: _currentLocation!.y + deltaY,
    );
  }

  void _onOrientationChanged(double orientation) {
    // Update _currentLocation based on the orientation
    // This might not be necessary depending on your dead reckoning algorithm
  }

  Node? getCurrentLocation() {
    return _currentLocation;
  }

  Node? getDestination() {
    return _destination;
  }

  void setDestination(Node destination) {
    if (_origin != null) {
      _destination = Node(
        name: destination.name,
        x: destination.x - _origin!.x,
        y: destination.y - _origin!.y,
      );
    } else {
      _destination = destination;
    }
    // Calculate the path from the origin to the destination
    // This would involve implementing a pathfinding algorithm like Dijkstra's
    _path = _calculatePath(_origin!, _destination!);
  }

  void setCurrentLocation(Node location) {
    if (_origin == null) {
      _origin = location;
    }
    _currentLocation = Node(
      name: location.name,
      x: location.x - _origin!.x,
      y: location.y - _origin!.y,
    );
    // If the current location is a node in the path, remove it
    if (_path.contains(_currentLocation)) {
      _path.remove(_currentLocation);
    }
    // If there are still nodes left in the path, rotate the compass to point towards the next node
    if (_path.isNotEmpty) {
      _rotateCompassTowards(_path.first);
    }
  }

  List<Node> _calculatePath(Node origin, Node destination) {
    // Implement a pathfinding algorithm like Dijkstra's here
    // For now, return an empty list
    return [];
  }

  void _rotateCompassTowards(Node node) {
    // Calculate the angle between the current location and the node
    // Then, set the orientation to this angle
    double deltaX = node.x - _currentLocation!.x;
    double deltaY = node.y - _currentLocation!.y;
    double angleInRadians = atan2(deltaY, deltaX);
    _orientationDetector.calibrateOrientation(angleInRadians * (180 / 3.14159));
  }
}

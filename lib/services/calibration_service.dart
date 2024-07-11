import '../models/location.dart';

class CalibrationService {
  Node? _currentCalibrationPoint;

  void calibrate(Node calibrationPoint) {
    _currentCalibrationPoint = calibrationPoint;
  }

  Node? getCurrentCalibrationPoint() {
    return _currentCalibrationPoint;
  }

  void updateCurrentLocation(String qrCodeData) {
    List<String> data = qrCodeData.split(',');
    String name = data[0];
    double x = double.parse(data[1]);
    double y = double.parse(data[2]);
    _currentCalibrationPoint = Node(name: name, x: x, y: y);
  }

  void resetCalibrationPoint() {
    _currentCalibrationPoint = null;
  }
}

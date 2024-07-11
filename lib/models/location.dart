class Node {
  final String name;
  final double x;
  final double y;
  Map<Node, double> connectedNodes = {};

  Node({required this.name, required this.x, required this.y});

  void connect(Node node, double distance) {
    connectedNodes[node] = distance;
    node.connectedNodes[this] = distance;
  }
}

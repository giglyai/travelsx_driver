class DistanceMatrix {
  final String? duration;
  final String? distance;
  final String? routePath;

  DistanceMatrix(
      {required this.duration,
      required this.distance,
      required this.routePath});

  factory DistanceMatrix.fromJson(Map<String, dynamic> json) => DistanceMatrix(
      duration: json['duration'],
      distance: json['distance'],
      routePath: json['route_path']);
}

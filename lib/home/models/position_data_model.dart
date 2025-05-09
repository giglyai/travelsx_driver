class DriverPosition {
  DriverPosition({
    required this.latitude,
    required this.longitude,
  });

  double latitude;
  double longitude;

  factory DriverPosition.fromJson(Map<String, dynamic> json) => DriverPosition(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

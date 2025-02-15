
class OverallModel {
  final int aqi;
  final int co2;
  final int temperature;
  final int humidity;

  OverallModel({
    required this.aqi,
    required this.humidity,
    required this.co2,
    required this.temperature,
  });

  factory OverallModel.fromjson(Map<String, dynamic> json) {
    return OverallModel(
      aqi: json['iaq'] as int,
      humidity: json['humidity'] as int,
      co2: json['co2'] as int,
      temperature: json['temperature'] as int,
    );
  }
}
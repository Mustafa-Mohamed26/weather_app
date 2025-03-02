class Wind {
  double? speed;
  double? deg;
  double? gust;

  Wind({this.speed, this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed']?.toDouble(),
      deg: json['deg']?.toDouble(),
      gust: json['gust']?.toDouble(),
    );
  }

  /// Converts the Wind object to a json compatible map
  ///
  /// Returns a map with keys 'speed', 'deg', and 'gust' with the corresponding values.
  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }

}
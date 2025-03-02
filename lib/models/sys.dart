class Sys {
  String? country;
  int? sunrise;
  int? sunset;
  int? id;

  Sys({this.country, this.sunrise, this.sunset, this.id});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset,
      'id': id,
    };
  }
}

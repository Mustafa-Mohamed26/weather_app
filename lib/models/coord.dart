class Coord{
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json){
    return Coord(
      lon: double.parse(json['lon']),
      lat: double.parse(json['lat']),
    );
  }

  /// Converts the Coord object to a json compatible map
  ///
  /// Returns a map with keys 'lon' and 'lat' with the corresponding values.
  Map<String, dynamic> toJson(){
    return {
      'lon': lon,
      'lat': lat,
    };
  }
}
class Clouds {
  int? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: int.parse(json['all']),
    );
  }

  /// Converts [Clouds] object to a map.
  ///
  /// The generated map has a single key-value pair, where the key is
  /// 'all', and the value is the [all] property of this object.
  Map<String, dynamic> toJson() {
    return {
      'all': all,
    };
  }
}

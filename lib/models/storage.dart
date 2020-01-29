class Storage {
  final int id;
  final String name;
  final int lowerLimit;
  final int upperLimit;
  final Limit limits;
  final int deviceTypeId;

  Storage({
    this.id,
    this.name,
    this.lowerLimit,
    this.upperLimit,
    this.deviceTypeId,
    this.limits,
  });

  factory Storage.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Storage(
        id: json['id'],
        name: json['name'],
        lowerLimit: json['lower_limit'],
        upperLimit: json['upper_limit'],
        deviceTypeId: json['device_type_id'],
        limits: Limit(
          upper: json['upper_limit'],
          lower: json['lower_limit'],
        ));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lower_limit': lowerLimit,
        'upper_limit': upperLimit,
        'device_type_id': deviceTypeId,
      };
}

class Limit {
  int upper;
  int lower;

  Limit({this.upper, this.lower});

  factory Limit.fromJson(Map<String, dynamic> json) {
    if (json == null) return Limit();
    String lower = json['lower_limit'] != null
        ? (json['lower_limit'] is String
        ? json['lower_limit']
        : json['lower_limit'].toString())
        : '0';

    String upper = json['upper_limit'] != null
        ? (json['upper_limit'] is String
        ? json['upper_limit']
        : json['upper_limit'].toString())
        : '0';

    return Limit(
      lower: num.tryParse(lower),
      upper: num.tryParse(upper),
    );
  }

  bool isInLimits(num value) {
    return (lower == null || lower <= value) &&
        (upper == null || upper >= value);
  }
}

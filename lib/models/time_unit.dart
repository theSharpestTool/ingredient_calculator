class TimeUnit {
  int id;
  String name;

  TimeUnit({this.id, this.name});

  factory TimeUnit.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return TimeUnit(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

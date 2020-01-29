class MassUnit {
  final num id;
  final String name;

  MassUnit(this.id, this.name);

  factory MassUnit.fromJson(Map<String, dynamic> json){
    if (json == null) return null;
    return MassUnit(json['id'], json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
  
}
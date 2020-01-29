import 'package:ingredient_calculator/services/helper_service.dart';

class Attachment {
  num id;
  String filename;
  DateTime createdAt;

  Attachment({this.id, this.filename, this.createdAt});

  factory Attachment.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Attachment(
        id: json['id'],
        createdAt: DateTime.tryParse('created_at'),
        filename: json['filename']);
  }

  static List<Attachment> parseList(List<dynamic> json){
    if (json == null) return [];
    return json
        .map((item) => Attachment.fromJson(item))
        .where((attach) => attach != null)
        .toList();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'filename': filename,
        'created_at': createdAt != null ? dateFormatter(createdAt) : null,
      };
}

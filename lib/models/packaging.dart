import 'package:ingredient_calculator/models/storage.dart';
import 'package:ingredient_calculator/models/time_unit.dart';
import 'package:ingredient_calculator/services/helper_service.dart';

class Packaging {
  num id;
  num size;
  String usage;
  String storageText;
  DateTime createdAt;
  DateTime updatedAt;
  Storage storage;
  num expiryDate;
  num bestBefore;
  TimeUnit timeUnit;

  Packaging({
    this.id,
    this.size,
    this.usage,
    this.storageText,
    this.createdAt,
    this.updatedAt,
    this.storage,
    this.bestBefore,
    this.expiryDate,
    this.timeUnit,
  });

  factory Packaging.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Packaging(
        id: json['id'],
        size: json['size'],
        usage: json['usage'],
        storageText: json['storage_text'],
        createdAt: parseDate(json['created_at']),
        updatedAt: parseDate(json['updated_at']),
        storage: Storage.fromJson(json['product_storage']),
        expiryDate: json['expiry_date'],
        bestBefore: json['best_before'],
        timeUnit: TimeUnit.fromJson(json['time_unit']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'size': size,
        'usage': usage,
        'storageText': storageText,
        'createdAt': createdAt != null ? dateFormatter(createdAt) : null,
        'updatedAt': updatedAt != null ? dateFormatter(updatedAt) : null,
        'product_storage': storage?.toJson(),
        'expiry_date': expiryDate,
        'best_before': bestBefore,
        'time_unit': timeUnit?.toJson(),
      };
}

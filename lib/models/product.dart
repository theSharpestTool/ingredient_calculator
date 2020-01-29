import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ingredient_calculator/models/attachment.dart';
import 'package:ingredient_calculator/models/ingredient.dart';
import 'package:ingredient_calculator/models/mass_unit.dart';
import 'package:ingredient_calculator/models/packaging.dart';
import 'package:ingredient_calculator/services/helper_service.dart';

class Product {
  num id;
  String name;
  String code;
  DateTime updatedAt;
  String brand;
  num productionUnitId;
  bool isCompleted;
  List<Ingredient> ingredients;
  Packaging packaging;
  num netTotal;
  MassUnit netTotalUnit;
  List<Attachment> files;
  Uint8List image;
  String preparationInstructions;
  Uint8List thumbnailBytes;
  bool custom = false; // Should be by default bool value, not null
  bool hasDetails = false;

  Product({
    this.id,
    @required this.name,
    this.code,
    this.updatedAt,
    this.brand,
    this.productionUnitId,
    this.isCompleted = false,
    this.ingredients,
    this.packaging,
    this.netTotalUnit,
    this.netTotal,
    this.preparationInstructions,
    this.custom = false,
    this.thumbnailBytes,
    this.files,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Product(
      id: json['id'],
      ingredients: Ingredient.parseList(json['ingredients']),
      name: json['name'],
      code: json['code'],
      updatedAt: parseDate(json['updated_at']),
      brand: json['brand'],
      productionUnitId: json['production_unit_id'],
      isCompleted: json['is_completed'] ?? false,
      packaging: Packaging.fromJson(json['packaging']),
      netTotal: json['net_total'] ?? null,
      netTotalUnit: MassUnit.fromJson(json['net_total_unit']),
      files: Attachment.parseList(json['files']),
      preparationInstructions: json['preparation_instructions'],
    );
  }

  Map<String, dynamic> toJson() {
    if (custom) {
      return {'id': id, 'name': name};
    } else {
      return {
        'id': id,
        'name': name,
        'code': code,
        'updated_at': updatedAt != null ? dateFormatter(updatedAt) : null,
        'brand': brand,
        'production_unit_id': productionUnitId,
        'is_completed': isCompleted,
        'packaging': packaging?.toJson(),
        'net_total': netTotal,
        'net_total_unit': netTotalUnit?.toJson(),
        'preparation_instructions': preparationInstructions,
      };
    }
  }
}

import 'package:ingredient_calculator/models/product.dart';

import 'mass_unit.dart';

class Ingredient {
  num id;
  num customIngredientId;
  num netAmount;
  String name;
  bool isAllergen = false;
  String code;
  String altNames;
  MassUnit productionUnit;
  num costPrice;
  Product subProduct;
  num share;

  Ingredient({
    this.id,
    this.name,
    this.netAmount = 0,
    this.productionUnit,
    this.share,
    this.subProduct,
    this.customIngredientId,
    this.isAllergen,
    this.code,
    this.altNames,
    this.costPrice,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    final Map<String, dynamic> data =
        json['ingredient_data'] ?? json['custom_ingredient'] ?? {};

    return Ingredient(
      id: json['id'],
      name: data['name'],
      isAllergen: data['is_allergen'],
      code: data['code'],
      subProduct: Product.fromJson(json['sub_product']),
      productionUnit: json['production_unit'],
      share: json['share'],
      netAmount: json['net_amount'],
      customIngredientId: json['custom_ingredient_id'],
      costPrice: json['cost_price'],
      altNames: data['alt_names'],
    );
  }

  static List<Ingredient> parseList(List<dynamic> json) {
    if (json == null) return [];
    return json
            .map((item) => Ingredient.fromJson(item))
            .where((item) => item != null)
            .toList() ??
        [];
  }

  Map<String, dynamic> toJson() {
    dynamic data = {
      'id': id,
      'custom_ingredient_id': customIngredientId,
      'net_amount': netAmount,
      'custom_ingredient': null,
      'ingredient_data': null,
      'production_unit': productionUnit?.toJson(),
      'cost_price': costPrice,
    };

    if (name != null) {
      if (customIngredientId != null) {
        data['custom_ingredient'] = {
          'name': name,
          'is_allergen': isAllergen,
          'code': code,
        };
      } else {
        data['ingredient_data'] = {
          'name': name,
          'is_allergen': isAllergen,
          'code': code,
          'alt_names': altNames,
        };
      }
    } else if (subProduct != null) {
      data['sub_product'] = subProduct.toJson();
    } else {
      throw Exception('Ingredient.toJson error');
    }

    return data;
  }
}

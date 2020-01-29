import 'package:flutter/material.dart';
import 'package:ingredient_calculator/models/ingredient.dart';
import 'package:ingredient_calculator/models/mass_unit.dart';

class IngredientListTileProvider with ChangeNotifier {
  Ingredient ingredient;

  IngredientListTileProvider(this.ingredient);

  void setIngredient(Ingredient ingredient){
    this.ingredient = ingredient;
    notifyListeners();
  }

  void setAmount(num amount){
    this.ingredient.netAmount = amount;
    notifyListeners();
  }

  void setMassUnit(MassUnit unit){
    this.ingredient.productionUnit = unit;
    notifyListeners();
  }
}
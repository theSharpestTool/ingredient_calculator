import 'package:ingredient_calculator/models/mass_unit.dart';
import 'package:ingredient_calculator/models/product.dart';

class CalculatorService {
  final Product _product;

  CalculatorService(this._product);

  void setMassUnit(MassUnit unit) {
    _product.netTotalUnit = unit;
    calcAmount(_product.netTotal);
  }

  void calcAmount(num amount) {
    if (amount == null) amount = _product.netTotal;
    _product.netTotal = amount;

    for (final ingredient in _product.ingredients) {
      final convertedAmount = _convertAmount(
        amount,
        _product.netTotalUnit,
        ingredient.productionUnit,
      );

      num shownNetAmount = convertedAmount != null
          ? convertedAmount * (ingredient.share ?? 0)
          : 0;

      ingredient.netAmount = num.parse(shownNetAmount.toStringAsFixed(3));
    }
  }

  num _convertAmount(num amount, MassUnit fromUnit, MassUnit toUnit) {
    final milliAmountIds = [1, 4]; // milliliter & gram
    final regularAmountIds = [2, 3];

    if (regularAmountIds.contains(fromUnit.id) &&
        milliAmountIds.contains(toUnit.id)) {
      return amount * 1000;
    } else if (milliAmountIds.contains(fromUnit.id) &&
        regularAmountIds.contains(toUnit.id)) {
      return amount / 1000;
    }

    return amount;
  }
}

// class IngredientCalculator {
//   final Product _product;

//   MassUnit _massUnit;

//   num _currentProductAmount;

//   List<WeightedIngredientData> _weightedIngredients = [];

//   List<WeightedIngredientData> get weightedIngredients =>
//       List.from(_weightedIngredients);

//   IngredientCalculator(this._product) {
//     _currentProductAmount = _product.netTotal;
//     _massUnit = _product.netTotalUnit;
//     for (final ingredient in _product.ingredients) {
//       _weightedIngredients.add(WeightedIngredientData(
//         ingredient: ingredient,
//         amount: ingredient.netAmount,
//       ));
//     }
//   }

//   List<WeightedIngredientData> setMassUnit(MassUnit unit) {
//     _massUnit = unit;
//     return calcAmount(_currentProductAmount);
//   }

//   List<WeightedIngredientData> calcAmount(num newAmount) {
//     if (newAmount == null) newAmount = _product.netTotal;

//     _currentProductAmount = newAmount;
//     _weightedIngredients.clear();

//     return _product.ingredients.map((Ingredient ingredient) {
//       num convertedAmount = 0;

//       if (_currentProductAmount != null &&
//           _massUnit != null &&
//           ingredient != null &&
//           ingredient.productionUnit != null) {
//         convertedAmount = _convertAmount(
//           _currentProductAmount,
//           _massUnit,
//           ingredient.productionUnit,
//         );
//       }

//       num shownNetAmount = convertedAmount != null
//           ? convertedAmount * (ingredient.share ?? 0)
//           : 0;

//       shownNetAmount = num.parse(shownNetAmount.toStringAsFixed(3));

//       return WeightedIngredientData(
//         ingredient: ingredient,
//         amount: shownNetAmount,
//       );
//     }).toList();
//   }

//   num _convertAmount(num amount, MassUnit fromUnit, MassUnit toUnit) {
//     const milliAmountIds = [6, 7]; // milliliter & gram
//     const regularAmountIds = [4, 5]; // liter && kilogram
//     if (regularAmountIds.contains(fromUnit.id) &&
//         milliAmountIds.contains(toUnit.id)) {
//       return amount * 1000;
//     } else if (milliAmountIds.contains(fromUnit.id) &&
//         regularAmountIds.contains(toUnit.id)) {
//       return amount / 1000;
//     }

//     return amount;
//   }
// }

// class WeightedIngredientData {
//   Ingredient ingredient;
//   num amount;
//   String batch;
//   FDExpansionTileController expansionController = FDExpansionTileController();

//   WeightedIngredientData({
//     this.ingredient,
//     this.amount,
//     this.batch,
//   });
// }

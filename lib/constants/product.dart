import 'package:ingredient_calculator/models/ingredient.dart';
import 'package:ingredient_calculator/models/product.dart';

import 'mass_units.dart';

final testProduct = Product(
  name: 'product',
  netTotal: 10,
  netTotalUnit: MassUnits.values.first,
  ingredients: [
    Ingredient(
      name: 'ingredient 1',
      netAmount: 4,
      share: 0.4,
      productionUnit: MassUnits.values.first,
    ),
    Ingredient(
      name: 'ingredient 2',
      netAmount: 6,
      share: 0.6,
      productionUnit: MassUnits.values.first,
    ),
  ],
);

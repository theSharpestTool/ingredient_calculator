import 'package:flutter/material.dart';
import 'package:ingredient_calculator/pages/product_details_page.dart';
import 'package:ingredient_calculator/providers/product_details_page_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: MaterialApp(
        title: 'Ingredient Calculator',
        home: ProductDetailsPage(),
      ),
      create: (_) => ProductDetailsPageProvider(),
    );
  }
}

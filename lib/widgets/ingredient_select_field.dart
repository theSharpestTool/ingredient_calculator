import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ingredient_calculator/models/ingredient.dart';
import 'package:ingredient_calculator/models/mass_unit.dart';
import 'package:ingredient_calculator/models/product.dart';

class IngredientSelectField extends StatefulWidget {
  final void Function(Ingredient) onSelect;
  final Product product;
  final MassUnit productionUnit;
  final String initialIngredient;
  final EdgeInsets contentPadding;
  final bool label;
  final TextEditingController controller;
  final bool enabled;
  final bool loading;

  IngredientSelectField({
    @required this.onSelect,
    @required this.product,
    @required this.productionUnit,
    this.loading = false,
    this.initialIngredient,
    this.contentPadding,
    this.label = false,
    this.controller,
    this.enabled = true,
  });

  @override
  _IngredientSelectFieldState createState() => _IngredientSelectFieldState();
}

class _IngredientSelectFieldState extends State<IngredientSelectField> {
  TextEditingController _controller;
  Ingredient selectedValue;
  String currentLocaleCode;
  SuggestionsBoxController _suggestionsBoxController;
  FocusNode _focusNode;
  Product _product;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        TextEditingController(text: widget.initialIngredient);
    _suggestionsBoxController = SuggestionsBoxController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      _validate();
    });
    _controller.addListener(_onChanged);
    _product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loading) {
      return CircularProgressIndicator(
        backgroundColor: Theme.of(context).primaryColor,
      );
    }

    return Form(
      key: _formKey,
      child: TypeAheadFormField(
        getImmediateSuggestions: true,
        autoFlipDirection: true,
        suggestionsBoxController: _suggestionsBoxController,
        noItemsFoundBuilder: (context) => RaisedButton(
          child: Text(
            'Add',
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () {
            _suggestionsBoxController.close();
            _focusNode.unfocus();
          },
        ),
        validator: (value) {
          if (_controller.text.isEmpty) {
            return 'Required field';
          }
          return null;
        },
        textFieldConfiguration: TextFieldConfiguration(
          enabled: widget.enabled,
          focusNode: _focusNode,
          controller: _controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            contentPadding: widget.contentPadding,
            labelText: widget.label ? 'Ingredient name' : '',
          ),
        ),
        suggestionsCallback: (pattern) async {
          return _searchIngredients(pattern);
        },
        itemBuilder: (context, Ingredient ingredient) {
          if (ingredient.subProduct != null) {
            Product product = ingredient.subProduct;
            return ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Product',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(product.name ?? '-'),
                ],
              ),
            );
          }

          return ListTile(
            title: Text(ingredient.name ?? '-'),
          );
        },
        onSuggestionSelected: (Ingredient value) {
          if (value.subProduct != null) {
            Product product = value.subProduct;

            _controller.text = product.name;
          } else {
            _controller.text = value.name;
          }

          selectedValue = value;
          widget.onSelect(value);
        },
      ),
    );
  }

  void _onChanged() {
    selectedValue = Ingredient(
      id: DateTime.now().microsecondsSinceEpoch,
      productionUnit: widget.productionUnit,
    );

    selectedValue.name = _controller.text;

    widget.onSelect(selectedValue);
  }

  Future<List<Ingredient>> _searchIngredients(String pattern) async {
    if (_product == null) return [];
    List<Ingredient> ingredients = _product.ingredients;

    if (ingredients == null) {
      return [];
    }

    pattern = pattern != null ? pattern.toLowerCase() : '';

    List<Ingredient> plainIngredients = [];
    List<Ingredient> productIngredients = [];

    ingredients.forEach((Ingredient item) {
      if (item == null) return;

      String name = item.name;
      name = name != null ? name.toLowerCase() : '';

      String code = item.code != null ? item.code.toLowerCase() : '';
      //If code is empty, try looking for code in subProduct
      if (code.isEmpty) {
        if (item.subProduct != null) {
          code = item.subProduct.code != null
              ? item.subProduct.code.toLowerCase()
              : '';
        }
      }

      if (code.contains(pattern) || name.contains(pattern)) {
        if (item.subProduct != null) {
          productIngredients.add(item);
        } else {
          plainIngredients.add(item);
        }
      }
    });

    return [...productIngredients, ...plainIngredients];
  }

  void _validate() {
    //Validate only when the field has lost focus
    if (!_focusNode.hasFocus) {
      _formKey.currentState.validate();
    } else {
      _formKey.currentState.reset();
    }
  }
}

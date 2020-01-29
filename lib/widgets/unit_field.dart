import 'package:flutter/material.dart';
import 'package:ingredient_calculator/models/mass_unit.dart';

class UnitField extends StatefulWidget {
  final Function(MassUnit) onSelected;
  final bool enabled;
  final MassUnit initialUnitValue;
  final List<MassUnit> values;

  UnitField({
    @required this.onSelected,
    this.values,
    this.enabled = true,
    this.initialUnitValue,
  });

  @override
  _UnitFieldState createState() => _UnitFieldState();
}

class _UnitFieldState extends State<UnitField> {
  @override
  void initState() {
    _value = widget.initialUnitValue;
    super.initState();
  }

  MassUnit _value;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      enabled: widget.enabled,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: widget.enabled ? Colors.black38 : Colors.black26,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(_value != null ? _value.name : 'Select a value'),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) {
        return widget.values.map<PopupMenuItem<MassUnit>>((MassUnit choice) {
          return PopupMenuItem<MassUnit>(
            key: Key('unit_${choice.name}'),
            value: choice,
            textStyle: Theme.of(context).textTheme.title,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(choice.name),
              ],
            ),
          );
        }).toList();
      },
      onSelected: (value) {
        _setValue(value);
        widget.onSelected(value);
      },
    );
  }

  void _setValue(MassUnit value) {
    setState(() {
      _value = value;
    });
  }
}

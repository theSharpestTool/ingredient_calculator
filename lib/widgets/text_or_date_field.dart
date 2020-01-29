import 'package:flutter/material.dart';
import 'package:ingredient_calculator/services/helper_service.dart';
import 'package:ingredient_calculator/widgets/custom_date_picker_icon.dart';

class TextOrDateField extends StatefulWidget {
  final Function(String) onSelected;
  final String hintText;
  final TextEditingController controller;
  final bool enabled;
  final DateTime initialDate;
  final EdgeInsets padding;
  final FormFieldValidator<String> validator;

  TextOrDateField(
      {Key key,
      this.onSelected,
      this.hintText,
      this.validator,
      this.controller,
      this.enabled = true,
      this.initialDate,
      this.padding})
      : super(key: key);

  @override
  _TextOrDateFieldState createState() => _TextOrDateFieldState();
}

class _TextOrDateFieldState extends State<TextOrDateField> {
  DateTime _dateValue;
  TextEditingController _textFieldController;

  @override
  void initState() {
    super.initState();

    _textFieldController =
        widget.controller != null ? widget.controller : TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            enabled: widget.enabled,
            validator: widget.validator,
            controller: _textFieldController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: widget.padding,
              border: OutlineInputBorder(),
              labelText: widget.hintText,
            ),
            onChanged: (String value) {
              if (widget.onSelected != null && value.isNotEmpty) {
                widget.onSelected(value);
              } else if (value.isEmpty) {
                widget.onSelected(null);
              }
            },
          ),
        ),
        if (widget.enabled)
          CustomDatePickerIcon(
            initialDate: _dateValue,
            onSelected: (DateTime value) {
              String date = dateFormatter(value);

              if (widget.onSelected != null) widget.onSelected(date);

              setState(() {
                _textFieldController.text = formatDateToDDMMYYYY(value);
                _dateValue = value;
              });
            },
          ),
      ],
    );
  }
}

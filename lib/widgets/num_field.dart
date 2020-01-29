import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumField extends StatelessWidget {
  final bool enabled;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final TextEditingController controller;
  final void Function(num) onChanged;
  final InputDecoration decoration;
  final num initialValue;

  const NumField({
    Key key,
    this.enabled = true,
    this.validator,
    this.focusNode,
    this.controller,
    this.onChanged,
    this.decoration,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue != null ? initialValue.toString() : null,
      enabled: enabled,
      validator: validator,
      focusNode: focusNode,
      controller: controller,
      inputFormatters: [CommaTextInputFormatter()],
      keyboardType: TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      ),
      onChanged: (String value) {
        onChanged(num.parse(value));
      },
      decoration: decoration ??
          InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(),
          ),
    );
  }
}

class CommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String truncated = newValue.text;
    TextSelection newSelection = newValue.selection;

    if (newValue.text.contains(",")) {
      truncated = newValue.text.replaceFirst(RegExp(','), '.');
    }
    return TextEditingValue(
      text: truncated,
      selection: newSelection,
    );
  }
}

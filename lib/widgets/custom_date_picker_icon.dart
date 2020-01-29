import 'package:flutter/material.dart';
class CustomDatePickerIcon extends StatelessWidget {
  final DateTime initialDate;
  final Function(DateTime) onSelected;

  CustomDatePickerIcon({Key key, this.initialDate, @required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: () => _selectDate(context),
    );
  }

  _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2022),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).primaryColorDark,
            accentColor: Theme.of(context).primaryColorLight,
          ),
          child: child,
        );
      },
    );
    if (date != null) onSelected(date);
  }
}

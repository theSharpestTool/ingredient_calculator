import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ingredient_calculator/widgets/image_picker_dialog.dart';

class ImagePickerButton extends StatelessWidget {
  final num iconSize;
  final bool enabled;
  final Widget icon;
  final Function(File) onImageAdded;

  const ImagePickerButton(
      {Key key,
      this.iconSize,
      this.enabled = true,
      this.icon,
      this.onImageAdded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize ?? 24.0,
      onPressed: enabled
          ? () async {
              FocusScope.of(context).requestFocus(FocusNode());

              final file =
                  await ImagePickerDialog().showGetImageDialog(context);

              if (file != null) {
                onImageAdded(file);
              }
            }
          : null,
      icon: icon,
    );
  }
}

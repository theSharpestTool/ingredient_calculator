import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog {
  Future<File> showGetImageDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Camera',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              final image = await _getImage(
                                context: context,
                                source: ImageSource.camera,
                              );
                              _onImageRetrived(context, image);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                              child: Text(
                                'Gallery',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                final image = await _getImage(
                                  context: context,
                                  source: ImageSource.gallery,
                                );
                                _onImageRetrived(context, image);
                              }),
                        ),
                        RaisedButton(
                          color: Colors.red,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            softWrap: true,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onImageRetrived(BuildContext context, File image) {
    if (image != null) {
      Navigator.of(context).pop(image);
    }
  }

  Future<File> _getImage({
    @required BuildContext context,
    @required ImageSource source,
  }) async {
    return await ImagePicker.pickImage(
      source: source,
      maxWidth: 2000,
      maxHeight: 2000,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource imageSource, int imageQuality) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: imageSource, imageQuality: imageQuality);

  if(_file != null){
    return await _file.readAsBytes();
  }
  print('No Image selected');
}

showSnackBar(BuildContext context,String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetMutiplePictures {
  static List<XFile>? imageFileList = [];



  static void selectImages() async {
    final List<XFile> selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
  }


}

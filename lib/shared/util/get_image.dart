import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class GetImage {
  static Future<File?> getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      var crop = await _cropImage(pickedFile.path);
      return crop;
    }
    return null;
  }

  /// Crop Image
  static Future<File?> _cropImage(filePath) async {
    File? croppedImage = (await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    ));
    if (croppedImage != null) {
      return croppedImage;
    }
    return null;
  }
}

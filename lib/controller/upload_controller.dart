import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UploadController with ChangeNotifier {
  List<File> uploadedImageList = [];

  //method for capturing an image and store it in mobile local storage.
  Future<void> captureImage() async {
    log('capturing...');
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera);
    if (imageFile == null) return;
    final image = File(imageFile.path);

    log(image.toString());

    // var baseNameWithExtension = path.basename(imageFile.path);
    // var file = await moveFile(image, imagePath);
    final imageFilePath = await getImageFilePath();
    final newImageFile = File(imageFilePath);
    final File savedImage = await image.copy(newImageFile.path);
    uploadedImageList.add(savedImage);
    notifyListeners();
  }

  Future<String> getImageFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final filename = DateTime.now().millisecondsSinceEpoch.toString();
    final newDirectory = '${directory.path}/uploads';
    await Directory(newDirectory).create(recursive: true);
    final imagePath = '$newDirectory$filename.jpg';
    return imagePath;
  }

  //scan the image upload destination directory
  Future<void> scanUploadDirectory() async {
    log('scanning uploaded file...');
    uploadedImageList.clear();
    final appDirectory = await getApplicationDocumentsDirectory();
    log(appDirectory.path);
    final uplodDirectory = Directory(appDirectory.path);
    if (!uplodDirectory.existsSync()) return;
    final files = uplodDirectory.listSync();

    for (var i = 0; i < files.length; i++) {
      if (files[i]
              .path
              .substring((files[i].path.length - 4), (files[i].path.length)) ==
          '.jpg') {
        uploadedImageList.add(File(files[i].path));
      }
    }
    notifyListeners();
  }
}

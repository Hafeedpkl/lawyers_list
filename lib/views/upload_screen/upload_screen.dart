import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _imageFile;
  List<File> uploadedImageList = [];
  @override
  void initState() {
    scanUploadDirectory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blueGrey[100],
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    mediaCard(size, 'Camera', Colors.blueAccent,
                        Icons.camera_alt_outlined, captureImage),
                    mediaCard(size, 'Scan', Colors.purpleAccent, Icons.image,
                        scanUploadDirectory),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: uploadedImageList.isEmpty
                      ? SizedBox()
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(uploadedImageList[index])),
                          itemCount: uploadedImageList.length,
                        ))
              
            ],
          ),
        ));
  }

// refactored widget for camera and file
  Card mediaCard(Size size, String text, Color color, IconData icon, onTap) {
    return Card(
      color: color,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: size.height * 0.2,
          width: size.width * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              Text(
                text,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

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
    setState(() {
      uploadedImageList.add(image);
    });
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
    final uplodDirectory = Directory('${appDirectory.path}');
    if (!uplodDirectory.existsSync()) return;
    final files = uplodDirectory.listSync();

    for (var i = 0; i < files.length; i++) {
      if (files[i]
              .path
              .substring((files[i].path.length - 4), (files[i].path.length)) ==
          '.jpg') {
        setState(() {
          uploadedImageList.add(File(files[i].path));
        });
      }
    }
  }
}

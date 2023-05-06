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
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  mediaCard(size, 'Camera', Colors.blueAccent,
                      Icons.camera_alt_outlined, captureImage),
                  mediaCard(size, 'File', Colors.purpleAccent,
                      Icons.file_present_outlined, scanUploadDirectory),
                ],
              ),
              Column(
                  children: uploadedImageList.map((file) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.file(file),
                );
              }).toList())
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
        child: Container(
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
    final directory = await getApplicationDocumentsDirectory();
    final filename = DateTime.now().millisecondsSinceEpoch.toString();
    final imagePath = '${directory.path}/uploads/$filename.jpg';
    final image = File(imageFile.path);
    // var baseNameWithExtension = path.basename(imageFile.path);
    // var file = await moveFile(image, imagePath);
    // final File savedImage = await image.copy(imagePath);
    setState(() {
      uploadedImageList.add(image);
    });
  }

  Future<File> moveFile(File sourcFile, String newPath) async {
    try {
      return await sourcFile.rename(newPath);
    } catch (e) {
      final newFile = await sourcFile.copy(newPath);
      return newFile;
    }
  }

  //scan the image upload destination directory
  Future<void> scanUploadDirectory() async {
    log('scanning uploaded file...');
    uploadedImageList.clear();
    final appDirectory = await getApplicationDocumentsDirectory();
    log(appDirectory.path);
    final uplodDirectory = Directory('${appDirectory.path}/uploads');
    if (!uplodDirectory.existsSync()) return;
    final files = uplodDirectory.listSync();
    final imageFiles = files.whereType<File>().toList();
    setState(() {
      uploadedImageList = imageFiles;
    });
  }
}

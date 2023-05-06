import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawyers_list/controller/upload_controller.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UploadController>(context, listen: false)
          .scanUploadDirectory();
    });
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blueGrey[100],
        body: SafeArea(
          child: Consumer<UploadController>(builder: (context, value, _) {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      mediaCard(size, 'Camera', Colors.blueAccent,
                          Icons.camera_alt_outlined, value.captureImage),
                      mediaCard(size, 'Scan', Colors.purpleAccent, Icons.image,
                          value.scanUploadDirectory),
                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: value.uploadedImageList.isEmpty
                        ? const SizedBox()
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Image.file(value.uploadedImageList[index])),
                            itemCount: value.uploadedImageList.length,
                          ))
              ],
            );
          }),
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
}

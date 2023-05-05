import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blueGrey[100],
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              mediaCard(size, 'Camera', Colors.blueAccent,
                  Icons.camera_alt_outlined, () {}),
              mediaCard(size, 'File', Colors.purpleAccent,
                  Icons.file_present_outlined, () {}),
            ],
          ),
        ));
  }

// refactored widget for camera and file
  Card mediaCard(Size size, String text, Color color, IconData icon, onTap) {
    return Card(
      color: color,
      child: GestureDetector(
        onTap: () => onTap,
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
}

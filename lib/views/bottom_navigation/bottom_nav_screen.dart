import 'package:flutter/material.dart';
import 'package:lawyers_list/controller/bottom_nav_controller.dart';
import 'package:lawyers_list/views/lawyers/lawyers_screen.dart';
import 'package:lawyers_list/views/profile/profile_screen.dart';
import 'package:lawyers_list/views/upload_screen/upload_screen.dart';
import 'package:provider/provider.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({
    super.key,
  });

  final pages = const [LawyersScreen(), UploadScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavController>(builder: (context, controller, _) {
      return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.currentIndex,
              onTap: (value) {
                controller.bottomChanger(value);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.gavel), label: 'Lawyers'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.upload_rounded), label: 'Upload'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile')
              ]),
          body: pages[Provider.of<BottomNavController>(context, listen: false)
              .currentIndex]);
    });
  }
}

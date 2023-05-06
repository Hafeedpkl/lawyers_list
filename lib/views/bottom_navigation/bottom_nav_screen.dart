import 'package:flutter/material.dart';
import 'package:lawyers_list/controller/bottom_nav_controller.dart';
import 'package:lawyers_list/views/lawyers/lawyers_screen.dart';
import 'package:lawyers_list/views/map/map_screen.dart';
import 'package:lawyers_list/views/upload_screen/upload_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants.dart';
import '../auth/login/views/login_page.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({
    super.key,
  });

  final pages = const [LawyersScreen(), UploadScreen(), MapScreen()];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavController>(builder: (context, controller, _) {
      return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () => logOut(context),
                  icon: const Icon(Icons.exit_to_app))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.black,
              currentIndex: controller.currentIndex,
              onTap: (value) {
                controller.bottomChanger(value);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.gavel), label: 'Lawyers'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.upload_rounded), label: 'Upload'),
                BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map')
              ]),
          body: pages[Provider.of<BottomNavController>(context, listen: false)
              .currentIndex]);
    });
  }
//this is method is for logout the user from device
  logOut(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('logout?'),
        content: const Text('Are you want to Log Out?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove(AUTH_TOKEN);
              // SystemNavigator.pop();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lawyers_list/controller/map_controller.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  TextEditingController addresTextController = TextEditingController();
  final fomrKey = GlobalKey<FormState>();
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<MapController>(builder: (context, mapController, _) {
      return Scaffold(
        body: GoogleMap(
          onMapCreated: (controller) {
            mapController.setMapController(controller);
          },
          initialCameraPosition: mapController.kInitialPosition,
          markers: {
            Marker(
                markerId: MarkerId('address'),
                position: mapController.kMapCenter,
                infoWindow: InfoWindow(title: mapController.kaddress))
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            searchBottomSheet(size, fomrKey, mapController);
          },
          child: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      );
    });
  }

  searchBottomSheet(size, formkey, MapController provider) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          body: SizedBox(
            height: size.height * 0.5,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Search Address',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: addresTextController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (mapController) =>
                            mapController != null && mapController.length < 3
                                ? 'Enter  addres'
                                : null,
                        maxLines: 6,
                        decoration: InputDecoration(
                            hintText:
                                'eg: 115 William Street, Melbourne VIC 3000, Australia',
                            labelText: 'Address',
                            labelStyle: GoogleFonts.poppins(color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 5),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 5, style: BorderStyle.none))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  elevation: const MaterialStatePropertyAll(4),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.white)),
                              onPressed: () {
                                Navigator.pop(context);
                                addresTextController.clear();
                              },
                              child: const Text(
                                'cancel',
                                style: TextStyle(color: Colors.black),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  elevation: const MaterialStatePropertyAll(4),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.blueAccent)),
                              onPressed: () {
                                if (!fomrKey.currentState!.validate()) return;
                                provider.searchLocation(
                                    addresTextController.text.trim());
                                Navigator.pop(context);
                              },
                              child: const Text(
                                ' search ',
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

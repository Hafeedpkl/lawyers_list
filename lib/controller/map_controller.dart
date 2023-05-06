import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController with ChangeNotifier {
  String kaddress = "your location";
  GoogleMapController? mapController;
  LatLng kMapCenter = const LatLng(37.42796133580664, -122.085749655962);
  CameraPosition kInitialPosition = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 11,
      tilt: 0,
      bearing: 0);
// this for saving current controller into that variable at onMapCreated
  setMapController(GoogleMapController controller) {
    mapController = controller;
    notifyListeners();
  }
// this is the method for search address in location
  Future<void> searchLocation(String address) async {
    kaddress = address;
    notifyListeners();
    List<Location> locations = await locationFromAddress(address);
    Location location = locations.first;
    kMapCenter = LatLng(location.latitude, location.longitude);
    notifyListeners();
    log(location.toString());
    log(kMapCenter.toString());
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(location.latitude, location.longitude), zoom: 10)));
    notifyListeners();
  }
}

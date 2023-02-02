import 'dart:math';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapGoogle extends StatefulWidget {
  @override
  _MapGoogleState createState() => _MapGoogleState();
}

class _MapGoogleState extends State<MapGoogle> {
  //late GoogleMapController mapController;
  //List<Marker> markers =[];
  GoogleMapController? _controller;
  Location currentLocation = Location();
  Set<Marker> _markers = {};
  addMarker(cordinate) {
    int id = Random().nextInt(100);
    setState(() {
      _markers
          .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  final LatLng _center = const LatLng(12.8684193, 75.3654176);
  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  //////////////////////////fetch current location//////////////////////////////
  void getLocation() async {
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) {
      _controller
          ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));
      print("lattt----${loc.latitude}--${loc.longitude}");

      setState(() {
        _markers.add(Marker(
            markerId: MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
      });
    });
  }

  ///////////////////////////////////////////////////
  ///
  @override
  void initState() {
    super.initState();

    getLocation();
  }
  ////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        mapToolbarEnabled: true,
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
        onTap: (cordinate) {
          _controller!.animateCamera(CameraUpdate.newLatLng(cordinate));
          addMarker(cordinate);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller!.animateCamera(CameraUpdate.zoomOut());
        },
        child: Icon(Icons.zoom_out),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestMap extends StatefulWidget {
  const TestMap({super.key});

  @override
  State<TestMap> createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  List<Marker> _markers = [];

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  GoogleMapController? mapController; //contrller for Google map
  // final List<Marker> markers = []; //markers for google map
  static const LatLng showLocation = const LatLng(11.874477, 75.370369); 

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye),
            label: 'View',
          ),
        ],
      ),
      body: GoogleMap(
        onTap: (LatLng point) {
          print("point-----$point");
          setState(() {
            _markers.add(Marker(
              markerId: MarkerId(point.toString()),
              position: point,
              icon: BitmapDescriptor.defaultMarker,
            ));
          });
        },
        //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition(
          //innital position in map
          target: showLocation, //initial position
          zoom: 15.0, //initial zoom level
        ),
        markers: _markers.toSet(), //markers to show on map
        mapType: MapType.normal, //map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: controller1,
                      decoration: InputDecoration(hintText: "Lattitude"),
                    ),
                    TextField(
                      controller: controller2,
                      decoration: InputDecoration(hintText: "Longitude"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          addmarker(
                            double.parse(controller1.text),
                            double.parse(controller2.text),
                          );
                          // setState(() {
                          //   markers.add(Marker(
                          //     //add first marker
                          //     markerId: MarkerId(showLocation.toString()),
                          //     position: LatLng(
                          //       double.parse(controller1.text),
                          //       double.parse(controller2.text),
                          //     ),
                          //     infoWindow: InfoWindow(
                          //       //popup info
                          //       title: 'Marker Title First ',
                          //       snippet: 'My Custom Subtitle',
                          //     ),
                          //     icon: BitmapDescriptor
                          //         .defaultMarker, //Icon for Marker
                          //   ));
                          // });
                        },
                        child: Text("Apply"))
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  addmarker(double lat, double long) {
    setState(() {
      _markers.add(Marker(
        //add first marker
        markerId: MarkerId(lat.toString()),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(
          //popup info
          title: 'Danush pottan',
          snippet: 'Vadakumbad',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    });
  }
}

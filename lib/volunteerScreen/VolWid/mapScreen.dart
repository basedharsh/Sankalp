import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  List<dynamic> markers = [];
  Set<Marker> mks = {};

  void data() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection("help").get();
      var localMarkers = <Marker>{};

      for (var doc in querySnapshot.docs) {
        var data = doc.data();
        double latitude = double.tryParse(data['latitude']) ?? 0.0;
        double longitude = double.tryParse(data['longitude']) ?? 0.0;

        if (latitude != 0.0 && longitude != 0.0) {
          // Ensuring valid coordinates
          localMarkers.add(Marker(
              markerId: MarkerId(doc.id),
              position: LatLng(latitude, longitude),
              onTap: () {
                _showBottomSheet(
                    context, data['image'], data['title'], data['description']);
              }));
        }
      }

      setState(() {
        mks = localMarkers;
      });
    } catch (e) {
      print("Error fetching markers: $e");
    }
  }

  @override
  void initState() {
    _controller = Completer<GoogleMapController>();
    data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: mks,
            mapType: MapType.satellite,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              data();
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(19.0728628, 72.9005083),
              zoom: 15.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: () => print('button pressed'),
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.green,
                child: const Icon(Icons.map, size: 36.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(
      BuildContext context, String image, String Title, String desc) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                Title,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Image.network(
                image, // Replace with your image URL
                height: 300,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 10),
              Text(
                desc,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}

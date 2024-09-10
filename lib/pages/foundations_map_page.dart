import 'package:final_project/models/model_foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.foundationList}) : super(key: key);
  final List<Foundation> foundationList; // Agrega este parámetro

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: 350,
          height: 350,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(
                  double.parse(widget.foundationList[0].location.latitude),
                  double.parse(widget.foundationList[0].location.longitude),
                ),
                zoom: 15),
            onMapCreated: (controller) {
              for (var foundation in widget.foundationList) {
                addMarker(
                  foundation.name,
                  LatLng(
                    double.parse(foundation.location.latitude),
                    double.parse(foundation.location.longitude),
                  ),
                );
              }
            },
            markers: _markers.values.toSet(),
            mapToolbarEnabled: true,
            rotateGesturesEnabled: true,
            zoomControlsEnabled: true,
          ),
        ),
      ),
    );
  }

  addMarker(String id, LatLng location) {
    Marker marker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: InfoWindow(title: id));
    _markers[id] = marker;
    setState(() {});
  }
}

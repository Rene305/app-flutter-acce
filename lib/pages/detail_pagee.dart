//PANTALLA PARA LA FASE 1 - DETALLE DE FUNDACIONES

import 'package:final_project/models/model_foundation.dart';
import 'package:final_project/widget/forms/list_material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//Importaciones de librerías y modelos.
import 'package:flutter/material.dart';

class FoundationFBPage extends StatefulWidget {
  const FoundationFBPage({super.key, required this.foundation});
  final Foundation foundation;
  //{super.key, required this.foundation, required this.uid});
  //final String uid;
  @override
  State<FoundationFBPage> createState() => _FoundationFBPageState();
}

class _FoundationFBPageState extends State<FoundationFBPage> {
  //Variables necesarias para la generación del mapa
  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    final Foundation foundation = widget.foundation;
    //String uid = widget.uid;
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: SizedBox(
                width: double.infinity,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: 350,
                    height: 350,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              double.parse(foundation.location.latitude),
                              double.parse(foundation.location.longitude)),
                          zoom: 15),
                      onMapCreated: (controller) {
                        addMarker(
                            foundation.name,
                            LatLng(double.parse(foundation.location.latitude),
                                double.parse(foundation.location.longitude)));
                      },
                      markers: _markers.values.toSet(),
                      mapToolbarEnabled: true,
                      rotateGesturesEnabled: true,
                      zoomControlsEnabled: true,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 50,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.black,
                  )
                ],
              ),
            ),
            Positioned(
              top: 150,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          runSpacing: 10.0,
                          children: [
                            Center(
                              child: SizedBox(
                                  height: 150.0,
                                  child: FadeInImage(
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    imageErrorBuilder: (context, error,
                                            stackTrace) =>
                                        Image.asset("assets/images/error.png"),
                                    placeholder: const AssetImage(
                                        "assets/images/error.png"),
                                    image: NetworkImage(foundation.logo),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text(foundation.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on),
                                Text(
                                  "${foundation.city}, Ecuador",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Representante:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(foundation.representative,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Servicios:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: showList(foundation.services, context),
                            ),
                            Row(
                              children: [
                                Text("Ubicación:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                  "Dirección: ${foundation.location.description}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                            ),
                            Row(
                              children: [
                                Text("Redes:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                              ],
                            ),
                            Center(
                              child: showMap(
                                  foundation.socialNetwork.toJson(), context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  addMarker(String id, LatLng location) {
    Marker marker = Marker(markerId: MarkerId(id), position: location);
    _markers[id] = marker;
    setState(() {});
  }
}

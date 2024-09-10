import 'package:final_project/models/model_foundation.dart';
import 'package:final_project/pages/detail_pagee.dart';
import 'package:flutter/material.dart';

class ListFB extends StatefulWidget {
  const ListFB({Key? key, required this.foundationList}) : super(key: key);
  final List<Foundation> foundationList; // Agrega este parámetro

  @override
  State<ListFB> createState() => _ListFBState();
}

class _ListFBState extends State<ListFB> {
  String _cityFilter = '';

  @override
  Widget build(BuildContext context) {
    final filteredData = _cityFilter.isEmpty
        ? widget.foundationList
        : widget.foundationList.where((item) {
            final foundation = item;
            return foundation.name
                    .toLowerCase()
                    .contains(_cityFilter.toLowerCase()) ||
                foundation.city.toLowerCase().contains(
                      _cityFilter.toLowerCase(),
                    );
          }).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _cityFilter = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Buscar por ciudad o nombre',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                Foundation foundation = filteredData[index];
                return Card(
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FoundationFBPage(foundation: foundation),
                        ),
                      );
                      setState(() {});
                    },
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: SizedBox.square(
                        dimension: 55.0,
                        child: FadeInImage(
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.topCenter,
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Image.asset("assets/images/error.png"),
                          placeholder:
                              const AssetImage("assets/images/error.png"),
                          image: NetworkImage(foundation.logo),
                        ),
                      ),
                    ),
                    title: Text(foundation.name),
                    subtitle: Text(foundation.city),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

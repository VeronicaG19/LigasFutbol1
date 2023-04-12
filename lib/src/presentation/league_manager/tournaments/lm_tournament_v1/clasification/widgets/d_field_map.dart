import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;

import '../../../../../../domain/field/entity/field.dart';

class FieldMapDialog extends StatefulWidget {
  const FieldMapDialog({super.key, required this.field});

  final Field field;

  @override
  State<FieldMapDialog> createState() => _FieldMapDialogState();
}

class _FieldMapDialogState extends State<FieldMapDialog> {
  late MapController _mapController;
  final List<Marker> marker = [];
  double latitude = 0;
  double longitude = 0;

  @override
  void initState() {
    if (widget.field.fieldsLatitude != null ||
        widget.field.fieldsLength != null) {
      if (widget.field.fieldsLatitude!.isNotEmpty ||
          widget.field.fieldsLength!.isNotEmpty) {
        latitude = double.parse(widget.field.fieldsLatitude ?? '0');
        longitude = double.parse(widget.field.fieldsLength ?? '0');
      }
      addMarker();
    }
    _mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void addMarker() {
    final m = Marker(
      builder: (ctx) => Icon(
        Icons.location_on_rounded,
        color: Colors.red[800],
        size: 60.0,
      ),
      point: latlong.LatLng(latitude, longitude),
    );
    setState(() {
      marker.add(m);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ubicación del campo'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 800,
          width: 900,
          child: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: latlong.LatLng(latitude, longitude),
                  zoom: 17.0,
                  maxZoom: 19.0,
                  interactiveFlags: InteractiveFlag.all,
                  onTap: (value, latlng) {},
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(markers: marker)
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('ACEPTAR'),
        ),
      ],
    );
  }
}

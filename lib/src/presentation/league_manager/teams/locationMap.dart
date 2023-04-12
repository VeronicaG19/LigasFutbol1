import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({Key? key}) : super(key: key);

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  List<Marker> allMarkers = [];

  @override
  Widget build(BuildContext context) {
    void launchGoogleMaps(double lat, double lng) async {
      Uri url =
          Uri.parse('google.navigation:q=${lat.toString()},${lng.toString()}');
      Uri fallbackUrl = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=${lat.toString()},${lng.toString()}');

      try {
        bool launched = await launchUrl(url);
        if (!launched) {
          await launchUrl(fallbackUrl);
        }
      } catch (e) {
        await launchUrl(fallbackUrl);
      }
    }

    Future<void> addMarker(LatLng latLng) async {
      allMarkers.clear();
      setState(() {
        allMarkers.add(
          Marker(
            builder: (ctx) => Icon(
              Icons.location_on_rounded,
              color: Colors.red[800],
              size: 60.0,
            ),
            point: latLng,
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Centro Deportivo Sandy",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: Colors.white)),
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar.png'),
          fit: BoxFit.fitWidth,
        ),
        actions: [],
        backgroundColor: const Color(0xff358aac),
      ),
      body: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 50, right: 50, top: 30, bottom: 50),
            child: Column(
              children: [
                Flexible(
                  child: FlutterMap(
                    options: MapOptions(
                        center: LatLng(19.4260138, -99.6389653),
                        zoom: 12.0,
                        onTap: (value, latlng) {
                          print("latitude --- > ${latlng.latitude}");
                          print("longitude --- > ${latlng.longitude}");
                          addMarker(latlng);
                        }),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                        // For example purposes. It is recommended to use
                        // TileProvider with a caching and retry strategy, like
                        // NetworkTileProvider or CachedNetworkTileProvider
                        //tileProvider: const NonCachingNetworkTileProvider(),
                      ),
                      MarkerLayer(markers: allMarkers)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 100.0,
              color: Colors.grey[200],
              child: Row(
                children: const <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 15, right: 15),
                      child: _YellowForPunishmentInput(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 15, right: 15),
                      child: _RedForPunishmentInput(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff358aac),
        child: const Icon(Icons.directions_bus_sharp),
        onPressed: () {
          launchGoogleMaps(19.9620578, -99.3779328);
        },
      ),
    );
  }
}

class _YellowForPunishmentInput extends StatelessWidget {
  const _YellowForPunishmentInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: "${state.categoryInfo?.yellowForPunishment ?? '0'}",
      key: const Key('yellow_target_textField'),
      /* onChanged: (value) => context
          .read<CategoryLmCubit>()
          .onChangeYellowForPunishment(value),
      onFieldSubmitted: (value) => state.status.isSubmissionInProgress
          ? null
          : context.read<CategoryLmCubit>().updateCategoryId(),*/
      decoration: InputDecoration(
        labelText: "Amarillas para suspensión",
        labelStyle: TextStyle(fontSize: 13),
        //  errorText:
        //   state.yellowForPunishment.invalid ? "Datos no válidos" : null,
      ),
      style: TextStyle(fontSize: 13),
    );
  }
}

class _RedForPunishmentInput extends StatelessWidget {
  const _RedForPunishmentInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: "${state.categoryInfo?.redForPunishment ?? '0'}",
      key: const Key('red_target_textField'),
      /*   onChanged: (value) =>
          context.read<CategoryLmCubit>().onChangeRedForPunishment(value),
      onFieldSubmitted: (value) => state.status.isSubmissionInProgress
          ? null
          : context.read<CategoryLmCubit>().updateCategoryId(),*/
      decoration: InputDecoration(
        labelText: "Rojas para sanción de partidos",
        labelStyle: TextStyle(fontSize: 13),
        //  errorText:
        //    state.redForPunishment.invalid ? "Datos no válidos" : null,
      ),
      style: TextStyle(fontSize: 13),
    );
  }
}

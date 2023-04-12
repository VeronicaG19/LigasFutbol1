import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/interface/matches_by_tournament_interface.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cubit/matches_by_tournament_cubit.dart';

class FieldLocationPage extends StatefulWidget {
  const FieldLocationPage({Key? key, required this.match}) : super(key: key);
  final MatchesByTournamentsInterface match;

  static Route route(
          {required MatchesByTournamentsInterface match,
          required MatchesByTournamentCubit value}) =>
      MaterialPageRoute(
          builder: (_) => BlocProvider.value(
                value: value..getFieldByMatchId(teamId: match.matchId),
                child: FieldLocationPage(match: match),
              ));
  @override
  _FieldLocationPageState createState() => _FieldLocationPageState();
}

class _FieldLocationPageState extends State<FieldLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: AppBar(
            title: Text("Campo " + widget.match.campo!,
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
        ),
        body: BlocBuilder<MatchesByTournamentCubit, MatchesByTournamentState>(
          builder: (context, state) {
            if (state.screenStatus == ScreenStatus.loading) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: const Color(0xff358aac),
                  size: 50,
                ),
              );
            } else {
              return state.fieldData != null
                  ? const Map()
                  : const Center(
                      child: Text("No hay datos del campo",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    );
            }
          },
        ),
        floatingActionButton: (ResponsiveWidget.isSmallScreen(context)
            ? const ButtonGo()
            : Container()));
  }
}

class ButtonGo extends StatelessWidget {
  const ButtonGo({Key? key}) : super(key: key);

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

    return BlocBuilder<MatchesByTournamentCubit, MatchesByTournamentState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        }
        return state.fieldData.fieldsLength == null
            ? Container()
            : FloatingActionButton(
                backgroundColor: const Color(0xff358aac),
                child: const Icon(Icons.directions_bus_sharp),
                onPressed: () {
                  launchGoogleMaps(
                      double.parse(state.fieldData.fieldsLatitude!),
                      double.parse(state.fieldData.fieldsLength!));
                },
              );
      },
    );
  }
}

class Map extends StatelessWidget {
  const Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[
      Marker(
        point: LatLng(
            double.parse(context
                .read<MatchesByTournamentCubit>()
                .state
                .fieldData
                .fieldsLatitude!),
            double.parse(context
                .read<MatchesByTournamentCubit>()
                .state
                .fieldData
                .fieldsLength!)),
        builder: (ctx) => Icon(
          Icons.location_on_rounded,
          color: Colors.red[800],
          size: 60.0,
        ),
      ),
    ];
    return BlocBuilder<MatchesByTournamentCubit, MatchesByTournamentState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        } else {
          return state.fieldData.fieldsLength == null &&
                  state.fieldData.fieldsLatitude == null
              ? Container()
              : Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Flexible(
                            child: FlutterMap(
                              options: MapOptions(
                                center: LatLng(
                                    double.parse(
                                        state.fieldData.fieldsLatitude!),
                                    double.parse(
                                        state.fieldData.fieldsLength!)),
                                zoom: 12.0,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  subdomains: ['a', 'b', 'c'],
                                  // For example purposes. It is recommended to use
                                  // TileProvider with a caching and retry strategy, like
                                  // NetworkTileProvider or CachedNetworkTileProvider
                                  /*tileProvider:
                                      const NoTile(),*/
                                ),
                                MarkerLayer(markers: markers)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 60.0,
                          color: Colors.black87,
                          child: Center(
                            child: Text(
                              state.fieldData.fieldsAddress ??
                                  'Sin dirección registrada',
                              style: TextStyle(
                                  color: Colors.grey[200], fontSize: 12),
                            ),
                          )),
                    ),
                  ],
                );
        }
      },
    );
  }
}

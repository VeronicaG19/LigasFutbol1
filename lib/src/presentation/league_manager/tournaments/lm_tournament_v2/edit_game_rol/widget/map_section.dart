import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:ligas_futbol_flutter/src/presentation/app/bloc/authentication_bloc.dart';

import '../../../../../../core/models/map_filter_list.dart';
import '../cubit/edit_game_rol_cubit.dart';

class MapSearchingSection extends StatefulWidget {
  const MapSearchingSection({Key? key}) : super(key: key);

  @override
  State<MapSearchingSection> createState() => _MapSearchingSectionState();
}

class _MapSearchingSectionState extends State<MapSearchingSection> {
  late final MapController _mapController;
  final List<Marker> marker = [];
  double latitude = 19.4260138;
  double longitude = -99.6389653;
  double mapZoom = 10;

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Marker _addMarker(MapFilterList attributes) {
    return Marker(
        builder: (context) => InkWell(
              onTap: () {
                if (attributes.isReferee) {
                  context
                      .read<EditGameRolCubit>()
                      .onSelectRefereeOnMap(attributes.id);
                } else {
                  context
                      .read<EditGameRolCubit>()
                      .onSelectFieldOnMap(attributes.id);
                }
              },
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      attributes.isReferee
                          ? 'assets/images/referee.png'
                          : 'assets/images/footballfield.png',
                      fit: BoxFit.cover,
                      // height: 35,
                      // width: 35,
                      color: Colors.black54,
                    ),
                    Flexible(
                      child: Text(
                        attributes.desc,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        point: latlong.LatLng(attributes.getLatitude, attributes.getLongitude),
        width: 120,
        height: 40);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((EditGameRolCubit bloc) => bloc.state.isMapLoading);
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          BlocListener<EditGameRolCubit, EditGameRolState>(
            listenWhen: (previous, current) =>
                previous.selectedAddress != current.selectedAddress,
            listener: (context, state) {
              _mapController.move(
                  latlong.LatLng(state.selectedAddress.getLatitude,
                      state.selectedAddress.getLongitude),
                  12);
              context.read<EditGameRolCubit>().onFilterByMapPosition(
                  state.selectedAddress.getLatitude,
                  state.selectedAddress.getLongitude,
                  leagueManager.leagueId);
            },
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: latlong.LatLng(latitude, longitude),
                zoom: mapZoom,
                maxZoom: 19.0,
                interactiveFlags: InteractiveFlag.all,
                onTap: (value, latlng) {
                  if (isLoading) return;
                  _mapController.move(latlng, 12);
                  context.read<EditGameRolCubit>().onFilterByMapPosition(
                      latlng.latitude,
                      latlng.longitude,
                      leagueManager.leagueId);
                },
                // onPositionChanged: (position, value){
                //   print('change');
                // },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                BlocBuilder<EditGameRolCubit, EditGameRolState>(
                  buildWhen: (previous, current) =>
                      current.isMapVisible ||
                      previous.screenState != current.screenState ||
                      previous.isMapLoading != current.isMapLoading,
                  builder: (context, state) {
                    return MarkerLayer(
                      markers: List.generate(
                        state.mixedElementsList.length,
                        (index) => _addMarker(state.mixedElementsList[index]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if (isLoading) const LinearProgressIndicator(),
        ],
      ),
    );
  }
}

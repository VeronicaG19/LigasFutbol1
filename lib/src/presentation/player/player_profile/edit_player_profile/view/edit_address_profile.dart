import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:formz/formz.dart';
import 'package:latlong2/latlong.dart' as lstlong;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../domain/player/entity/player.dart';
import '../../cubit/player_profile_cubit.dart';

class EditAddressProfile extends StatelessWidget {
  const EditAddressProfile({
    Key? key,
    required this.playerInfo,
  }) : super(key: key);
  final Player playerInfo;

  static Route route(PlayerProfileCubit cubit, Player playerInfo) =>
      MaterialPageRoute(
          builder: (_) => BlocProvider.value(
                value: cubit,
                child: EditAddressProfile(playerInfo: playerInfo),
              ));

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayerProfileCubit, PlayerProfileState>(
      listenWhen: (_, state) =>
          state.formStatus.isSubmissionSuccess ||
          state.formStatus.isSubmissionFailure,
      listener: (context, state) {
        if (state.formStatus.isSubmissionFailure) {
         
        } else if (state.formStatus.isSubmissionSuccess) {
          /*context.read<AuthenticationBloc>().add(UpdateRefereeData(
                    refereeData.copyWith(
                        refereeAddress: state.referee.refereeAddress)));*/
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Scaffold(
            body: Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            ),
          );
        }
        return Scaffold(
            body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 140, bottom: 60),
              child: Column(
                children: [
                  Flexible(
                    child: BlocBuilder<PlayerProfileCubit, PlayerProfileState>(
                      builder: (context, state) {
                        if (state.screenStatus != ScreenStatus.loading) {
                          return FlutterMap(
                            mapController: context
                                .read<PlayerProfileCubit>()
                                .getMapController,
                            options: MapOptions(
                                center: lstlong.LatLng(state.lat, state.leng),
                                zoom: 14.0,
                                maxZoom: 19.0,
                                interactiveFlags: InteractiveFlag.all,
                                onTap: (value, latlng) {
                                  context
                                      .read<PlayerProfileCubit>()
                                      .onFieldLatitudeChange(
                                          latlng.latitude.toString());

                                  context
                                      .read<PlayerProfileCubit>()
                                      .onFieldLengthChange(
                                          latlng.longitude.toString());
                                  context
                                      .read<PlayerProfileCubit>()
                                      .addDireccionAndMarket(latlng);
                                  context
                                      .read<PlayerProfileCubit>()
                                      .getMapController
                                      .move(latlng, 17.00);
                                }),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                subdomains: const ['a', 'b', 'c'],
                                // For example purposes. It is recommended to use
                                // TileProvider with a caching and retry strategy, like
                                // NetworkTileProvider or CachedNetworkTileProvider
                                /*tileProvider:
                                    const NonCachingNetworkTileProvider(),*/
                              ),
                              MarkerLayer(markers: state.allMarkers)
                            ],
                          );
                        } else {
                          return Container(
                            child: Text('${state.screenStatus}'),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10.0,
              left: 10.0,
              right: 10.0,
              child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 200.0,
                  width: 200,
                  color: Colors.grey[200],
                  child: Column(
                    children: <Widget>[
                      /* const Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: _AddresField()),
                    ),*/
                      /*const Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: AutocompleteBasicExample()),*/
                      Expanded(
                          child: Column(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: _AddresField()),

                          /*Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: AddresAutoComplete())*/
                        ],
                      ))
                    ],
                  )),
            ),
            Positioned(
              //top: 0.0,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                height: 100.0,
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Text("*Seleccionar una ubicacion del campo en el mapa*",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    const SizedBox(
                      height: 10,
                    ),
                    state.screenStatus == ScreenStatus.loading
                        ? Center(
                            child: LoadingAnimationWidget.fourRotatingDots(
                              color: const Color(0xff358aac),
                              size: 50,
                            ),
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    context
                                        .read<PlayerProfileCubit>()
                                        .updateAddresAsset();
                                  },
                                  // }
                                  /* context.read<FieldLmCubit>().createField(
                                          leagueId: leagueId.leagueId);
                                      Navigator.pop(context);*/

                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 10.0, 16.0, 10.0),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff045a74),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Text(
                                      'Guardar Direccion',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'SF Pro',
                                        color: Colors.grey[200],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}

class _AddresField extends StatelessWidget {
  const _AddresField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerProfileCubit, PlayerProfileState>(
      buildWhen: (previous, current) =>
          previous.playerInfo.playerAddress !=
          previous.playerInfo.playerAddress,
      builder: (context, state) {
        return ListTile(
          title: const Text('Mi dirección'),
          subtitle: Text(state.playerInfo.playerAddress ?? ''),
        );
        /*return TextFormField(
          controller: context.read<UpdateFieldCubit>().getTextAddresController,
          enabled: false,
          key: const Key('addres_field'),
          onChanged: (value) {
            if (value.trim().length > 7) {
              context.read<UpdateFieldCubit>().onGetAddressse(value);
            }

            context.read<UpdateFieldCubit>().onFieldAddresChange(value);
          },
          //onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          initialValue: state.detailField.fieldsAddress ?? '',
          decoration: InputDecoration(
            labelText: "Dirección del campo : ",
            labelStyle: const TextStyle(fontSize: 12),
            errorText: state.detailField.fieldsAddress!.trim().isEmpty
                ? "Selecciona un punto en el mapa"
                : null,
          ),
          style: const TextStyle(fontSize: 12),
        );*/
      },
    );
  }
}

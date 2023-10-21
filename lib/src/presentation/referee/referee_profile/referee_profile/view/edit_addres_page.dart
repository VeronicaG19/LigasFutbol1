import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:formz/formz.dart';
import 'package:latlong2/latlong.dart' as lstlong;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../service_locator/injection.dart';
import '../../../../app/app.dart';
import '../cubit/referee_profile_cubit.dart';

class EditAddressPage extends StatelessWidget {
  const EditAddressPage(
      {Key? key, required this.personName, required this.personId})
      : super(key: key);
  final String personName;
  final int personId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<RefereeProfileCubit>(),
      child: _EditAddressContent(
        personName: personName,
        personId: personId,
      ),
    );
  }
}

class _EditAddressContent extends StatefulWidget {
  const _EditAddressContent(
      {Key? key, required this.personName, required this.personId})
      : super(key: key);
  final String personName;
  final int personId;

  @override
  State<_EditAddressContent> createState() => _EditAddressContentState();
}

class _EditAddressContentState extends State<_EditAddressContent> {
  @override
  void initState() {
    permissions();
    super.initState();
  }

  void permissions() async {
    final cubit = context.read<RefereeProfileCubit>();
    print('.-----FFFf');
    if (await Permission.location.isRestricted ||
        await Permission.location.isDenied ||
        await Permission.location.isPermanentlyDenied) {
      print('.-----FFFf');
      await Permission.location.request();
    }
    cubit.getCurrentPosition(widget.personId, widget.personName);
  }

  @override
  Widget build(BuildContext context) {
    final refereeData =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar dirección',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.grey[200],
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fill,
        ),
        elevation: 0.0,
      ),
      body: BlocConsumer<RefereeProfileCubit, RefereeProfileState>(
        listenWhen: (_, state) =>
            state.status.isSubmissionSuccess ||
            state.status.isSubmissionFailure,
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            final message = state.errorMessage ?? 'Ha ocurrido un error';
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
          } else if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content:
                        Text('La dirección se ha actualizado correctamente.')),
              );
            context.read<AuthenticationBloc>().add(UpdateRefereeData(refereeData
                .copyWith(refereeAddress: state.referee.refereeAddress)));
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          }
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 100, bottom: 70),
                child: Column(
                  children: [
                    Flexible(
                      child:
                          BlocBuilder<RefereeProfileCubit, RefereeProfileState>(
                        builder: (context, state) {
                          if (state.screenStatus != ScreenStatus.loading) {
                            return FlutterMap(
                              mapController: context
                                  .read<RefereeProfileCubit>()
                                  .getMapController,
                              options: MapOptions(
                                  center:
                                      lstlong.LatLng(state.lat!, state.leng!),
                                  zoom: 10.0,
                                  interactiveFlags: InteractiveFlag.all,
                                  onTap: (value, latlng) {
                                    context
                                        .read<RefereeProfileCubit>()
                                        .onFieldLatitudeChange(
                                            latlng.latitude.toString());

                                    context
                                        .read<RefereeProfileCubit>()
                                        .onFieldLengthChange(
                                            latlng.longitude.toString());
                                    context
                                        .read<RefereeProfileCubit>()
                                        .addDireccionAndMarket(latlng);
                                    context
                                        .read<RefereeProfileCubit>()
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
                    height: 100.0,
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
                      Text("*Seleccionar una ubicacion en el mapa*",
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
                                          .read<RefereeProfileCubit>()
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
                                        'Guardar dirección',
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
          );
        },
      ),
    );
  }
}

class _AddresField extends StatelessWidget {
  const _AddresField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefereeProfileCubit, RefereeProfileState>(
      buildWhen: (previous, current) =>
          previous.referee.refereeAddress != current.referee.refereeAddress,
      builder: (context, state) {
        return ListTile(
            title: const Text('Mi dirección'),
            subtitle: Text(state.referee.refereeAddress ?? ''),
            trailing: IconButton(
              icon: const Icon(Icons.search, color: Colors.blue),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: BlocProvider.of<RefereeProfileCubit>(context),
                      child: const _SearchAddress(),
                    );
                  },
                );
              },
            ));
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

class _SearchAddress extends StatelessWidget {
  const _SearchAddress({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefereeProfileCubit, RefereeProfileState>(
        builder: (context, state) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text('Buscar dirección'),
            ),
            TextFormField(
              /*controller:
                      context.read<FieldOwnerCubit>().getTextAddresController,*/
              key: const Key('addres_field_search'),
              onChanged: (value) {
                if (value.trim().length > 7) {
                  context.read<RefereeProfileCubit>().onGetAddressse(value);
                }
              },
              style: const TextStyle(fontSize: 13),
            ),
            AddresAutoComplete()
          ],
        ),
      );
    });
  }
}

class AddresAutoComplete extends StatelessWidget {
  const AddresAutoComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefereeProfileCubit, RefereeProfileState>(
        builder: (context, state) {
      //if(state.addreses.length > 0){
      if (state.screenStatus == ScreenStatus.addresGeted) {
        return Container(
          margin: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * .3,
          width: MediaQuery.of(context).size.width * .8,
          color:
              (state.addreses.isNotEmpty) ? Colors.white : Colors.transparent,
          child: ListView.builder(
              itemCount: state.addreses.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 2,
                    child: ListTile(
                      title:
                          Text(state.addreses[index].location!.address!.label!),
                      onTap: () async {
                        //addMarker(value);
                        await context
                            .read<RefereeProfileCubit>()
                            .onUpdateLatLeng(
                                state.addreses[index].location!
                                    .navigationPosition[0].latitude!,
                                state.addreses[index].location!
                                    .navigationPosition[0].longitude!);
                        lstlong.LatLng latn = lstlong.LatLng(
                            state.addreses[index].location!
                                .navigationPosition[0].latitude!,
                            state.addreses[index].location!
                                .navigationPosition[0].longitude!);
                        await context
                            .read<RefereeProfileCubit>()
                            .addMarker(latn);
                        context
                            .read<RefereeProfileCubit>()
                            .getMapController
                            .move(latn, 17.00);
                        context
                            .read<RefereeProfileCubit>()
                            .onFieldLengthChange('${latn.longitude}');
                        context
                            .read<RefereeProfileCubit>()
                            .onFieldLatitudeChange('${latn.latitude}');
                        context
                                .read<RefereeProfileCubit>()
                                .getTextAddresController
                                .text =
                            state.addreses[index].location!.address!.label!;

                        context
                            .read<RefereeProfileCubit>()
                            .addDireccionAndMarket(lstlong.LatLng(
                                state.addreses[index].location!
                                    .navigationPosition[0].latitude!,
                                state.addreses[index].location!
                                    .navigationPosition[0].longitude!));

                        Navigator.pop(context);
                      },
                    ));
              }),
        );
      } else {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .3,
          width: MediaQuery.of(context).size.width * .3,
        );
      }
    });
  }
}

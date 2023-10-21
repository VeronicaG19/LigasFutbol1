import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lstlong;
import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../service_locator/injection.dart';
import '../cubit/update_field_cubit.dart';

class UpdateField extends StatelessWidget {
  final Field field;

  const UpdateField({
    Key? key,
    required this.field,
  }) : super(key: key);

  static Route route(Field field) =>
      MaterialPageRoute(builder: (_) => UpdateField(field: field));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<UpdateFieldCubit>()..assignFieldData(field),
      child: _PageContent(field: field),
    );
  }
}

class _PageContent extends StatefulWidget {
  final Field field;

  const _PageContent({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  State<_PageContent> createState() => _PageContentState();
}

//late final MapController _mapController;

class _PageContentState extends State<_PageContent> {
  @override
  void initState() {
    super.initState();
    //  _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar campo',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fill,
        ),
        elevation: 0.0,
      ),
      body: BlocConsumer<UpdateFieldCubit, UpdateFieldState>(
        listener: (context, state) {
          if (state.screenStatus == ScreenStatus.updateSucces) {
            showTopSnackBar(
              context,
              const CustomSnackBar.success(
                //backgroundColor: color2!,
                textScaleFactor: 1.0,
                message: "El campo se actualizó correctamente",
              ),
            );
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
                    left: 10, right: 10, top: 150, bottom: 70),
                child: Column(
                  children: [
                    Flexible(
                      child: BlocBuilder<UpdateFieldCubit, UpdateFieldState>(
                        builder: (context, state) {
                          if (state.screenStatus != ScreenStatus.loading) {
                            return FlutterMap(
                              mapController: context
                                  .read<UpdateFieldCubit>()
                                  .getMapController,
                              options: MapOptions(
                                  center: lstlong.LatLng(state.lat, state.leng),
                                  zoom: 14.0,
                                  maxZoom: 19.0,
                                  interactiveFlags: InteractiveFlag.all,
                                  onTap: (value, latlng) {
                                    context
                                        .read<UpdateFieldCubit>()
                                        .onFieldLatitudeChange(
                                            latlng.latitude.toString());

                                    context
                                        .read<UpdateFieldCubit>()
                                        .onFieldLengthChange(
                                            latlng.longitude.toString());
                                    context
                                        .read<UpdateFieldCubit>()
                                        .addDireccionAndMarket(latlng);
                                    context
                                        .read<UpdateFieldCubit>()
                                        .getMapController
                                        .move(latlng, 17.00);
                                  }),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  subdomains: ['a', 'b', 'c'],
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
                            return Container();
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
                        Row(
                          children: const [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: _NameField(),
                              ),
                            ),
                            /*Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: _TypeField(),
                          ),
                        ),*/
                          ],
                        ),
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
                            Padding(
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
                      SizedBox(
                        height: 10,
                      ),
                      Text("*Seleccionar una ubicacion del campo en el mapa*",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.red[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                      SizedBox(
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
                                          .read<UpdateFieldCubit>()
                                          .updateField();
                                      /* .whenComplete(
                                            () => Navigator.of(context).pop());*/
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
                                        'Editar campo',
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
        //),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateFieldCubit, UpdateFieldState>(
      // buildWhen: (previous, current) => previous.fieldName != current.fieldName,
      builder: (context, state) {
        return TextFormField(
          key: const Key('name_field'),
          onChanged: (value) =>
              context.read<UpdateFieldCubit>().onFieldNameChange(value),
          //onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          initialValue: state.detailField.fieldName,
          decoration: InputDecoration(
            labelText: "Nombre del campo : ",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.detailField.fieldName!.trim().length <= 0
                ? "Escriba el nombre del campo"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _AddresField extends StatelessWidget {
  const _AddresField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateFieldCubit, UpdateFieldState>(
      buildWhen: (previous, current) =>
          previous.detailField.fieldsAddress !=
          current.detailField.fieldsAddress,
      builder: (context, state) {
        return ListTile(
          title: const Text('Dirección del campo'),
          subtitle: Text(state.detailField.fieldsAddress ?? ''),
          trailing: IconButton(
            icon: const Icon(Icons.search, color: Colors.blue),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return BlocProvider.value(
                    value: BlocProvider.of<UpdateFieldCubit>(context),
                    child: const _SearchAddress(),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _SearchAddress extends StatelessWidget {
  const _SearchAddress({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateFieldCubit, UpdateFieldState>(
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
                  context.read<UpdateFieldCubit>().onGetAddressse(value);
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
    return BlocBuilder<UpdateFieldCubit, UpdateFieldState>(
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
                      await context.read<UpdateFieldCubit>().onUpdateLatLeng(
                          state.addreses[index].location!.navigationPosition[0]
                              .latitude!,
                          state.addreses[index].location!.navigationPosition[0]
                              .longitude!);
                      lstlong.LatLng latn = lstlong.LatLng(
                          state.addreses[index].location!.navigationPosition[0]
                              .latitude!,
                          state.addreses[index].location!.navigationPosition[0]
                              .longitude!);
                      await context.read<UpdateFieldCubit>().addMarker(latn);

                      context.read<UpdateFieldCubit>().onFieldLatitudeChange(
                          state.addreses[index].location!.navigationPosition[0]
                              .latitude
                              .toString());

                      context.read<UpdateFieldCubit>().onFieldLengthChange(state
                          .addreses[index]
                          .location!
                          .navigationPosition[0]
                          .longitude
                          .toString());

                      context.read<UpdateFieldCubit>().addDireccionAndMarket(
                          lstlong.LatLng(
                              state.addreses[index].location!
                                  .navigationPosition[0].latitude!,
                              state.addreses[index].location!
                                  .navigationPosition[0].longitude!));

                      context
                          .read<UpdateFieldCubit>()
                          .getMapController
                          .move(latn, 17.00);

                      context
                          .read<UpdateFieldCubit>()
                          .onFieldLengthChange('${latn.longitude}');
                      context
                          .read<UpdateFieldCubit>()
                          .onFieldLatitudeChange('${latn.latitude}');
                      context
                              .read<UpdateFieldCubit>()
                              .getTextAddresController
                              .text =
                          state.addreses[index].location!.address!.label!;

                      Navigator.pop(context);
                    },
                  ),
                );
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

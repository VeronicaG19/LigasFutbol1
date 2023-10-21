import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:formz/formz.dart';
import 'package:latlong2/latlong.dart' as lstlong;
import 'package:ligas_futbol_flutter/src/domain/lookupvalue/entity/lookupvalue.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/cubit/field_owner_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/app_bar_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CreateFieldOwnerPage extends StatelessWidget {
  const CreateFieldOwnerPage({Key? key}) : super(key: key);

  static Route route(FieldOwnerCubit cubit) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit..getTypeFields(),
          child: const CreateFieldOwnerPage(),
        ),
      );

  // FieldLmCubit, FieldLmState

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBarPage(
            title: "Crear campo",
            size: 100,
          ),
        ),
        body: const _CreateFieldOwnerContent());
  }
}

class _CreateFieldOwnerContent extends StatefulWidget {
  const _CreateFieldOwnerContent({Key? key}) : super(key: key);

  @override
  State<_CreateFieldOwnerContent> createState() =>
      _CreateFieldOwnerContentState();
}

late final MapController _mapController;

class _CreateFieldOwnerContentState extends State<_CreateFieldOwnerContent> {
  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leagueId =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    final personInfo =
        context.select((AuthenticationBloc bloc) => bloc.state.user.person);
    /*void launchGoogleMaps(double lat, double lng) async {
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
    }*/

    return BlocConsumer<FieldOwnerCubit, FieldOwnerState>(
      listenWhen: (previous, current) =>
          previous.formzStatus != current.formzStatus,
      listener: (context, state) {
        if (state.formzStatus == FormzStatus.submissionFailure) {
          showTopSnackBar(
            context,
            CustomSnackBar.info(
              backgroundColor: Colors.green[800]!,
              textScaleFactor: 1.0,
              message: state.errorMessage ?? 'Error',
            ),
          );
        } else if (state.formzStatus == FormzStatus.submissionSuccess) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: Colors.green[800]!,
              textScaleFactor: 1.0,
              message: 'Se ha creado el campo correctamente',
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 205, bottom: 70),
              child: Column(
                children: [
                  Flexible(
                    child: BlocBuilder<FieldOwnerCubit, FieldOwnerState>(
                      builder: (context, state) {
                        if (state.screenStatus == ScreenStatus.loading) {
                          return Container();
                        }
                        return FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                              center: lstlong.LatLng(state.lat, state.leng),
                              zoom: 14.0,
                              maxZoom: 19.0,
                              interactiveFlags: InteractiveFlag.all,
                              onTap: (value, latlng) {
                                context
                                    .read<FieldOwnerCubit>()
                                    .onFieldLatitudeChange(
                                        latlng.latitude.toString());

                                context
                                    .read<FieldOwnerCubit>()
                                    .onFieldLengthChange(
                                        latlng.longitude.toString());
                                context
                                    .read<FieldOwnerCubit>()
                                    .addDireccionAndMarket(latlng);
                                setState(() {
                                  _mapController.move(latlng, 17.00);
                                });
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
                child: const Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                          "Llenar los siguientes datos para crear un campo",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: _NameField(),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: _TypeField(),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: _AddresField(),
                      ),
                    ),
                  ],
                ),
              ),
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
                    state.formzStatus.isSubmissionInProgress
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
                                        .read<FieldOwnerCubit>()
                                        .onCleanFields();
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 10.0, 16.0, 10.0),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff740404),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      ),
                                    ),
                                    child: Text(
                                      'Cancelar',
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
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    await context
                                        .read<FieldOwnerCubit>()
                                        .createField(
                                            leagueId: leagueId.leagueId,
                                            partyId: personInfo.personId);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 10.0, 16.0, 10.0),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff045a74),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      ),
                                    ),
                                    child: Text(
                                      'Crear campo',
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
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldOwnerCubit, FieldOwnerState>(
      buildWhen: (previous, current) => previous.fieldName != current.fieldName,
      builder: (context, state) {
        return TextFormField(
          key: const Key('name_field'),
          onChanged: (value) =>
              context.read<FieldOwnerCubit>().onFieldNameChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Nombre del campo : ",
            labelStyle: const TextStyle(fontSize: 13),
            errorText:
                state.fieldName.invalid ? "Escriba el nombre del campo" : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _AddresField extends StatelessWidget {
  const _AddresField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldOwnerCubit, FieldOwnerState>(
      buildWhen: (previous, current) =>
          previous.fieldAddres != current.fieldAddres,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) {
                return BlocProvider.value(
                  value: BlocProvider.of<FieldOwnerCubit>(context),
                  child: const _SearchAddress(),
                );
              },
            );
          },
          child: TextFormField(
            controller: context.read<FieldOwnerCubit>().getTextAddresController,
            enabled: false,
            //readOnly: true,
            key: const Key('addres_field'),
            onChanged: (value) {
              if (value.trim().length > 7) {
                context.read<FieldOwnerCubit>().onGetAddressse(value);
              }

              context.read<FieldOwnerCubit>().onFieldAddresChange(value);
            },
            //onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
            decoration: InputDecoration(
              icon: const Icon(Icons.search, color: Colors.blue),
              labelText: "Selecciona un punto en el mapa",
              labelStyle: const TextStyle(fontSize: 13),
              errorText: state.fieldAddres.invalid
                  ? "Selecciona un punto en el mapa"
                  : null,
            ),
            style: const TextStyle(fontSize: 13),
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
    return BlocBuilder<FieldOwnerCubit, FieldOwnerState>(
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
                  context.read<FieldOwnerCubit>().onGetAddressse(value);
                }
              },
              style: const TextStyle(fontSize: 13),
            ),
            AutocompleteBasicExample()
          ],
        ),
      );
    });
  }
}

class AutocompleteBasicExample extends StatelessWidget {
  const AutocompleteBasicExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldOwnerCubit, FieldOwnerState>(
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
                      await context.read<FieldOwnerCubit>().onUpdateLatLeng(
                          state.addreses[index].location!.navigationPosition[0]
                              .latitude!,
                          state.addreses[index].location!.navigationPosition[0]
                              .longitude!);
                      lstlong.LatLng latn = lstlong.LatLng(
                          state.addreses[index].location!.navigationPosition[0]
                              .latitude!,
                          state.addreses[index].location!.navigationPosition[0]
                              .longitude!);
                      await context.read<FieldOwnerCubit>().addMarker(latn);

                      context.read<FieldOwnerCubit>().onFieldLatitudeChange(
                          state.addreses[index].location!.navigationPosition[0]
                              .latitude
                              .toString());

                      context.read<FieldOwnerCubit>().onFieldLengthChange(state
                          .addreses[index]
                          .location!
                          .navigationPosition[0]
                          .longitude
                          .toString());

                      context.read<FieldOwnerCubit>().addDireccionAndMarket(
                          lstlong.LatLng(
                              state.addreses[index].location!
                                  .navigationPosition[0].latitude!,
                              state.addreses[index].location!
                                  .navigationPosition[0].longitude!));

                      _mapController.move(latn, 17.00);

                      context
                          .read<FieldOwnerCubit>()
                          .onFieldLengthChange('${latn.longitude}');
                      context
                          .read<FieldOwnerCubit>()
                          .onFieldLatitudeChange('${latn.latitude}');
                      context
                              .read<FieldOwnerCubit>()
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

class _TypeField extends StatefulWidget {
  const _TypeField({Key? key}) : super(key: key);

  @override
  State<_TypeField> createState() => _TypeFieldInputState();
}

class _TypeFieldInputState extends State<_TypeField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldOwnerCubit, FieldOwnerState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: const Row(
              children: [
                Icon(
                  Icons.app_registration,
                  size: 16,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'Tipo de campo',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: state.lookUpValues
                .map((item) => DropdownMenuItem<LookUpValue>(
                      value: item,
                      child: Text(
                        item.lookupName!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[200],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              context.read<FieldOwnerCubit>().onFieldTypeChange(value!);
            },
            value: state.lookupSelect,
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.white70,
            itemHighlightColor: Colors.white70,
            iconDisabledColor: Colors.white70,
            buttonHeight: 40,
            buttonWidth: double.infinity,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.blueGrey,
              ),
              color: Colors.blueGrey,
            ),
            buttonElevation: 2,
            itemHeight: 40,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xff358aac),
              ),
              color: Colors.black54,
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            selectedItemHighlightColor: const Color(0xff358aac),
            scrollbarAlwaysShow: true,
            offset: const Offset(-20, 0),
          ),
        );
      },
    );
  }
}

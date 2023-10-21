import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:formz/formz.dart';
import 'package:latlong2/latlong.dart' as lstlong;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/lookupvalue/entity/lookupvalue.dart';
import '../../../app/app.dart';
import 'cubit/field_lm_cubit.dart';

class CreateFieldLeagueManager extends StatefulWidget {
  const CreateFieldLeagueManager({Key? key}) : super(key: key);

  @override
  State<CreateFieldLeagueManager> createState() =>
      _CreateFieldLeagueManagerState();
}

class _CreateFieldLeagueManagerState extends State<CreateFieldLeagueManager> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>['Futbol 7', 'Futbol 5', 'Futbol 11'];
    String dropdownValue = list.first;
    final personInfo =
        context.select((AuthenticationBloc bloc) => bloc.state.user.person);
    final leagueId =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);

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

    return /*BlocProvider(
      // create: (_) => locator<FieldLmCubit>(),
      create: (_) => locator<FieldLmCubit>()..getTypeFields(),
      child: */
        BlocConsumer<FieldLmCubit, FieldLmState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 100, right: 100, top: 140, bottom: 70),
              child: Column(
                children: [
                  Flexible(
                    child: BlocBuilder<FieldLmCubit, FieldLmState>(
                      builder: (context, state) {
                        if (state.screenStatus != ScreenStatus.loading) {
                          return FlutterMap(
                            mapController:
                                context.read<FieldLmCubit>().getMapController,
                            options: MapOptions(
                                center: lstlong.LatLng(state.lat, state.leng),
                                zoom: 14.0,
                                maxZoom: 19.0,
                                interactiveFlags: InteractiveFlag.all,
                                onTap: (value, latlng) {
                                  print("latitude --- > ${latlng.latitude}");
                                  print("longitude --- > ${latlng.longitude}");
                                  print("longitude --- > ");
                                  context
                                      .read<FieldLmCubit>()
                                      .onFieldLatitudeChange(
                                          latlng.latitude.toString());

                                  context
                                      .read<FieldLmCubit>()
                                      .onFieldLengthChange(
                                          latlng.longitude.toString());
                                  context
                                      .read<FieldLmCubit>()
                                      .addDireccionAndMarket(latlng);
                                  context
                                      .read<FieldLmCubit>()
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
                padding: EdgeInsets.only(left: 50, right: 50),
                height: 145.0,
                color: Colors.grey[200],
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Text(
                          "Llenar los siguientes datos para crear un campo",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18)),
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
                              child: _AddresField()),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: _TypeField(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: AutocompleteBasicExample())
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
                    SizedBox(
                      height: 10,
                    ),
                    Text("*Seleccionar una ubicación del campo en el mapa*",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    SizedBox(
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
                                  onPressed: () async {
                                    await context
                                        .read<FieldLmCubit>()
                                        .onCleanFields()
                                        .whenComplete(
                                            () => Navigator.pop(context));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 10.0, 16.0, 10.0),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff740404),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
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
                                        .read<FieldLmCubit>()
                                        .createField(
                                            leagueId: leagueId.leagueId,
                                            partyId: personInfo.personId)
                                        .whenComplete(
                                            () => Navigator.of(context).pop());
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
    return BlocBuilder<FieldLmCubit, FieldLmState>(
      buildWhen: (previous, current) => previous.fieldName != current.fieldName,
      builder: (context, state) {
        return TextFormField(
          key: const Key('name_field'),
          onChanged: (value) =>
              context.read<FieldLmCubit>().onFieldNameChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Nombre del campo : ",
            labelStyle: TextStyle(fontSize: 13),
            errorText:
                state.fieldName.invalid ? "Escriba el nombre del campo" : null,
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
    return BlocBuilder<FieldLmCubit, FieldLmState>(
      buildWhen: (previous, current) =>
          previous.fieldAddres != current.fieldAddres,
      builder: (context, state) {
        return TextFormField(
          controller: context.read<FieldLmCubit>().getTextAddresController,
          key: const Key('addres_field'),
          onChanged: (value) {
            if (value.trim().length > 7) {
              context.read<FieldLmCubit>().onGetAddressse(value);
            }

            context.read<FieldLmCubit>().onFieldAddresChange(value);
          },
          //onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Dirección del campo : ",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.fieldAddres.invalid
                ? "Escriba la dirección del campo"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class AutocompleteBasicExample extends StatelessWidget {
  const AutocompleteBasicExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldLmCubit, FieldLmState>(builder: (context, state) {
      //if(state.addreses.length > 0){
      if (state.screenStatus == ScreenStatus.addresGeted) {
        return Container(
          margin: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * .3,
          width: MediaQuery.of(context).size.width * .3,
          color: (state.addreses.length > 0)
              ? Colors.black.withOpacity(0.7)
              : Colors.transparent,
          child: ListView.builder(
              itemCount: state.addreses.length,
              itemBuilder: (context, index) {
                print(state.addreses.length);
                return ListTile(
                  title: Text(state.addreses[index].location!.address!.label!),
                  onTap: () async {
                    //addMarker(value);
                    await context.read<FieldLmCubit>().onUpdateLatLeng(
                        state.addreses[index].location!.navigationPosition[0]
                            .latitude!,
                        state.addreses[index].location!.navigationPosition[0]
                            .longitude!);
                    lstlong.LatLng latn = lstlong.LatLng(
                        state.addreses[index].location!.navigationPosition[0]
                            .latitude!,
                        state.addreses[index].location!.navigationPosition[0]
                            .longitude!);
                    await context.read<FieldLmCubit>().addMarker(latn);
                    context
                        .read<FieldLmCubit>()
                        .getMapController
                        .move(latn, 17.00);
                    context
                        .read<FieldLmCubit>()
                        .onFieldLengthChange('${latn.longitude}');
                    context
                        .read<FieldLmCubit>()
                        .onFieldLatitudeChange('${latn.latitude}');
                    context.read<FieldLmCubit>().getTextAddresController.text =
                        state.addreses[index].location!.address!.label!;
                  },
                );
              }),
        );
      } else {
        return Container(
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
    return BlocBuilder<FieldLmCubit, FieldLmState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: const [
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
              context.read<FieldLmCubit>().onFieldTypeChange(value!);
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../domain/player/entity/position.dart';
import '../../../../widgets/edit_profile_image/view/profile_image_widget.dart';
import '../../cubit/player_profile_cubit.dart';
import 'edit_address_profile.dart';

class EditPlayerProfileContent extends StatefulWidget {
  const EditPlayerProfileContent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditPlayerProfileContentState();

}

class _EditPlayerProfileContentState extends State<EditPlayerProfileContent>{
  @override
  Widget build(BuildContext context) {
    List positions = [
      Positions(preferencePosition: 'Portero', preferencePositionId: 1),
      Positions(preferencePosition: 'Defensa', preferencePositionId: 2),
      Positions(preferencePosition: 'Defensa Central', preferencePositionId: 3),
      Positions(preferencePosition: 'Defensa Lateral', preferencePositionId: 4),
      Positions(preferencePosition: 'Mediocampista', preferencePositionId: 5),
      Positions(preferencePosition: 'Media punta', preferencePositionId: 6),
      Positions(preferencePosition: 'Delantero', preferencePositionId: 7),
      Positions(preferencePosition: 'Extremo', preferencePositionId: 8),
      Positions(preferencePosition: 'Delantero central', preferencePositionId: 9)
    ];
    return BlocConsumer<PlayerProfileCubit, PlayerProfileState>(
        
        listener: (context, state) {
          if (state.formStatus == FormzStatus.submissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("Se actualizaron los datos correctamente"),
                ),
              );
          }else if (state.formStatus.isSubmissionFailure){
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("Error al actualizar los datos correctamente"),
                ),
              );
          }
        }, builder: (context, state) {
      if (state.screenStatus == ScreenStatus.loading) {
        return Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            color: Colors.blueAccent,
            size: 50,
          ),
        );
      } else if (state.screenStatus == ScreenStatus.loaded ||
          state.screenStatus == ScreenStatus.error) {
        return Scaffold(
          body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 160.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/imageAppBar25.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                        child: ProfileImageWidget(
                          radius: 50,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 16),
                          child: TextFormField(
                            initialValue: state.playerInfo.nickName,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.badge),
                              border: OutlineInputBorder(),
                              labelText: 'Sobre Nombre',
                            ),
                            onChanged: (value) => context
                                .read<PlayerProfileCubit>()
                                .onchangeTag(value),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .99,
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 25, 0),
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              DateTime? pickedDate =
                              await showDatePicker(
                                context: context,
                                initialDate: state.playerInfo.birthday ?? DateTime.now(),
                                firstDate: DateTime(1923),
                                lastDate: DateTime.now(),
                              );
                              final DateFormat formatter = DateFormat('dd-MM-yyyy');
                              final String formatted = formatter.format(pickedDate ?? DateTime.now());
                              context.read<PlayerProfileCubit>().onchangeBirthDay(pickedDate!);
                            },
                            icon: const Icon(Icons.calendar_today),
                            label: Text(
                              'Fecha de nacimiento ${DateFormat('dd-MM-yyyy').format(
                                state.playerInfo.birthday == null
                                    ? DateTime.now()
                                    : state.playerInfo.birthday!,
                              )}',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 16),
                          child: DropdownButtonFormField<Positions>(
                            value: positions.firstWhere(
                                    (element) =>
                                element.preferencePosition ==
                                    state.playerInfo.preferencePosition,
                                orElse: () {
                                  return positions[0];
                                }),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.sports_soccer),
                              border: OutlineInputBorder(),
                            ),
                            //icon: const Icon(Icons.sports_soccer),
                            isExpanded: true,
                            hint: const Text('Selecciona una posición'),
                            items: List.generate(
                              positions.length,
                                  (index) {
                                final content = positions[index].preferencePosition;
                                return DropdownMenuItem(
                                  value: positions[index],
                                  child: Text(content.trim().isEmpty
                                      ? 'Selecciona la posicion'
                                      : content),
                                );
                              },
                            ),
                            onChanged: (value) {
                              context
                                  .read<PlayerProfileCubit>()
                                  .onChagePos(value!);
                            },
                          ),
                        ),
                         Container(
                          width: MediaQuery.of(context).size.width * .99,
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 25, 0),
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                            context,
                            EditAddressProfile.route(BlocProvider.of<PlayerProfileCubit>(context), state.playerInfo));
                            },
                            icon: const Icon(Icons.edit),
                            label: Text(
                              state.playerInfo.playerAddress ?? 'Sin dirección',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        /*Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 16),
                          child: TextFormField(
                            initialValue: state.playerInfo.playerAddress,
                            maxLines: 5,
                            minLines: 3,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.place),
                              border: OutlineInputBorder(),
                              labelText: 'Dirección',
                            ), 
                            onChanged: (value) => context
                                .read<PlayerProfileCubit>()
                                .onchangeAddresPlayer(value),
                          ),
                        ),*/
                      ],
                    ),
                    // MyCustomForm(player: state.playerInfo),
                    GestureDetector(
                      onTap: () async {
                        await context
                            .read<PlayerProfileCubit>()
                            .onUpdatePersonName();
                        Navigator.pop(context);
                      },
                      child: Container(
                        //onUpdatePersonName
                        margin: const EdgeInsets.all(30.0),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          gradient: const LinearGradient(colors: [
                            Color(0xFF03A0FE),
                            Color(0xFF03A0FE),
                          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        ),
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: const Text("Guardar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ),
                    )
                  ],
                ),
              )),
        );
      } else {
        return Container();
      }
    });
  }
}
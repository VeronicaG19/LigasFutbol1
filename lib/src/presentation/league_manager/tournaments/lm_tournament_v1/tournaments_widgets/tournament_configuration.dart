import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/domain/lookupvalue/entity/lookupvalue.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/tournaments_widgets/need_select_tournament_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../lm_tournament_v2/main_page/cubit/tournament_main_cubit.dart';
import '../cubit/tournament_cubit.dart';
import 'delete_tournament_modal.dart';

class ConfigurationTournament extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TournamentCubit, TournamentState>(
        listenWhen: (previous, current) =>
            previous.screenStatus != current.screenStatus,
        listener: (context, state) {
          if (state.screenStatus == ScreenStatus.changedTournament) {
            context
                .read<TournamentMainCubit>()
                .onUpdateSelectedTournament(state.tournamentSelected);
          }
        },
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.changedTournament) {
            return (state.tournamentSelected.tournamentName == null)
                ? const NeedSlctTournamentPage()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'Estado del torneo',
                                      style: TextStyle(fontSize: 29),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SwitchListTile(
                                        activeThumbImage: const AssetImage(
                                            'assets/images/unlocked.png'),
                                        inactiveThumbImage: const AssetImage(
                                            'assets/images/padlock.png'),
                                        activeColor: Colors.green[300],
                                        title: state.tournamentSelected
                                                    .tournamentPrivacy ==
                                                'Y'
                                            ? const Text('Publico')
                                            : const Text('Privado'),
                                        value: state.tournamentSelected
                                                    .tournamentPrivacy ==
                                                'Y'
                                            ? true
                                            : false,
                                        onChanged: (val) {
                                          context
                                              .read<TournamentCubit>()
                                              .onchangePrivacity(val);
                                        }),
                                    SwitchListTile(
                                        activeThumbImage: const AssetImage(
                                            'assets/images/unlocked.png'),
                                        inactiveThumbImage: const AssetImage(
                                            'assets/images/padlock.png'),
                                        activeColor: Colors.green[300],
                                        title: state.tournamentSelected
                                                    .statusBegin ==
                                                'Y'
                                            ? const Text('Abierto')
                                            : const Text('Cerrado'),
                                        value: state.tournamentSelected
                                                    .statusBegin ==
                                                'Y'
                                            ? true
                                            : false,
                                        onChanged: (val) {
                                          context
                                              .read<TournamentCubit>()
                                              .onchangeBegin(val);
                                        }),
                                  ],
                                ),
                              ],
                            )),
                            Expanded(
                                child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Ajustes del torneo',
                                        style: TextStyle(fontSize: 29),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Nombre del torneo',
                                        ),
                                        initialValue: state
                                            .tournamentSelected.tournamentName,
                                        onChanged: (val) {
                                          context
                                              .read<TournamentCubit>()
                                              .onChangeName(
                                                  tournamentName: val);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: DropdownButtonFormField<
                                                LookUpValue>(
                                              value: state.lookUpValues[state
                                                  .lookUpValues
                                                  .indexWhere((element) =>
                                                      element.lookupValue
                                                          .toString() ==
                                                      state.tournamentSelected
                                                          .typeTournament)],
                                              decoration: const InputDecoration(
                                                label: Text('Tipo de torneo'),
                                                border: OutlineInputBorder(),
                                              ),
                                              //icon: const Icon(Icons.sports_soccer),
                                              isExpanded: true,
                                              hint: const Text(
                                                  'Selecciona un tipo de torneo'),
                                              items: List.generate(
                                                state.lookUpValues.length,
                                                (index) {
                                                  final content = state
                                                      .lookUpValues[index]
                                                      .lookupName!;
                                                  return DropdownMenuItem(
                                                    child: Text(content
                                                            .trim()
                                                            .isEmpty
                                                        ? 'Selecciona un tipo de torneo'
                                                        : content),
                                                    value: state
                                                        .lookUpValues[index],
                                                  );
                                                },
                                              ),
                                              onChanged: (value) {
                                                context
                                                    .read<TournamentCubit>()
                                                    .ontTournamentChange(
                                                        tyTournamnet: value!);
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                              child: ElevatedButton.icon(
                                            onPressed: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime
                                                    .now(), //get today's date
                                                firstDate: DateTime
                                                    .now(), //DateTime.now() - not to allow to choose before today.
                                                lastDate: DateTime(
                                                    DateTime.now().year + 2),
                                              );
                                              context
                                                  .read<TournamentCubit>()
                                                  .onchangeTournamentDate(
                                                      pickedDate!);
                                            },
                                            icon: const Icon(Icons.date_range),
                                            label: Text(
                                              'Fecha de inicio ${DateFormat('yyyy-MM-dd').format(
                                                state.tournamentSelected
                                                            .inscriptionDate ==
                                                        null
                                                    ? DateTime.now()
                                                    : state.tournamentSelected
                                                        .inscriptionDate!,
                                              )}',
                                            ),
                                          )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              enabled: false,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Categoria',
                                              ),
                                              initialValue:
                                                  '${state.tournamentSelected.categoryId?.categoryName}',
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              enabled: false,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Género',
                                              ),
                                              initialValue: (state
                                                          .tournamentSelected
                                                          .categoryId
                                                          ?.gender ==
                                                      1)
                                                  ? 'Varonil'
                                                  : (state
                                                              .tournamentSelected
                                                              .categoryId
                                                              ?.gender ==
                                                          1)
                                                      ? 'Femenil'
                                                      : 'Mixto',
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      //////
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Equipos permitidos',
                                              ),
                                              initialValue:
                                                  '${state.tournamentSelected.maxTeams ?? 0}',
                                              onChanged: (val) {
                                                context
                                                    .read<TournamentCubit>()
                                                    .onchangePermitedTeams(val);
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText:
                                                    'Jugadores por equipo',
                                              ),
                                              initialValue:
                                                  '${state.tournamentSelected.maxPlayers ?? 0}',
                                              onChanged: (val) {
                                                context
                                                    .read<TournamentCubit>()
                                                    .onchangePermitedPlayers(
                                                        val);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Text('Días de partidos'),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 180,
                                                childAspectRatio: 5 / 3,
                                                crossAxisSpacing: 9,
                                                mainAxisSpacing: 15),
                                        itemCount: state.daysList.length,
                                        itemBuilder: (context, index) {
                                          return CheckboxListTile(
                                            enabled: true,
                                            title: Text(state.daysList[index]
                                                    .daysEnum?.name ??
                                                ''),
                                            value: state
                                                .daysList[index].isSelected,
                                            onChanged: (bool? value) {
                                              context
                                                  .read<TournamentCubit>()
                                                  .inchangeDays(value!,
                                                      state.daysList[index]);
                                            }, //  <-- leading Checkbox
                                          );
                                        },
                                      )
                                      //DaysCheckBoc()
                                    ],
                                  ),
                                )
                              ],
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Configuración de partidos',
                          style: TextStyle(fontSize: 29),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<LookUpValue>(
                                value: state.typeOfGames.isNotEmpty
                                    ? state.typeOfGames[state.typeOfGames
                                        .indexWhere((element) =>
                                            element.lookupValue.toString() ==
                                            state
                                                .tournamentSelected.typeOfGame)]
                                    : null,
                                decoration: const InputDecoration(
                                  label: Text('Tipo de juego'),
                                  border: OutlineInputBorder(),
                                ),
                                //icon: const Icon(Icons.sports_soccer),
                                isExpanded: true,
                                hint: const Text('Tipo de juego'),
                                items: List.generate(
                                  state.typeOfGames.length,
                                  (index) {
                                    final content =
                                        state.typeOfGames[index].lookupName!;
                                    return DropdownMenuItem(
                                      enabled: false,
                                      child: Text(content.trim().isEmpty
                                          ? 'Tipo de juego'
                                          : content),
                                      value: state.typeOfGames[index],
                                    );
                                  },
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text('Permite tarjetas azules'),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    //fillColor: MaterialStateProperty.resolveWith(Colors.green),
                                    value: ((state.tournamentSelected
                                                    .activateBlueCard ??
                                                'N') ==
                                            'Y')
                                        ? true
                                        : false,
                                    onChanged: (value) {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Partidos',
                                        style: TextStyle(fontSize: 29),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              initialValue:
                                                  '${state.tournamentSelected.gameTimes}',
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Tiempo(s)',
                                              ),
                                              onChanged: (value) {
                                                context
                                                    .read<TournamentCubit>()
                                                    .onchangeMatchTime(value);
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              initialValue:
                                                  '${state.tournamentSelected.durationByTime}',
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Duración',
                                              ),
                                              onChanged: (value) {
                                                context
                                                    .read<TournamentCubit>()
                                                    .onchangeDuratitonTime(
                                                        value);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                const Text(
                                                    'Sanciones por tarjeta'),
                                                Checkbox(
                                                  checkColor: Colors.white,
                                                  //fillColor: MaterialStateProperty.resolveWith(Colors.green),
                                                  value: ((state.tournamentSelected
                                                                  .temporaryReprimands ??
                                                              'N') ==
                                                          'Y')
                                                      ? true
                                                      : false,
                                                  onChanged: (value) {
                                                    context
                                                        .read<TournamentCubit>()
                                                        .onchangeBycards(
                                                            value!);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                const Text('Tarjeta roja'),
                                                TextFormField(
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText:
                                                        'Partidos por sanción',
                                                  ),
                                                  initialValue:
                                                      '${state.tournamentSelected.redCardFine ?? ''}',
                                                  onChanged: (value) {
                                                    context
                                                        .read<TournamentCubit>()
                                                        .onchangeredCardFine(
                                                            value);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Visibility(
                                              visible: ((state.tournamentSelected
                                                              .temporaryReprimands ??
                                                          'N') ==
                                                      'Y')
                                                  ? true
                                                  : false,
                                              child: Column(
                                                children: [
                                                  const Text(
                                                      'Tarjeta amarilla'),
                                                  TextFormField(
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText:
                                                          'Partidos por sanción',
                                                    ),
                                                    initialValue:
                                                        '${state.tournamentSelected.yellowCardFine ?? ''}',
                                                    onChanged: (value) {
                                                      context
                                                          .read<
                                                              TournamentCubit>()
                                                          .onchangeyellowCardFine(
                                                              value);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      //////
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                const Text(
                                                    'Cambios ilimitados'),
                                                Checkbox(
                                                  checkColor: Colors.white,
                                                  //fillColor: MaterialStateProperty.resolveWith(Colors.green),
                                                  value: ((state.tournamentSelected
                                                                  .unlimitedChanges ??
                                                              'N') ==
                                                          'Y')
                                                      ? true
                                                      : false,
                                                  onChanged: (value) {
                                                    context
                                                        .read<TournamentCubit>()
                                                        .onchangeUnlimitedChanges(
                                                            value!);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Visibility(
                                              visible: ((state.tournamentSelected
                                                              .unlimitedChanges ??
                                                          'N') ==
                                                      'Y')
                                                  ? false
                                                  : true,
                                              child: Column(
                                                children: [
                                                  const Text('Cambios'),
                                                  TextFormField(
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'Total',
                                                    ),
                                                    initialValue:
                                                        '${state.tournamentSelected.gameChanges ?? ''}',
                                                    onChanged: (value) {
                                                      context
                                                          .read<
                                                              TournamentCubit>()
                                                          .onchangegameChanges(
                                                              value);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Sanciones',
                                        style: TextStyle(fontSize: 29),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              initialValue:
                                                  '${state.tournamentSelected.breaksNumber}',
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Descanso(s)',
                                              ),
                                              onChanged: (value) {
                                                context
                                                    .read<TournamentCubit>()
                                                    .onchangebreaksNumber(
                                                        value);
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              initialValue:
                                                  '${state.tournamentSelected.breaksDuration}',
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Duración',
                                              ),
                                              onChanged: (value) {
                                                context
                                                    .read<TournamentCubit>()
                                                    .onchangebreaksDuration(
                                                        value);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        final exampleCubit =
                                            context.read<TournamentCubit>();
                                        return BlocProvider<
                                                TournamentCubit>.value(
                                            value: exampleCubit,
                                            child: DeleteTournamentModal());
                                      });
                                },
                                icon: Icon(
                                  // <-- Icon
                                  Icons.delete_forever_outlined,
                                  size: 24.0,
                                ),
                                label: Text('Eliminar'), // <-- Text
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.green)),
                                onPressed: () {
                                  context
                                      .read<TournamentCubit>()
                                      .updateTournament();
                                },
                                icon: Icon(
                                  // <-- Icon
                                  Icons.save,
                                  size: 24.0,
                                ),
                                label: Text('Guardar cambios'), // <-- Text
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
          } else if (state.screenStatus == ScreenStatus.changeTournament) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            );
          } else {
            return NeedSlctTournamentPage();
          }
        });
  }
}

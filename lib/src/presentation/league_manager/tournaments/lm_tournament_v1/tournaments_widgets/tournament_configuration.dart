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
          } else if (state.screenStatus == ScreenStatus.tournamentDeleted) {
            context.read<TournamentMainCubit>().onReloadTournaments();
          }
        },
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.changedTournament) {
            return (state.tournamentSelected.tournamentName == null)
                ? const NeedSlctTournamentPage()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'Estado del torneo',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    const Divider(indent: 1),
                                    SwitchListTile(
                                        activeThumbImage: const AssetImage(
                                            'assets/images/unlocked.png'),
                                        inactiveThumbImage: const AssetImage(
                                            'assets/images/padlock.png'),
                                        activeColor: Colors.green[300],
                                        title: state.tournamentSelected
                                                    .tournamentPrivacy ==
                                                'Y'
                                            ? const Text(
                                                'Publico',
                                                style: TextStyle(
                                                  fontFamily: 'SF Pro',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              )
                                            : const Text(
                                                'Privado',
                                                style: TextStyle(
                                                  fontFamily: 'SF Pro',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              ),
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
                                            ? const Text(
                                                'Abierto',
                                                style: TextStyle(
                                                  fontFamily: 'SF Pro',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              )
                                            : const Text(
                                                'Cerrado',
                                                style: TextStyle(
                                                  fontFamily: 'SF Pro',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              ),
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
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Ajustes del torneo',
                                        style: TextStyle(
                                          fontFamily: 'SF Pro',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      const Divider(indent: 1),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: 'Nombre del torneo',
                                          labelStyle: TextStyle(fontSize: 13),
                                        ),
                                        initialValue: state
                                            .tournamentSelected.tournamentName,
                                        onChanged: (val) {
                                          context
                                              .read<TournamentCubit>()
                                              .onChangeName(
                                                  tournamentName: val);
                                        },
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),

                                      Row(
                                        children: [
                                          const Expanded(
                                            child: _TournamentTypeSelection(),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                              child: ElevatedButton.icon(
                                            style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                      Color>(Colors.blueGrey),
                                            ),
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
                                            icon: const Icon(Icons.date_range,
                                                size: 18),
                                            label: Text(
                                                'Fecha de inicio ${DateFormat('yyyy-MM-dd').format(
                                                  state.tournamentSelected
                                                              .inscriptionDate ==
                                                          null
                                                      ? DateTime.now()
                                                      : state.tournamentSelected
                                                          .inscriptionDate!,
                                                )}',
                                                style: TextStyle(fontSize: 13)),
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
                                                labelText: 'Categoria',
                                              ),
                                              initialValue:
                                                  '${state.tournamentSelected.categoryId?.categoryName}',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              enabled: false,
                                              decoration: const InputDecoration(
                                                labelStyle:
                                                    TextStyle(fontSize: 13),
                                                labelText: 'Género',
                                              ),
                                              style: TextStyle(fontSize: 13),
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
                                                          2)
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
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: const InputDecoration(
                                                labelStyle:
                                                    TextStyle(fontSize: 13),
                                                labelText: 'Equipos permitidos',
                                              ),
                                              style: TextStyle(fontSize: 13),
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
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: const InputDecoration(
                                                labelStyle:
                                                    TextStyle(fontSize: 13),
                                                labelText:
                                                    'Jugadores por equipo',
                                              ),
                                              style: TextStyle(fontSize: 13),
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
                                        height: 10,
                                      ),
                                      /*  const Text('Días de partidos'),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                     GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 145,
                                                childAspectRatio: 2 / 1,
                                                crossAxisSpacing: 20,
                                                mainAxisSpacing: 20),
                                        itemCount: state.daysList.length,
                                        itemBuilder: (context, index) {
                                          return CheckboxListTile(
                                            enabled: true,
                                            title: Text(
                                                state.daysList[index].daysEnum
                                                        ?.name ??
                                                    '',
                                                style: TextStyle(fontSize: 13)),
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
                                      )*/
                                      //DaysCheckBoc()
                                    ],
                                  ),
                                )
                              ],
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      const Text(
                                        'Configuración de partidos',
                                        style: TextStyle(
                                          fontFamily: 'SF Pro',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      const Divider(indent: 1),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Row(children: [
                                        Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 100, left: 100),
                                              child: DropdownButtonFormField<
                                                  LookUpValue>(
                                                value: state
                                                        .typeOfGames.isNotEmpty
                                                    ? state.typeOfGames[state
                                                        .typeOfGames
                                                        .indexWhere((element) =>
                                                            element.lookupValue
                                                                .toString() ==
                                                            state
                                                                .tournamentSelected
                                                                .typeOfGame)]
                                                    : null,
                                                style: const TextStyle(
                                                    fontSize: 13),
                                                decoration:
                                                    const InputDecoration(
                                                  label: Text('Tipo de juego',
                                                      style: const TextStyle(
                                                          fontSize: 13)),
                                                ),
                                                //icon: const Icon(Icons.sports_soccer),
                                                isExpanded: true,
                                                hint:
                                                    const Text('Tipo de juego'),
                                                items: List.generate(
                                                  state.typeOfGames.length,
                                                  (index) {
                                                    final content = state
                                                        .typeOfGames[index]
                                                        .lookupName!;
                                                    return DropdownMenuItem(
                                                      enabled: false,
                                                      child: Text(
                                                          content.trim().isEmpty
                                                              ? 'Tipo de juego'
                                                              : content),
                                                      value: state
                                                          .typeOfGames[index],
                                                    );
                                                  },
                                                ),
                                                onChanged: (value) {},
                                              )),
                                        ),
                                      ]),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(children: [
                                        Expanded(
                                          child: const Text(
                                            'Partidos',
                                            style: TextStyle(
                                              fontFamily: 'SF Pro',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ]),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              initialValue:
                                                  '${state.tournamentSelected.gameTimes}',
                                              decoration: const InputDecoration(
                                                labelStyle:
                                                    TextStyle(fontSize: 13),
                                                labelText: 'Tiempo(s)',
                                              ),
                                              onChanged: (value) {
                                                context
                                                    .read<TournamentCubit>()
                                                    .onchangeMatchTime(value);
                                              },
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          Expanded(
                                              child: SizedBox(
                                            width: 5,
                                          )),
                                          Expanded(
                                            child: TextFormField(
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              initialValue:
                                                  '${state.tournamentSelected.durationByTime}',
                                              decoration: const InputDecoration(
                                                labelStyle:
                                                    TextStyle(fontSize: 13),
                                                labelText: 'Duración',
                                              ),
                                              style: TextStyle(fontSize: 13),
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
                                            child: Row(
                                              children: [
                                                /* Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Permite tarjetas azules',
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                      Checkbox(
                                                        checkColor:
                                                            Colors.white,
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
                                                ),*/
                                                Expanded(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            'Sanciones',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    TextFormField(
                                                                  inputFormatters: <TextInputFormatter>[
                                                                    FilteringTextInputFormatter
                                                                        .digitsOnly
                                                                  ],
                                                                  initialValue:
                                                                      '${state.tournamentSelected.breaksNumber}',
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    labelStyle: TextStyle(
                                                                        fontSize:
                                                                            13),
                                                                    labelText:
                                                                        'Descanso(s)',
                                                                  ),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                  onChanged:
                                                                      (value) {
                                                                    context
                                                                        .read<
                                                                            TournamentCubit>()
                                                                        .onchangebreaksNumber(
                                                                            value);
                                                                  },
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 20,
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    TextFormField(
                                                                  inputFormatters: <TextInputFormatter>[
                                                                    FilteringTextInputFormatter
                                                                        .digitsOnly
                                                                  ],
                                                                  initialValue:
                                                                      '${state.tournamentSelected.breaksDuration}',
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    labelStyle: TextStyle(
                                                                        fontSize:
                                                                            13),
                                                                    labelText:
                                                                        'Duración',
                                                                  ),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                  onChanged:
                                                                      (value) {
                                                                    context
                                                                        .read<
                                                                            TournamentCubit>()
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
                                          )
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
                                                    'Sanciones por tarjeta',
                                                    style: TextStyle(
                                                        fontSize: 14)),
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
                                                const Text('Tarjeta roja',
                                                    style: TextStyle(
                                                        fontSize: 13)),
                                                TextFormField(
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  decoration:
                                                      const InputDecoration(
                                                    labelStyle:
                                                        TextStyle(fontSize: 13),
                                                    labelText:
                                                        'Partidos por sanción',
                                                  ),
                                                  style:
                                                      TextStyle(fontSize: 13),
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
                                                  const Text('Tarjeta amarilla',
                                                      style: TextStyle(
                                                          fontSize: 14)),
                                                  TextFormField(
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration:
                                                        const InputDecoration(
                                                      labelStyle: TextStyle(
                                                          fontSize: 13),
                                                      labelText:
                                                          'Partidos por sanción',
                                                    ),
                                                    style:
                                                        TextStyle(fontSize: 13),
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
                                                const Text('Cambios ilimitados',
                                                    style: TextStyle(
                                                        fontSize: 13)),
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
                                                  const Text('Cambios',
                                                      style: TextStyle(
                                                          fontSize: 13)),
                                                  TextFormField(
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration:
                                                        const InputDecoration(
                                                      labelStyle: TextStyle(
                                                          fontSize: 13),
                                                      labelText: 'Total',
                                                    ),
                                                    style:
                                                        TextStyle(fontSize: 13),
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () async {
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
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 10.0, 16.0, 10.0),
                                  decoration: const BoxDecoration(
                                    color: Color(0xff740404),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  child: Text(
                                    'Eliminar',
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
                                onPressed: //state.formzStatus.isValidated
                                    //?
                                    () {
                                  context
                                      .read<TournamentCubit>()
                                      .updateTournament();
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 10.0, 16.0, 10.0),
                                  decoration: const BoxDecoration(
                                    color: Color(0xff045a74),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  child: Text(
                                    'Guardar cambios',
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

class _TournamentTypeSelection extends StatelessWidget {
  const _TournamentTypeSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTournament =
        context.select((TournamentCubit bloc) => bloc.state.tournamentSelected);
    final selectedValue = context.select((TournamentCubit bloc) =>
        bloc.state.lookUpValues.firstWhere((element) =>
            element.lookupValue.toString() ==
            selectedTournament.typeTournament));
    final status = context
        .select((TournamentMainCubit bloc) => bloc.validateTournamentType());
    return BlocBuilder<TournamentCubit, TournamentState>(
      buildWhen: (previous, current) =>
          previous.lookUpValues != current.lookUpValues,
      builder: (context, state) {
        return DropdownButtonFormField<LookUpValue>(
          // value: state.lookUpValues[state.lookUpValues.indexWhere((element) =>
          //     element.lookupValue.toString() ==
          //     state.tournamentSelected.typeTournament)],
          value: selectedValue,
          decoration: const InputDecoration(
            label: Text('Tipo de torneo', style: TextStyle(fontSize: 13)),
          ),
          //icon: const Icon(Icons.sports_soccer),
          isExpanded: true,
          hint: const Text('Selecciona un tipo de torneo',
              style: TextStyle(fontSize: 13)),
          style: const TextStyle(fontSize: 13),
          items: List.generate(
            state.lookUpValues.length,
            (index) {
              final content = state.lookUpValues[index].lookupName!;
              return DropdownMenuItem(
                value: state.lookUpValues[index],
                child: Text(
                  content.trim().isEmpty
                      ? 'Selecciona un tipo de torneo'
                      : content,
                  style: const TextStyle(fontSize: 13),
                ),
              );
            },
          ),
          onChanged: status
              ? null
              : (value) {
                  context
                      .read<TournamentCubit>()
                      .ontTournamentChange(tyTournamnet: value!);
                },
        );
      },
    );
  }
}

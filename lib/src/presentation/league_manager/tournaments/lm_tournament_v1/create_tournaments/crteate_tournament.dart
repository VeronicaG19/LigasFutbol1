import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../domain/lookupvalue/entity/lookupvalue.dart';
import '../../../../../service_locator/injection.dart';
import '../../../../app/app.dart';
import '../../../home/tournaments/cubit/tournament_lm_cubit.dart';
import '../../../home/widget/cubit/staticts_lm_cubit.dart';
import '../../lm_tournament_v2/main_page/cubit/tournament_main_cubit.dart';
import 'cubit/create_tournament_cubit.dart';
import 'widgets/header_step1.dart';
import 'widgets/header_step2.dart';
import 'widgets/header_step3.dart';

class CreateTournament extends StatefulWidget {
  CreateTournament({Key? key, required this.fromPage}) : super(key: key);

  //valida desde que pantalla se accedio para ejecutar el medoto
  int fromPage;

  @override
  State<CreateTournament> createState() => _CreateTournamentState();
}

class _CreateTournamentState extends State<CreateTournament> {
  @override
  Widget build(BuildContext context) {
    final leagueId =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocProvider(
      create: (context) => locator<CreateTournamentCubit>()
        ..getTypeTournaments(leagueId.leagueId),
      child: BlocConsumer<CreateTournamentCubit, CreateTournamentState>(
        listener: (context, state) {
          if (state.formzStatus == FormzStatus.submissionSuccess) {
            if (widget.fromPage == 2) {
              context
                  .read<TournamentMainCubit>()
                  .onLoadCategories(leagueId.leagueId);
            } else if (widget.fromPage == 1) {
              context
                  .read<TournamentLmCubit>()
                  .loadTournament(leagueId: leagueId.leagueId);
              context
                  .read<StatictsLmCubit>()
                  .loadStaticts(leagueId: leagueId.leagueId);
            }
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            HeaderStep1(),
                            SizedBox(height: 25),
                            _StatusTournaments(),
                            _PrivacityTournaments()
                          ],
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            const HeaderStep2(),
                            const SizedBox(height: 25),
                            Row(
                              children: const [
                                SizedBox(width: 15),
                                Expanded(child: _NameTournament()),
                                SizedBox(width: 15),
                                Expanded(child: _DateStartTournament()),
                                SizedBox(width: 15),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: const [
                                SizedBox(width: 15),
                                Expanded(child: _TypeTournament()),
                                SizedBox(width: 15),
                                Expanded(child: _TeamsPermit()),
                                SizedBox(width: 15),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: const [
                                SizedBox(width: 15),
                                Expanded(child: _TeamsPlayerPermit()),
                                SizedBox(width: 15),
                                Expanded(child: _TeamporalExp()),
                                SizedBox(width: 15),
                              ],
                            ),
                            const SizedBox(height: 15),
                            // _DaysCheckBox(),
                            const SizedBox(height: 15),
                            const Text(
                              "Seleccione las categorias para las que se crearan los torneos",
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            !state.flagCategorySelect
                                ? const Text(
                                    "Al menos una categoría debe ser seleccionada",
                                    style: TextStyle(color: Colors.red),
                                  )
                                : const SizedBox(height: 0),
                            const SizedBox(
                              height: 5,
                            ),
                            const _ListCategories()
                          ],
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              HeaderStep3(),
                              Row(
                                children: const [
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Expanded(child: _TypeFotbol()),
                                  SizedBox(
                                    width: 100,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text(
                                        "Partidos",
                                        style: TextStyle(
                                          fontFamily: 'SF Pro',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Divider(indent: 1),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(child: _TimesByMatch()),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                              child: _DurationTimesByMatch()),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: _BreaksByMatch(),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: _DurationBreaksByMatch(),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      _CardPenalties(),
                                      Visibility(
                                        visible: state.cardsflag,
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: _yellowCard(),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: _redCard(),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                      _ilimitsChanges(),
                                      Visibility(
                                        visible: state.createTournament
                                                .unlimitedChanges ==
                                            'N',
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: _changes(),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text(
                                        "Sistema de puntuación",
                                        style: TextStyle(
                                          fontFamily: 'SF Pro',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Divider(indent: 1),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: _pointsPerWin(),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: _pointsPerTie(),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      _shoutOutDefinitios(),
                                      Visibility(
                                        visible: state.shooutOutFlag,
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: _pointsPerWinShootOut(),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: _pointsPerLossShootOut(),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        )
                      ],
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
                                    Navigator.pop(context);
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
                                      'Salir',
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
                                child: state.formzStatus.isSubmissionInProgress
                                    ? Center(
                                        child: LoadingAnimationWidget
                                            .fourRotatingDots(
                                          color: const Color(0xff358aac),
                                          size: 50,
                                        ),
                                      )
                                    : TextButton(
                                        onPressed: //state.formzStatus.isValidated
                                            //?
                                            () async {
                                          await context
                                              .read<CreateTournamentCubit>()
                                              .createTournament(
                                                  leagueId: leagueId);
                                          if (state.tournamentName.valid ==
                                                  true &&
                                              state.inscriptionDate.valid ==
                                                  true &&
                                              state.maxTeams.valid == true &&
                                              state.maxPlayer.valid == true &&
                                              //state.temporaryReprimands.valid == true &&
                                              state.gamesTimes.valid == true &&
                                              state.durationByTime.valid ==
                                                  true &&
                                              state.breakNumbers.valid ==
                                                  true &&
                                              state.breakDuration.valid ==
                                                  true &&
                                              // state.yellowCardFine.valid == true &&
                                              // state.redCardFine.valid == true &&
                                              // state.gamesChanges.valid == true &&
                                              // state.pointPerLoss.valid == true &&
                                              state.pointPerTie.valid == true &&
                                              state.pointPerWin.valid == true &&
                                              // state.pointsPerLossShootOut.valid == true &&
                                              // state.pointsPerWinShootOut.valid == true
                                              state.flagCategorySelect) {}
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.fromLTRB(
                                              16.0, 10.0, 16.0, 10.0),
                                          decoration: BoxDecoration(
                                            color: (state.allFormIsValid &&
                                                    state.flagCategorySelect)
                                                ? const Color(0xff045a74)
                                                : Colors.grey,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15.0)),
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
              ],
            ),
          );
        }, //pamc
      ),
    );
  }
}

class _StatusTournaments extends StatelessWidget {
  const _StatusTournaments({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      builder: (context, state) {
        return SwitchListTile(
            activeThumbImage: const AssetImage('assets/images/unlocked.png'),
            inactiveThumbImage: const AssetImage('assets/images/padlock.png'),
            activeColor: Colors.green[300],
            title: state.createTournament.statusBegin == 'Y'
                ? const Text('Abierto',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ))
                : const Text('Cerrado',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    )),
            value: state.createTournament.statusBegin == 'Y' ? true : false,
            onChanged: (val) {
              context.read<CreateTournamentCubit>().onchangeBeginChange(val);
            });
      },
    );
  }
}

class _PrivacityTournaments extends StatelessWidget {
  const _PrivacityTournaments({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      builder: (context, state) {
        return SwitchListTile(
            activeThumbImage: const AssetImage('assets/images/unlocked.png'),
            inactiveThumbImage: const AssetImage('assets/images/padlock.png'),
            activeColor: Colors.green[300],
            title: state.createTournament.tournamentPrivacy == 'Y'
                ? const Text('Publico',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ))
                : const Text('Privado',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    )),
            value:
                state.createTournament.tournamentPrivacy == 'Y' ? true : false,
            onChanged: (val) {
              context
                  .read<CreateTournamentCubit>()
                  .onchangePrivacityChange(val);
            });
      },
    );
  }
}

class _NameTournament extends StatelessWidget {
  const _NameTournament({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.tournamentName != current.tournamentName,
      builder: (context, state) {
        return TextFormField(
          key: const Key('name_tournament'),
          maxLength: 30,
          onChanged: (value) => context
              .read<CreateTournamentCubit>()
              .onTournamentNameChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Nombre del torneo : ",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.tournamentName.invalid
                ? "Escriba el nombre del torneo"
                : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _DateStartTournament extends StatelessWidget {
  const _DateStartTournament({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.inscriptionDate != current.inscriptionDate,
      builder: (context, state) {
        print('state');
        print(state.inscriptionDate.value);
        return ElevatedButton.icon(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey),
          ),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(), //get today's date
              firstDate: DateTime
                  .now(), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(DateTime.now().year + 2),
            );
            final DateFormat formatter = DateFormat('yyyy-MM-dd');
            final String formatted =
                formatter.format(pickedDate ?? DateTime.now());
            print('select');
            print(pickedDate);
            context
                .read<CreateTournamentCubit>()
                .onInscriptionDateChange(formatted);
          },
          icon: const Icon(Icons.date_range, size: 18),
          label: Text(
            'Fecha de inicio ${DateFormat('yyyy-MM-dd').format(
              //state.inscriptionDate == const InscriptionDate.pure()
              state.inscriptionDate.value.isEmpty
                  ? DateTime.now()
                  : DateTime.parse(state.inscriptionDate.value),
            )}',
            style: TextStyle(fontSize: 12),
          ),
        );
      },
    );
  }
}

class _TypeTournament extends StatefulWidget {
  const _TypeTournament({Key? key}) : super(key: key);

  @override
  State<_TypeTournament> createState() => _TypeTournamentState();
}

class _TypeTournamentState extends State<_TypeTournament> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
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
                    'Tipo de torneo',
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
              context
                  .read<CreateTournamentCubit>()
                  .onTournamentTypeChange(value!);
            },
            value: state.typeTournament,
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

class _TeamsPermit extends StatelessWidget {
  const _TeamsPermit({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) => previous.maxTeams != current.maxTeams,
      builder: (context, state) {
        return TextFormField(
          key: const Key('max_teams_tournament'),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: "0",
          maxLength: 2,
          onChanged: (value) =>
              context.read<CreateTournamentCubit>().onMaxTeamsChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Equipos permitidos : ",
            labelStyle: const TextStyle(fontSize: 13),
            errorText: state.maxTeams.invalid
                ? "Escriba el numero maximo de equipo"
                : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _TeamsPlayerPermit extends StatelessWidget {
  const _TeamsPlayerPermit({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) => previous.maxPlayer != current.maxPlayer,
      builder: (context, state) {
        return TextFormField(
          key: const Key('teams_player_tournament'),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: "0",
          maxLength: 2,
          onChanged: (value) =>
              context.read<CreateTournamentCubit>().onMaxPlayerChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Jugadores por equipo : ",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.maxPlayer.invalid
                ? "Escriba el numero de jugadores por equipo"
                : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _TeamporalExp extends StatelessWidget {
  const _TeamporalExp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.createTournament.temporaryReprimands !=
          current.createTournament.temporaryReprimands,
      builder: (context, state) {
        return CheckboxListTile(
          key: const Key('temporal_exp_tournament'),
          title: const Text('Expulsiones temporales',
              style: TextStyle(fontSize: 13)),
          value: ((state.createTournament.temporaryReprimands ?? 'N') == 'Y')
              ? true
              : false,
          onChanged: (value) {
            context
                .read<CreateTournamentCubit>()
                .onTemporaryReprimandsChange(value!);
          }, //  <-- leading Checkbox
        );
      },
    );
  }
}

class _DaysCheckBox extends StatelessWidget {
  const _DaysCheckBox({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      enabled: true,
      title: Text('Dias de juego'),
      value: true,
      onChanged: (bool? value) {
        //context.read<TournamentCubit>().inchangeDays(value!,state.daysList[index]);
      }, //  <-- leading Checkbox
    );
  }
}

class _ListCategories extends StatelessWidget {
  const _ListCategories({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      builder: (context, state) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemCount: state.categorySelect.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              enabled: true,
              selected: state.categorySelect[index].isSelect!,
              title: Text(
                  state.categorySelect[index].category?.categoryName ?? '',
                  style: TextStyle(fontSize: 13)),
              value: state.categorySelect[index].isSelect!,
              onChanged: (bool? value) {
                context
                    .read<CreateTournamentCubit>()
                    .inCategoryChange(state.categorySelect[index], value!);
              }, //  <-- leading Checkbox
            );
          },
        );
      },
    );
  }
}

class _TypeFotbol extends StatefulWidget {
  const _TypeFotbol({Key? key}) : super(key: key);

  @override
  State<_TypeFotbol> createState() => _TypeFotbolState();
}

class _TypeFotbolState extends State<_TypeFotbol> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
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
                    'Tipo de juego',
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
            items: state.typeFotbolValues
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
              context.read<CreateTournamentCubit>().onFutbolTypeChange(value!);
              //context.read<CreateTournamentCubit>().getValuesFutbolType(state.typeFotbol.lookupName!);
            },
            value: state.typeFotbol,
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

class _TimesByMatch extends StatelessWidget {
  const _TimesByMatch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.gamesTimes != current.gamesTimes,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: "0",
          maxLength: 1,
          key: const Key('times_match'),
          onChanged: (value) =>
              context.read<CreateTournamentCubit>().onGamesTimesChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Tiempos del partido: ",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.gamesTimes.invalid
                ? "Escriba el numero de tiempos por partido"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _DurationTimesByMatch extends StatelessWidget {
  const _DurationTimesByMatch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.durationByTime != current.durationByTime,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: "0",
          maxLength: 2,
          key: const Key('duration_times_match'),
          onChanged: (value) => context
              .read<CreateTournamentCubit>()
              .onDurationTimesChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Duración del los tiempos del partido : ",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.durationByTime.invalid
                ? "Escriba la duración de cada tiempo"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _BreaksByMatch extends StatelessWidget {
  const _BreaksByMatch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.breakNumbers != current.breakNumbers,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: "0",
          maxLength: 1,
          key: const Key('breaks_match'),
          onChanged: (value) =>
              context.read<CreateTournamentCubit>().onBreakNumbersChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Descansos del partido : ",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.breakNumbers.invalid
                ? "Escriba los descansos que tendra cada tiempo"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _DurationBreaksByMatch extends StatelessWidget {
  const _DurationBreaksByMatch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.breakDuration != current.breakDuration,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: "0",
          maxLength: 3,
          key: const Key('duration_breaks_match'),
          onChanged: (value) => context
              .read<CreateTournamentCubit>()
              .onBreakDurationChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Duración de los descansos : ",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.breakDuration.invalid
                ? "Escriba la duracón de los descansos"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _CardPenalties extends StatelessWidget {
  const _CardPenalties({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) => previous.cardsflag != current.cardsflag,
      builder: (context, state) {
        return CheckboxListTile(
          key: const Key('card_penalties'),
          enabled: true,
          title: const Text('Sanciones por tarjetas',
              style: TextStyle(fontSize: 14)),
          value: state.cardsflag,
          onChanged: (bool? value) {
            context.read<CreateTournamentCubit>().oncardsFlagChange(value!);
          }, //  <-- leading Checkbox
        );
      },
    );
  }
}

class _yellowCard extends StatelessWidget {
  const _yellowCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.yellowCardFine != current.yellowCardFine,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: "3",
          maxLength: 3,
          onChanged: (value) => context
              .read<CreateTournamentCubit>()
              .onYellowCardFineChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          key: const Key('yellow_card_match'),
          decoration: InputDecoration(
            labelText: "Tarjetas amarillas : ",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.yellowCardFine.invalid
                ? "Escriba el valor de sanciones para tarjetas amarillas"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _redCard extends StatelessWidget {
  const _redCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.redCardFine != current.redCardFine,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: "1",
          maxLength: 3,
          key: const Key('red_card'),
          onChanged: (value) =>
              context.read<CreateTournamentCubit>().onRedCardFineChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Tarjetas rojas :",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.redCardFine.invalid
                ? "Escriba el valor de sanciones para tarjetas rojas"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _ilimitsChanges extends StatelessWidget {
  const _ilimitsChanges({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.createTournament.unlimitedChanges !=
          current.createTournament.unlimitedChanges,
      builder: (context, state) {
        return CheckboxListTile(
          key: const Key('change_ilimits'),
          enabled: true,
          title: Text('Cambios ilimitados', style: TextStyle(fontSize: 14)),
          value: ((state.createTournament.unlimitedChanges ?? 'N') == 'Y')
              ? true
              : false,
          onChanged: (value) {
            context
                .read<CreateTournamentCubit>()
                .onUnlimitedChangesChange(value!);
          },
        );
      },
    );
  }
}

class _changes extends StatelessWidget {
  const _changes({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.gamesChanges != current.gamesChanges,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: "6",
          maxLength: 2,
          key: const Key('changer_match'),
          onChanged: (value) =>
              context.read<CreateTournamentCubit>().onGamesChangesChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Cambios: ",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.gamesChanges.invalid
                ? "Escriba el numero de cambios permitidos por juego"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _shoutOutDefinitios extends StatelessWidget {
  const _shoutOutDefinitios({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.shooutOutFlag != current.shooutOutFlag,
      builder: (context, state) {
        return CheckboxListTile(
          key: const Key('shoutOut_Definitios'),
          enabled: true,
          title:
              Text('Desempate por shoot out: ', style: TextStyle(fontSize: 14)),
          value: state.shooutOutFlag,
          onChanged: (value) {
            context.read<CreateTournamentCubit>().onshooutOutFlagChange(value!);
          }, // <-- leading Checkbox
        );
      },
    );
  }
}

class _pointsPerWin extends StatelessWidget {
  const _pointsPerWin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.pointPerWin != current.pointPerWin,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: "0",
          maxLength: 1,
          key: const Key('points_perwin'),
          onChanged: (value) =>
              context.read<CreateTournamentCubit>().onPotinPerWinChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Puntos por partido ganado :",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.pointPerWin.invalid
                ? "Escriba los puntos que obtendra un equipo por victoria"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _pointsPerTie extends StatelessWidget {
  const _pointsPerTie({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.pointPerTie != current.pointPerTie,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: "0",
          maxLength: 1,
          key: const Key('points_pertie'),
          onChanged: (value) =>
              context.read<CreateTournamentCubit>().onPointPerTieChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Puntos por partido empatado :",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.pointPerTie.invalid
                ? "Escriba los puntos que obtendra un equipo por empate"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _pointsPerWinShootOut extends StatelessWidget {
  const _pointsPerWinShootOut({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.pointsPerWinShootOut != current.pointsPerWinShootOut,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: state.pointsPerWinShootOut.value,
          maxLength: 1,
          key: const Key('points_perwin_shoot_out'),
          onChanged: (value) => context
              .read<CreateTournamentCubit>()
              .onPointsPerWinShootOutChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Ganado en shoot out  :",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.pointsPerWinShootOut.invalid
                ? "Escriba los puntos que obtendra un equipo por victoria en shootOut"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _pointsPerLossShootOut extends StatelessWidget {
  const _pointsPerLossShootOut({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTournamentCubit, CreateTournamentState>(
      buildWhen: (previous, current) =>
          previous.pointsPerLossShootOut != current.pointsPerLossShootOut,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: state.pointsPerLossShootOut.value,
          maxLength: 1,
          key: const Key('points_perloss_shoot_out'),
          onChanged: (value) => context
              .read<CreateTournamentCubit>()
              .onPointsPerLossShootOutChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Perdido en shoot out  :",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.pointsPerLossShootOut.invalid
                ? "Escriba los puntos que obtendra un equipo por derrota en shootOut"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

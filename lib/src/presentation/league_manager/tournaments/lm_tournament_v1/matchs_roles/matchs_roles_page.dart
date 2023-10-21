import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../domain/field/entity/field.dart';
import '../../../../../domain/referee/entity/referee_by_league_dto.dart';
import '../../../../../domain/team_tournament/entity/team_tournament.dart';
import '../../../../../domain/tournament/entity/tournament.dart';
import '../../../../../service_locator/injection.dart';
import '../../../../app/app.dart';
import 'cubit/matchs_roles_cubit.dart';

class MatchsRolesPage extends StatelessWidget {
  final Tournament tournament;

  const MatchsRolesPage({super.key, required this.tournament});

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocProvider(
      create: (_) => locator<MatchsRolesCubit>()
        ..getTeamsTournaments(
            tournamentId: tournament.tournamentId!,
            leagueId: leagueManager.leagueId),
      child: BlocBuilder<MatchsRolesCubit, MatchsRolesState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            );
          } else {
            return Card(
              child: Column(
                children: [
                  Text(
                    'Crear roles para el torneo ${tournament.tournamentName}',
                    style: const TextStyle(fontSize: 35),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) =>
                        context.read<MatchsRolesCubit>().onChangeRound(value),
                    decoration: InputDecoration(
                      labelText: "Jornada ${state.nextRoundNumber.coundt1}",
                      labelStyle: TextStyle(fontSize: 13),
                    ),
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Stack(fit: StackFit.loose, children: [
                    Container(
                      padding: const EdgeInsets.only(right: 7, left: 7),
                      height: 35,
                      color: const Color(0xff358aac),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                "Local",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(
                                "Visitante",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(
                                "Fecha partido",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(
                                "Hora partido",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(
                                "Campo",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(
                                "Arbítro",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            )
                          ]),
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.listRoleToGenerate.length,
                        padding: EdgeInsets.only(top: 40, bottom: 65),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                              Container(
                                height: 70,
                                padding: EdgeInsets.only(right: 7, left: 7),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: DropdownButtonFormField<
                                            TeamTournament>(
                                          decoration: const InputDecoration(
                                            label: Text('Local'),
                                            border: OutlineInputBorder(),
                                          ),
                                          //icon: const Icon(Icons.sports_soccer),
                                          isExpanded: true,
                                          hint: const Text(
                                              'Selecciona un equipo'),
                                          items: List.generate(
                                            state.listOfTeams.length,
                                            (index) {
                                              final content = state
                                                  .listOfTeams[index]
                                                  .teamId
                                                  ?.teamName;
                                              return DropdownMenuItem(
                                                value: state.listOfTeams[index],
                                                child: Text(
                                                    content!.trim().isEmpty
                                                        ? 'Selecciona un equipo'
                                                        : content),
                                              );
                                            },
                                          ),
                                          onChanged: (value) {
                                            context
                                                .read<MatchsRolesCubit>()
                                                .onChangeTeamLocal(
                                                    index, value!);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: DropdownButtonFormField<
                                            TeamTournament>(
                                          decoration: const InputDecoration(
                                            label: Text('Visitante'),
                                            border: OutlineInputBorder(),
                                          ),
                                          //icon: const Icon(Icons.sports_soccer),
                                          isExpanded: true,
                                          hint: const Text(
                                              'Selecciona un equipo'),
                                          items: List.generate(
                                            state.listOfTeams.length,
                                            (index) {
                                              final content = state
                                                  .listOfTeams[index]
                                                  .teamId
                                                  ?.teamName;
                                              return DropdownMenuItem(
                                                value: state.listOfTeams[index],
                                                child: Text(
                                                    content!.trim().isEmpty
                                                        ? 'Selecciona un equipo'
                                                        : content),
                                              );
                                            },
                                          ),
                                          onChanged: (value) {
                                            context
                                                .read<MatchsRolesCubit>()
                                                .onChangeTeamVisit(
                                                    index, value!);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                          child: ElevatedButton.icon(
                                        onPressed: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime
                                                .now(), //get today's date
                                            firstDate: DateTime(DateTime.now()
                                                    .year -
                                                50), //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(
                                                DateTime.now().year + 2),
                                          );
                                          final DateFormat formatter =
                                              DateFormat('yyyy-MM-dd');
                                          final String formatted =
                                              formatter.format(
                                                  pickedDate ?? DateTime.now());
                                          context
                                              .read<MatchsRolesCubit>()
                                              .onChangeDate(index, pickedDate!);
                                        },
                                        icon: const Icon(Icons.date_range),
                                        label: Text(
                                          'Fecha ${DateFormat('yyyy-MM-dd').format(
                                            state.listRoleToGenerate[index]
                                                        .dateMatch ==
                                                    null
                                                ? DateTime.now()
                                                : state
                                                    .listRoleToGenerate[index]
                                                    .dateMatch!,
                                          )}',
                                        ),
                                      )
                                          /*TextFormField(
                                        initialValue: (state
                                                    .listRoleToGenerate[index]
                                                    .dateMatch !=
                                                null)
                                            ? DateFormat('yyyy-MM-dd').format(
                                                state.listRoleToGenerate[index]
                                                    .dateMatch!)
                                            : DateFormat('yyyy-MM-dd')
                                                .format(DateTime.now()),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Fecha',
                                        ),
                                        readOnly: true,
                                        onChanged: (value) {
                                          //context.read<ClasificationCubit>().onChangeDateMatch(value);
                                        },
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime
                                                .now(), //get today's date
                                            firstDate: DateTime(DateTime.now()
                                                    .year -
                                                50), //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(
                                                DateTime.now().year + 2),
                                          );
                                          context
                                              .read<MatchsRolesCubit>()
                                              .onChangeDate(index, pickedDate!);
                                        },
                                      ),*/
                                          ),
                                      Expanded(
                                          child: ElevatedButton.icon(
                                        onPressed: () async {
                                          TimeOfDay? pickedHour =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                          final DateFormat formatter =
                                              DateFormat('yyyy-MM-dd');
                                          DateTime dte = DateTime(
                                              state.listRoleToGenerate[index]
                                                  .dateMatch!.year,
                                              state.listRoleToGenerate[index]
                                                  .dateMatch!.month,
                                              state.listRoleToGenerate[index]
                                                  .dateMatch!.day,
                                              pickedHour!.hour,
                                              pickedHour.minute,
                                              00,
                                              00,
                                              00);
                                          context
                                              .read<MatchsRolesCubit>()
                                              .onChangeDate(index, dte);
                                        },
                                        icon: const Icon(Icons.date_range),
                                        label: Text(
                                          'Hora ${DateFormat('HH:mm:ss').format(
                                            state.listRoleToGenerate[index]
                                                        .dateMatch ==
                                                    null
                                                ? DateTime.now()
                                                : state
                                                    .listRoleToGenerate[index]
                                                    .dateMatch!,
                                          )}',
                                        ),
                                      )
                                          /* TextFormField(
                                        initialValue: (state
                                                    .listRoleToGenerate[index]
                                                    .dateMatch !=
                                                null)
                                            ? DateFormat('HH:mm:ss').format(
                                                state.listRoleToGenerate[index]
                                                    .dateMatch!)
                                            : DateFormat('HH:mm:ss').format(
                                                DateTime(TimeOfDay.now().hour,
                                                    TimeOfDay.now().minute)),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Hora',
                                        ),
                                        readOnly: true,
                                        onChanged: (value) {
                                          //context.read<ClasificationCubit>().onChangeField(value!.fieldId!);
                                        },
                                        onTap: () async {
                                          TimeOfDay? pickedHour =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                          DateTime dte = DateTime(
                                              state.listRoleToGenerate[index]
                                                  .dateMatch!.year,
                                              state.listRoleToGenerate[index]
                                                  .dateMatch!.month,
                                              state.listRoleToGenerate[index]
                                                  .dateMatch!.day,
                                              pickedHour!.hour,
                                              pickedHour.minute,
                                              00,
                                              00,
                                              00);
                                          //context.read<ClasificationCubit>().onChangeHourMatch(dte);
                                        },
                                      ),*/
                                          ),
                                      Expanded(
                                        child: DropdownButtonFormField<Field>(
                                          decoration: const InputDecoration(
                                            label: Text('Campo'),
                                            border: OutlineInputBorder(),
                                          ),
                                          //icon: const Icon(Icons.sports_soccer),
                                          isExpanded: true,
                                          hint:
                                              const Text('Selecciona un campo'),
                                          items: List.generate(
                                            state.fieldtList.length,
                                            (index) {
                                              final content = state
                                                  .fieldtList[index].fieldName!;
                                              return DropdownMenuItem(
                                                value: state.fieldtList[index],
                                                child: Text(
                                                    content.trim().isEmpty
                                                        ? 'Selecciona un campo'
                                                        : content),
                                              );
                                            },
                                          ),
                                          onChanged: (value) {
                                            context
                                                .read<MatchsRolesCubit>()
                                                .onChangeField(index, value!);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                          child: DropdownButtonFormField<
                                              RefereeByLeagueDTO>(
                                        decoration: const InputDecoration(
                                          label: Text('Arbítro'),
                                          border: OutlineInputBorder(),
                                        ),
                                        //icon: const Icon(Icons.sports_soccer),
                                        isExpanded: true,
                                        hint:
                                            const Text('Selecciona un arbítro'),
                                        items: List.generate(
                                          state.refereetList.length,
                                          (index) {
                                            final content = state
                                                .refereetList[index]
                                                .refereeName;
                                            return DropdownMenuItem(
                                              value: state.refereetList[index],
                                              child: Text(content.trim().isEmpty
                                                  ? 'Selecciona un arbítro'
                                                  : content),
                                            );
                                          },
                                        ),
                                        onChanged: (value) {
                                          context
                                              .read<MatchsRolesCubit>()
                                              .onChangeReferee(index, value!);
                                        },
                                      )),
                                    ]),
                              ),
                            ],
                          );
                          //     TablePage()
                        }),
                  ]),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.do_disturb_on_sharp,
                          color: Colors.red,
                        ),
                        tooltip: 'Decrease role',
                        onPressed: () {
                          context.read<MatchsRolesCubit>().removeRole();
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                        tooltip: 'Increase role',
                        onPressed: () {
                          context.read<MatchsRolesCubit>().addRole();
                        },
                      ),
                    ],
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          onPressed: () {
                            context.read<MatchsRolesCubit>().onSaveEditRoles();
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.save, // <-- Icon
                            size: 24.0,
                          ),
                          label: const Text('Guardar'), // <-- Text
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

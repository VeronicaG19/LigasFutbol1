import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/entity/league.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../app/app.dart';
import '../cubit/request_new_team_cubit.dart';
import 'dropdown_tournaments_page.dart';

class DropDownButtonLeaguesPage extends StatefulWidget {
  const DropDownButtonLeaguesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DropDownButtonLeaguesPageState();
}

class _DropDownButtonLeaguesPageState extends State<DropDownButtonLeaguesPage> {
  @override
  Widget build(BuildContext context) {
    final personId =
        context.read<AuthenticationBloc>().state.user.person.personId;
    return BlocConsumer<RequestNewTeamCubit, RequestNewTeamState>(
        listenWhen: (previous, current) =>
            previous.screenStatus != current.screenStatus,
        listener: (context, state) {
          if (state.formzStatus == FormzStatus.submissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content: Text('Solicitud enviada correctamente'),
                    duration: Duration(seconds: 5)),
              );
            Navigator.pop(context);
            context.read<AuthenticationBloc>().add(UpdateTeamList());
          }
          if (state.formzStatus == FormzStatus.submissionFailure) {
            final message = state.errorMessage ?? 'Error al enviar solicitud';
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    content: Text(message),
                    duration: const Duration(seconds: 5)),
              );
          }
        },
        builder: (context, state) {
          return ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 35,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButtonHideUnderline(
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
                              'Liga',
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
                      items: state.leagueList
                          .map((item) => DropdownMenuItem<League>(
                                value: item,
                                child: Text(
                                  item.leagueName,
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
                            .read<RequestNewTeamCubit>()
                            .onLeagueIdChange(value!);
                        // context
                        //     .read<RequestNewTeamCubit>()
                        //     .availableCategoriesByLeagueId(value.leagueId);
                      },
                      value: state.leagueSelect,
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
                          color: const Color(0xff4ab9e8),
                        ),
                        color: const Color(0xff358aac),
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
                  )),
              const SizedBox(
                height: 15,
              ),
              const DropDownTournamentsPage(),
              //const SizedBox(height: 15,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: _NameTeam(),
              ),
              state.formzStatus.isSubmissionInProgress
                  ? Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: const Color(0xff358aac),
                        size: 50,
                      ),
                    )
                  : GestureDetector(
                      onTap: state.formzStatus.isValidated
                          ? () async {
                              ((state.categorySelect.categoryId ?? 0) > 0)
                                  ? context
                                      .read<RequestNewTeamCubit>()
                                      .sendRequestNewTeam(partyId: personId)
                                  : null;
                            }
                          : null,
                      child: Container(
                        margin: const EdgeInsets.all(30.0),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          gradient: (state.categorySelect.categoryId ?? 0) > 0
                              ? const LinearGradient(
                                  colors: [
                                      Color(0xFF03A0FE),
                                      Color(0xFF03A0FE),
                                    ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight)
                              : const LinearGradient(
                                  colors: [
                                      Colors.grey,
                                      Colors.grey,
                                    ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                        ),
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: const Text(
                          "Enviar solicitud",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
            ],
          );
        });
  }
}

class _NameTeam extends StatelessWidget {
  const _NameTeam({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestNewTeamCubit, RequestNewTeamState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      buildWhen: (previous, current) => previous.teamName != current.teamName,
      builder: (context, state) {
        return TextFormField(
          key: const Key('name_team'),
          onChanged: (value) =>
              context.read<RequestNewTeamCubit>().onTeamNameChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Nombre del equipo",
            labelStyle: const TextStyle(fontSize: 13),
            border: const OutlineInputBorder(),
            errorText:
                state.teamName.invalid ? "Escriba el nombre del equipo" : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}

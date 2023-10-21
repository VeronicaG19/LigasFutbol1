import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/uniform/dto/uniform_dto.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/manage_team/cubit/manage_team_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/manage_team/view/team_uniform_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../service_locator/injection.dart';
import 'team_player_list.dart';

class ManageTeamPage extends StatelessWidget {
  const ManageTeamPage({Key? key, this.teamId}) : super(key: key);

  final int? teamId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            child: _UniformsTeam(
              teamId: teamId,
            ),
          ),
          TeamPlayerList(teamId: teamId),
        ],
      ),
    );
  }
}

class _UniformsTeam extends StatelessWidget {
  const _UniformsTeam({
    Key? key,
    this.teamId,
  }) : super(key: key);

  final int? teamId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ManageTeamCubit>()
        ..getUniformsOfTeamById(teamId: teamId ?? 0),
      child: BlocBuilder<ManageTeamCubit, ManageTeamState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loadingUniforms) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            String? unifType;
            List<String> listTeamType = ['LOCAL', 'VISIT'];
            if (state.uniformsList.isNotEmpty) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(2, (index) {
                  if (index < state.uniformsList.length) {
                    unifType = state.uniformsList[index].uniformType!;
                    return TeamUniformButton(
                      uniformDto: state.uniformsList[index],
                      rutaImage: 'assets/images/playera2.png',
                    );
                  } else {
                    return TeamUniformButton(
                      uniformDto: UniformDto(
                        teamId: teamId,
                        teamName: state.teamInfo.teamName,
                        uniformType: (unifType == "LOCAL") ? "VISIT" : "LOCAL",
                      ),
                      rutaImage: 'assets/images/playera2.png',
                    );
                  }
                }),
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(2, (index) {
                  return TeamUniformButton(
                    rutaImage: 'assets/images/playera2.png',
                    uniformDto: UniformDto(
                      teamId: teamId,
                      teamName: state.teamInfo.teamName,
                      uniformType: listTeamType[index],
                    ),
                  );
                }),
              );
            }
          }
        },
      ),
    );
  }
}

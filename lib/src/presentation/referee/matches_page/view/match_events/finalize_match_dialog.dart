import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_detail/match_detail_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/referee_match.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/cubit/events/events_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/widgets/button_custom.dart';

enum ScreenType { scoreShoutOut, scoreMatch }

class FinalizeMatchDialog extends StatelessWidget {
  const FinalizeMatchDialog({
    super.key,
    required this.match,
    required this.matchDetail,
    required this.type,
  });

  final RefereeMatchDTO match;
  final MatchDetailDTO matchDetail;
  final ScreenType type;

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    const double dFontSize = 22.0;

    return BlocBuilder<EventsCubit, EventsState>(
      builder: (ctxt, state) {
        return AlertDialog(
          content: Container(
            height: (heightScreen / 100 * 15),
            child: Column(
              children: [
                const Center(
                    child: Text(
                  'Resultado del partido',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: dFontSize),
                )),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: const Text(
                        'Local: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: dFontSize),
                      ),
                    ),
                    if (type == ScreenType.scoreShoutOut)
                      Expanded(
                        child: Text(
                          '${matchDetail.scoreLocal}(${state.scoreShoutOutLocal})',
                          style: const TextStyle(fontSize: dFontSize),
                        ),
                      ),
                    if (type == ScreenType.scoreMatch)
                      Expanded(
                        child: Text(
                          '${matchDetail.scoreLocal}',
                          style: const TextStyle(fontSize: dFontSize),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: const Text(
                        'Visitante: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: dFontSize),
                      ),
                    ),
                    if (type == ScreenType.scoreShoutOut)
                      Expanded(
                        child: Text(
                          '${matchDetail.scoreVisit}(${state.scoreShoutOutVisit})',
                          style: const TextStyle(fontSize: dFontSize),
                        ),
                      ),
                    if (type == ScreenType.scoreMatch)
                      Expanded(
                        child: Text(
                          '${matchDetail.scoreVisit}',
                          style: const TextStyle(fontSize: dFontSize),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ButtonCustom(
                      textBtn: ' Volver',
                      iconBtn: Icons.arrow_back,
                      fontColor: Colors.white,
                      backgroundColor: Colors.cyan.shade700,
                      isOutline: true,
                    )),
                const SizedBox(height: 10),
                InkWell(
                    onTap: () {
                      ctxt.read<EventsCubit>().onPressGameOver(
                            match: match,
                            matchDetail: matchDetail,
                          );
                      Navigator.pop(context);
                      //Navigator.popUntil(ctxt,(route) => route.settings.name == '/');
                    },
                    child: ButtonCustom(
                      textBtn: ' Confirmar',
                      iconBtn: Icons.check,
                      fontColor: Colors.white,
                      backgroundColor: Colors.cyan.shade700,
                      isOutline: false,
                    )),
                const SizedBox(height: 10),
              ],
            )
          ],
        );
      },
    );
  }
}

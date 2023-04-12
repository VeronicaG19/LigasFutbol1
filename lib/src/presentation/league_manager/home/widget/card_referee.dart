import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums.dart';
import '../../../../service_locator/injection.dart';
import '../../tournaments/lm_tournament_v1/clasification/field_schedule/cubit/lm_field_schedule_cubit.dart';
import '../../tournaments/lm_tournament_v1/clasification/widgets/d_field_prices.dart';
import '../referee/availability_referee/view/availibility_referee_page.dart';
import '../referee/detail_referee_league_manager.dart';

class CardReferee extends StatelessWidget {
  const CardReferee(
      {Key? key,
      required this.name,
      required this.photo,
      required this.refereeId, required this.activeId})
      : super(key: key);

  final String name;
  final String photo;
  final int refereeId;
  final int activeId;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              backgroundColor: Colors.grey[200],
              title: const Text('Información del arbitro'),
              content: DetailRefereeLeagueManager(refereeId: refereeId),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                    decoration: const BoxDecoration(
                      color: Color(0xff740426),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Text(
                      'Cerrar',
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
                IconButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AvailabilityRefereePage(refereeId: refereeId),
                      ),
                    );
                  },
                  icon: const Icon(Icons.calendar_month, size: 25),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return  BlocProvider(
                          create: (_) => locator<LmFieldScheduleCubit>()
                            ..onLoadPrices(activeId ?? 0),
                          child: DialogPricesActive(),
                        );
                      },
                    );
                  },
                  tooltip: 'Ver tarifas',
                  icon: const Icon(
                    Icons.monetization_on,
                    size: 32,
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Card(
          color: Colors.grey[100],
          elevation: 3.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 8,
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[100],
                    child: Image.asset(
                      'assets/images/referee.png',
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 8),
                  child: Text(
                    name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 12,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

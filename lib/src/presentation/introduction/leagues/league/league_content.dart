import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/league/cubit/league_cubit.dart';

class LeagueContent extends StatefulWidget {
  const LeagueContent({Key? key}) : super(key: key);

  @override
  State<LeagueContent> createState() => _LeagueContentState();
}

class _LeagueContentState extends State<LeagueContent> {
  String? selectedValue1;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeagueCubit, LeagueState>(
      listener: (context, state) {
        if (state.screenStatus == ScreenStatus.error) {
          AnimatedSnackBar.rectangle(
            'Sin datos',
            'No hay datos registrados para mostrar',
            type: AnimatedSnackBarType.info,
            brightness: Brightness.light,
          ).show(
            context,
          );
        }
      },
      builder: (context, state) {
        return Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
              child: Container(
                width: 10.0,
                height: 50.0,
                color: Color(0xff358aac),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Padding(
                  padding: EdgeInsets.only(right: 15),
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
                          .map((item) => DropdownMenuItem<String>(
                                value: item.leagueId.toString(),
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
                        print("Valor--->$value");
                        setState(() {
                          selectedValue1 = value as String;
                        });
                        context.read<LeagueCubit>().getTournamentByLeagueId(
                            int.parse(value.toString()));
                      },
                      value: selectedValue1,
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
            )
          ],
        );
      },
    );
  }
}

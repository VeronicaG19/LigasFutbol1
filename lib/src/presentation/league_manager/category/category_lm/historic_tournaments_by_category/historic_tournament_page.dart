import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/detail/cubit/category_lm_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HistoricTournamentPage extends StatefulWidget {
  const HistoricTournamentPage({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoricTournamentPage> createState() => _HistoricTournamentPageState();
}

class _HistoricTournamentPageState extends State<HistoricTournamentPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CategoryLmCubit>().getHistoricTournamentByCategoryId();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryLmCubit, CategoryLmState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.tournamentloaded) {
          return state.tournamentList.length <= 0
              ? Center(
                  child: const Text("No hay datos",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                  itemCount: state.tournamentList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 1,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0),
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              radius: 25,
                              backgroundColor: const Color(0xff0791a3),
                              child: Image.asset(
                                'assets/images/trophy.png',
                                fit: BoxFit.cover,
                                height: 28,
                                width: 28,
                                color: Colors.grey[300],
                              )),
                          Text(
                            "${state.tournamentList[index].tournamentName}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w900),
                          ),
                          Divider(),
                          Text(
                            "${state.tournamentList[index].inscriptionDate?.day ?? 0} / "
                            "${state.tournamentList[index].inscriptionDate?.month ?? 0} / "
                            "${state.tournamentList[index].inscriptionDate?.year ?? 0}",
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
        } else if (state.screenStatus == ScreenStatus.tournamentloading ||
            state.screenStatus == ScreenStatus.infoLoading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        } else if (state.screenStatus == ScreenStatus.inSelectCategory) {
          return Center(
            child: const Text("Seleccione una categoria",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

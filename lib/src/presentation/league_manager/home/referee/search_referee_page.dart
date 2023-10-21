import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/referee/search_referee/cubit/referee_search_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../service_locator/injection.dart';
import '../../../app/bloc/authentication_bloc.dart';
import '../../../widgets/app_bar_page.dart';
import '../widget/card_referee_send.dart';

class SearchRefereePage extends StatelessWidget {
  const SearchRefereePage({Key? key}) : super(key: key);
  static Route route() =>
      MaterialPageRoute(builder: (_) => SearchRefereePage());
  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBarPage(
            title: "Buscar Árbitro",
            size: 100,
          ),
        ),
        body: BlocProvider(
            create: (_) => locator<RefereeSearchCubit>()
              ..loadRefereeSearch(leagueId: leagueManager.leagueId),
            child: BlocConsumer<RefereeSearchCubit, RefereeSearchState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.screenStatus == ScreenStatus.loading) {
                    return Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: const Color(0xff358aac),
                        size: 50,
                      ),
                    );
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        GridView.builder(
                          padding: const EdgeInsets.only(
                              top: 15, left: 15, right: 15),
                          itemCount: state.refereetList.length,
                          itemBuilder: (context, index) {
                            print(state.refereetList[index].refereePhoto);
                            return CardRefereeSend(
                                name: state.refereetList[index].refereeName,
                                photo: state.refereetList[index].refereePhoto ??
                                    '',
                                refereeId: state.refereetList[index].refereeId);
                          },
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 12.0,
                                  mainAxisSpacing: 12.0),
                        ),
                      ],
                    );
                  }
                })));
  }
}

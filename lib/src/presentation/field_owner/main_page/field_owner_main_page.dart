import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/create_field/create_field.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/cubit/field_owner_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/field_availability_list_page.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../player/user_menu/user_menu.dart';
import '../../widgets/button_share/button_share_widget.dart';
import '../../widgets/notification_icon/cubit/notification_count_cubit.dart';
import '../../widgets/notification_icon/view/notification_icon.dart';

class FieldOwnerMainPage extends StatelessWidget {
  const FieldOwnerMainPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: FieldOwnerMainPage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.leagueManager);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'Ligas Fútbol',
          style: TextStyle(
              color: Colors.grey[200],
              fontSize: 23,
              fontWeight: FontWeight.w900),
        ),
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.cover,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 5.0),
            child: BlocProvider(
              create: (contextC) => locator<NotificationCountCubit>()
                ..onLoadNotificationCount(
                    leagueManager.leagueId, user.applicationRol),
              child: NotificationIcon(
                applicationRol: user.applicationRol,
              ),
            ),
          ),
          const ButtonShareWidget(),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[200],
        child: const UserMenu(),
      ),
      body: BlocProvider(
        create: (_) => locator<FieldOwnerCubit>()
          ..loadfields(leagueId: leagueManager.leagueId),
        child: const FieldOwnerMainContent(),
      ),
    );
  }
}

class FieldOwnerMainContent extends StatefulWidget {
  const FieldOwnerMainContent({Key? key}) : super(key: key);

  @override
  _FieldOwnerMainContentState createState() => _FieldOwnerMainContentState();
}

class _FieldOwnerMainContentState extends State<FieldOwnerMainContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldOwnerCubit, FieldOwnerState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        }
        return ListView(
          padding:
              const EdgeInsets.only(top: 15, right: 8, left: 8, bottom: 35),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  //onPressed: () => Navigator.pop(dialogContext),
                  onPressed: () async {
                    /*Navigator.push(
                            context,
                            EditPlayerProfilePage.route(BlocProvider.of<PlayerProfileCubit>(context))
                        );*/
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<FieldOwnerCubit>(context)
                              ..getTypeFields(),
                            child: const CreateFieldOwnerPage()),
                      ),
                    ).then((value) =>
                        context.read<FieldOwnerCubit>().onCleanFields());
                    /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CraeteFieldLeagueManagerPage(),
                            ),
                          ).whenComplete(() => context
                                .read<FieldLmCubit>()
                                .loadfields(leagueId: leagueManager.leagueId));*/
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    decoration: const BoxDecoration(
                      color: Color(0xff0791a3),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    height: 35,
                    width: 150,
                    child: Text(
                      'Crear campo',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        color: Colors.grey[200],
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            if (state.fieldtList.isNotEmpty)
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  itemCount: state.fieldtList.length,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0),
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      child: Card(
                        color: Colors.grey[100],
                        elevation: 3.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  bottom: 8,
                                ),
                                child: Image.asset(
                                  'assets/images/footballfield.png',
                                  fit: BoxFit.cover,
                                  height: 35,
                                  width: 35,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Text(
                                '${state.fieldtList[index].fieldName}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            /* Padding(
                                padding: EdgeInsets.only(bottom: 8, top: 8),
                                child: Text(
                                  state.teamPageable.content[index].categoryId!
                                          .categoryName ??
                                      '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                              )*/
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            FieldAvailabilityListPage.route(
                                state.fieldtList[index]));

                        /*   showModalBottomSheet<void>(
                              context: context,
                              builder: (_) {
                                return BlocProvider(
                                  create: (_) => locator<FoFieldDetailCubit>()
                                    ..onLoadFieldData(state.fieldtList[index]),
                                  child: FieldDetail(
                                    field: state.fieldtList[index],
                                  ),
                                );
                              },
                            );*/
                      },
                    );
                  },
                ),
              ),
            if (state.fieldtList.isEmpty)
              const Center(
                child: Text("No hay campos registrados",
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
              ),
          ],
        );
      },
    );
  }
}

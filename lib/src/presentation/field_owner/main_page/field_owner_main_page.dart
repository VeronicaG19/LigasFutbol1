import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/create_field/create_field.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/cubit/field_owner_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/field_availability_list_page.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_version_plus/new_version_plus.dart';

import '../../../core/constans.dart';
import '../../player/user_menu/user_menu.dart';
import '../../widgets/button_share/button_share_widget.dart';
import '../../widgets/notification_icon/view/notification_icon.dart';

class FieldOwnerMainPage extends StatelessWidget {
  const FieldOwnerMainPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: FieldOwnerMainPage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
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
            child: NotificationIcon(applicationRol: user.applicationRol),
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
  State<FieldOwnerMainContent> createState() => _FieldOwnerMainContentState();
}

class _FieldOwnerMainContentState extends State<FieldOwnerMainContent> {
   @override
  void initState(){

    final newvVersion = NewVersionPlus(
      iOSId: 'dev.ias.swat.ccs.com.Wiplif',
      androidId: 'com.ccs.swat.iaas.spr.ligas_futbol.ligas_futbol_flutter'
    );

    Timer(const Duration(milliseconds: 800),(){
      checkNewVersion(newvVersion);

    });

    super.initState();
  }

  void checkNewVersion(NewVersionPlus newVersion ) async{
    final status = await newVersion.getVersionStatus();
      if(status != null) {
        if (status.canUpdate) {
          newVersion.showUpdateDialog(
            context: context, 
            versionStatus: status,
            dialogText: 'Nueva version disponible en la tienda (${status.storeVersion}), Actualiza ahora',
            dialogTitle: 'Actualización disponible',

            );
        }
      }
  }
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
          padding: const EdgeInsets.only(top: 0, right: 8, left: 8, bottom: 35),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: TextButton(
                    onPressed: () async {
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
                    },
                    child: Container(
                      key: CoachKey.addField,
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'Crear campo',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Icon(
                              Icons.add_location_alt_outlined,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            (state.fieldtList.isNotEmpty)
                ? SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: ListView.builder(
                      key: CoachKey.listFields,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      itemCount: state.fieldtList.length,
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          child: _FieldCard(
                            fieldName: '${state.fieldtList[index].fieldName}',
                            sportType: '${state.fieldtList[index].sportType}',
                            fieldAddress:
                                '${state.fieldtList[index].fieldsAddress}',
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                FieldAvailabilityListPage.route(
                                    state.fieldtList[index]));
                          },
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Text(
                      "No hay campos registrados",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                    ),
                  ),
          ],
        );
      },
    );
  }
}

class _FieldCard extends StatelessWidget {
  final String fieldName;
  final String sportType;
  final String fieldAddress;
  const _FieldCard({
    Key? key,
    required this.fieldName,
    required this.sportType,
    required this.fieldAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: Colors.cyan.shade600,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                'assets/images/footballfield.png',
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fieldName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    fieldAddress,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 11,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Colors.cyan.shade800,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      sportType,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

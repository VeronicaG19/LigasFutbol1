import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/only_mobile_app/button_alert_only_web.dart';

import '../../../../service_locator/injection.dart';
import '../../../league_manager/home/request/request_leage_admin_league_manager.dart';
import '../../../league_manager/home/request/sed_request_team_manager.dart';
import '../../../league_manager/home/request/send_request_referee.dart';
import 'cubit/role_cubit.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  static Route route() => MaterialPageRoute(builder: (_) => const RolePage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocProvider(
      create: (_) => locator<RoleCubit>()..loadInitialData(user.id!),
      child: _RolPageContent(userid: user.id!),
    );
  }
}

class _RolPageContent extends StatelessWidget {
  const _RolPageContent({Key? key, required this.userid}) : super(key: key);
  final int userid;
  //int selectedRol = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            'Cambiar rol',
            style:
                TextStyle(color: Colors.grey[200], fontWeight: FontWeight.w900),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          elevation: 0.0,
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: BlocConsumer<RoleCubit, RoleState>(
        listenWhen: (previous, current) =>
            previous.rolChanged != current.rolChanged ||
            current.screenState == BasicCubitScreenState.error,
        listener: (context, state) {
          if (state.screenState == BasicCubitScreenState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text(state.errorMessage ?? 'Ah ocurrido un inconveniente'),
              ),
            );
          } else {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationRolChanged(state.rolChanged));
          }
        },
        builder: (context, state) {
          final cubit = context.read<RoleCubit>();
          return state.screenState == BasicCubitScreenState.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ResponsiveWidget.isSmallScreen(context)
                  ? ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text('Rol Actual'),
                          subtitle:
                              Text(state.currentRol.rol.roleDescription ?? ''),
                          onTap: () {},
                        ),
                        const _RolSectionMenu(),
                        // ListTile(
                        //   leading: const Icon(Icons.change_circle),
                        //   title: const Text('Roles disponibles'),
                        //   subtitle: Text(
                        //     state.availableRoles
                        //         .map((e) => e.roleDescription!)
                        //         .toList()
                        //         .join(', '),
                        //   ),
                        //   onTap: () {},
                        // ),
                        /*Visibility(
                            visible: state.associatedRoles
                                .where((element) => element.rol.roleName == 'REFEREE')
                                .isEmpty,
                            child: ListTile(
                              leading: const Icon(Icons.change_circle),
                              title: const Text('Solicitar rol de árbitro'),
                              onTap: () {},
                            ),
                          ),*/
                        Visibility(
                          visible: !cubit
                                  .getIsRolAssociated(Rolesnm.LEAGUE_MANAGER) &&
                              cubit.validateFieldOwnerVisibility(),
                          child: ListTile(
                            leading: const Icon(Icons.change_circle),
                            title:
                                const Text('Convertirse en presidente de liga'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RequestLeagueToAdmin()),
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: !context
                              .read<RoleCubit>()
                              .getIsRolAssociated(Rolesnm.REFEREE),
                          child: ListTile(
                            leading: const Icon(Icons.change_circle),
                            title: const Text('Convertirse en árbitro'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SendRequestReferee()),
                              ).whenComplete(() => context
                                  .read<RoleCubit>()
                                  .loadInitialData(userid));
                            },
                          ),
                        ),
                        Visibility(
                          visible: !context
                              .read<RoleCubit>()
                              .getIsRolAssociated(Rolesnm.TEAM_MANAGER),
                          child: ListTile(
                            leading: const Icon(Icons.change_circle),
                            title: const Text(
                                'Convertirse en representante de equipo'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SendRequestTeamManager()),
                              ).whenComplete(() => context
                                  .read<RoleCubit>()
                                  .loadInitialData(userid));
                            },
                          ),
                        ),
                        const _FieldOwnerRolSection(),
                      ],
                    )
                  : Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: ListView(
                          children: [
                            _SingleSection(
                              title: "Roles",
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.settings),
                                  title: const Text('Rol Actual'),
                                  subtitle: Text(
                                      state.currentRol.rol.roleDescription ??
                                          ''),
                                  onTap: () {},
                                ),
                                const _RolSectionMenu(),
                                // ListTile(
                                //   leading: const Icon(Icons.change_circle),
                                //   title: const Text(
                                //       'Roles disponibles para solicitar'),
                                //   subtitle: Text(
                                //     state.availableRoles
                                //         .map((e) => e.roleDescription!)
                                //         .toList()
                                //         .join(', '),
                                //   ),
                                //   onTap: () {},
                                // ),
                                Visibility(
                                  visible: !cubit.getIsRolAssociated(
                                          Rolesnm.LEAGUE_MANAGER) &&
                                      cubit.validateFieldOwnerVisibility(),
                                  child: ListTile(
                                    leading: const Icon(Icons.change_circle),
                                    title: const Text(
                                        'Convertirse en presidente de liga'),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RequestLeagueToAdmin()),
                                      );
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: !context
                                      .read<RoleCubit>()
                                      .getIsRolAssociated(Rolesnm.REFEREE),
                                  child: ListTile(
                                    leading: const Icon(Icons.change_circle),
                                    title: const Text('Convertirse en árbitro'),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SendRequestReferee()),
                                      ).whenComplete(() => context
                                          .read<RoleCubit>()
                                          .loadInitialData(userid));
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: !context
                                      .read<RoleCubit>()
                                      .getIsRolAssociated(Rolesnm.TEAM_MANAGER),
                                  child: ListTile(
                                    leading: const Icon(Icons.change_circle),
                                    title: const Text(
                                        'Convertirse en representante de equipo'),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SendRequestTeamManager()),
                                      ).whenComplete(() => context
                                          .read<RoleCubit>()
                                          .loadInitialData(userid));
                                    },
                                  ),
                                ),
                                const _FieldOwnerRolSection(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
        },
      ),
    );
  }
}

class _FieldOwnerRolSection extends StatelessWidget {
  const _FieldOwnerRolSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Visibility(
      visible: context.read<RoleCubit>().validateFieldOwnerVisibility(),
      child: ListTile(
        leading: const Icon(Icons.change_circle),
        title: const Text('Convertirse en dueño de campo'),
        onTap: () {
          showDialog(
            context: context,
            builder: (contextD) => BlocProvider.value(
              value: BlocProvider.of<RoleCubit>(context)
                ..getFieldOwnerRequestStatus(user.person.personId),
              child: BlocConsumer<RoleCubit, RoleState>(
                listener: (contextL, state) {
                  if (state.screenState == BasicCubitScreenState.error) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('No se ha podido enviar la solicitud'),
                        ),
                      );
                  } else if (state.screenState ==
                      BasicCubitScreenState.success) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Se ha enviado la solicitud para dueño de campo correctamente'),
                        ),
                      );
                    contextL.read<RoleCubit>().loadInitialData(user.id ?? 0);
                    Navigator.pop(contextD);
                  }
                },
                builder: (contextB, state) {
                  Widget buildContent() {
                    if (state.screenState ==
                        BasicCubitScreenState.invalidData) {
                      return const Text('Ya has enviado una solicitud antes');
                    }
                    return state.screenState == BasicCubitScreenState.validating
                        ? const SizedBox()
                        : const Text(
                            'Se enviará una solicitud para obtener el rol de dueño de campo.');
                  }

                  return AlertDialog(
                    title: const Text('Solicitud para dueño de campo'),
                    content: buildContent(),
                    actions: [
                      if (state.screenState == BasicCubitScreenState.validating)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      if (state.screenState != BasicCubitScreenState.validating)
                        TextButton(
                            onPressed: () => Navigator.pop(contextD),
                            child: const Text('CANCELAR')),
                      if (state.screenState !=
                              BasicCubitScreenState.validating &&
                          state.screenState !=
                              BasicCubitScreenState.invalidData)
                        TextButton(
                            onPressed: () => contextB
                                .read<RoleCubit>()
                                .sendRequestForFieldOwner(user),
                            child: const Text('ENVIAR')),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RolSectionMenu extends StatelessWidget {
  const _RolSectionMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final associatedRoles =
        context.select((RoleCubit cubit) => cubit.state.associatedRoles);
    final currentRol =
        context.select((RoleCubit cubit) => cubit.state.currentRol);
    final radios = List.generate(associatedRoles.length + 1, (index) {
      if (index == 0) {
        return const ListTile(
          leading: Icon(Icons.edit),
          title: Text('Cambiar Rol'),
          subtitle: Align(
            alignment: Alignment.centerLeft,
            child: ButtonAlertOnlyWeb(),
          ),
        );
      } else {
        int cDevice = context.read<RoleCubit>().allowedDevice(index - 1);

        return ListTile(
          title: Row(
            children: [
              Text(associatedRoles[index - 1].rol.roleDescription ?? ''),
              Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: (kIsWeb)
                      ? (cDevice == 1)
                          ? Colors.red
                          : Colors.cyan.shade700
                      : (cDevice == 0)
                          ? Colors.red
                          : Colors.cyan.shade700,
                ),
                child: Text(
                  style: const TextStyle(color: Colors.white),
                  context.read<RoleCubit>().allowedDeviceLabel(cDevice),
                ),
              ),
            ],
          ),
          leading: Radio<int>(
            value: index - 1,
            groupValue: associatedRoles[index - 1].rol == currentRol.rol
                ? index - 1
                : -1,
            onChanged: (value) {
              Navigator.pop(context);
              context.read<RoleCubit>().onChangeRol(index - 1);
            },
            activeColor: Colors.green,
          ),
        );
      }
    });
    return ListTile(
      leading: const Icon(Icons.edit),
      title: const Text('Cambiar Rol'),
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (_) {
            return BlocProvider.value(
              value: BlocProvider.of<RoleCubit>(context),
              child: Container(
                height: 400,
                color: const Color.fromARGB(255, 236, 236, 236),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: radios,

                    /*children: <Widget>[
                      const Text('Cambiar rol'),
                      if (associatedRoles.isNotEmpty)
                        ToggleSwitch(
                          initialLabelIndex: associatedRoles.indexOf(
                              associatedRoles.firstWhere(
                                  (element) => element.primaryFlag == 'Y')),
                          totalSwitches: associatedRoles.length,
                          labels: associatedRoles
                              .map((e) => e.rol.roleDescription!)
                              .toList(),
                          onToggle: (index) {
                            Navigator.pop(context);
                            context.read<RoleCubit>().changeRol(index!);
                          },
                        ),
                    ],*/
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
                Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

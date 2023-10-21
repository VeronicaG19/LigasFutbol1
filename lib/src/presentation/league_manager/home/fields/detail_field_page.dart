import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/availability_field/availability_field_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/app_bar_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../service_locator/injection.dart';
import '../availability_field/cubit/availability_field_cubit.dart';

class DetailFieldPage extends StatelessWidget {
  const DetailFieldPage(
      {Key? key, required this.fieldId, required this.activeId})
      : super(key: key);
  final int fieldId;
  final int activeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBarPage(
          title: "Detalle de campo",
          size: 100,
        ),
      ),
      body: DetailFieldContent(fieldId: fieldId, activeId: activeId),
    );
  }
}

class DetailFieldContent extends StatelessWidget {
  const DetailFieldContent(
      {Key? key, required this.fieldId, required this.activeId})
      : super(key: key);
  final int fieldId;
  final int activeId;
  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocProvider(
      create: (_) =>
          locator<AvailabilityFieldCubit>()..detailField(fieldId: fieldId),
      child: BlocBuilder<AvailabilityFieldCubit, AvailabilityFieldState>(
          builder: (context, state) {
        if (state.screenState == BasicCubitScreenState.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        } else {
          return ListView(shrinkWrap: true, children: [
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 30,
                      right: 30,
                      bottom: 8,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text("Nombre: ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800)),
                                Text(
                                    state.detailField!.fieldName ??
                                        'Sin nombre',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Row(
                              children: [
                                const Text("Tipo de campo: ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800)),
                                Text(
                                    state.detailField!.sportType ?? 'Sin datos',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text("Dirección: ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w800)),
                            Text(
                                state.detailField!.fieldsAddress ??
                                    'Sin dirección',
                                style: const TextStyle(
                                  fontSize: 15,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: AvailabilityList(),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      flex: 3,
                      child: PageContent(leagueId: leagueManager.leagueId),
                    )
                  ],
                ),
              ],
            ),
          ]);
        }
      }),
    );
  }
}

class AvailabilityList extends StatefulWidget {
  const AvailabilityList({Key? key}) : super(key: key);

  @override
  State<AvailabilityList> createState() => _AvailabilityListState();
}

class _AvailabilityListState extends State<AvailabilityList> {
  String? selectedValue1;
  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocConsumer<AvailabilityFieldCubit, AvailabilityFieldState>(
      listener: (context, state) {
        if (state.screenState == BasicCubitScreenState.error) {
          AnimatedSnackBar.rectangle(
            'Error',
            'No se pudo cargar la información',
            type: AnimatedSnackBarType.error,
            brightness: Brightness.light,
          ).show(
            context,
          );
        }
      },
      builder: (context, state) {
        const noDateLabel = 'Sin fecha asignada';

        return state.availability!.isEmpty
            ? const Center(
                child: Text('Sin disponibilidad'),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: state.availability!.length,
                itemBuilder: (context, index) {
                  final item = state.availability![index];
                  const noDateLabel = 'Sin fecha asignada';
                  final firstDate = item.openingDate == null
                      ? noDateLabel
                      : DateFormat('dd-MM-yyyy HH:mm')
                          .format(item.openingDate!);
                  final secondDate = item.expirationDate == null
                      ? noDateLabel
                      : DateFormat('dd-MM-yyyy HH:mm')
                          .format(item.expirationDate!);
                  return Column(
                    children: [
                      const Divider(),
                      ListTile(
                        title: const Text('Periodo de fecha disponible'),
                        subtitle: Text('$firstDate a $secondDate'),
                        onTap: () {
                          context
                              .read<AvailabilityFieldCubit>()
                              .onLoadInitialData(state.availability![index],
                                  leagueManager.leagueId);
                        },
                      ),
                      const Divider()
                    ],
                  );
                },
              );
      },
    );
  }
}

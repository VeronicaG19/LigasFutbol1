import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../../domain/matches/dto/detail_rol_match_dto/detail_rol_match_DTO.dart';
import '../cubit/clasification_cubit.dart';

class AssignMatchDateDialog extends StatefulWidget {
  const AssignMatchDateDialog({Key? key, required this.match})
      : super(key: key);

  final DeatilRolMatchDTO match;

  @override
  State<AssignMatchDateDialog> createState() => _AssignMatchDateDialogState();
}

class _AssignMatchDateDialogState extends State<AssignMatchDateDialog> {
  DateTime? day;
  DateTime? startHour;
  TimeOfDay? hour;

  @override
  void initState() {
    print('este es el campo ${widget.match.fieldMatch}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenState =
        context.select((ClasificationCubit cubit) => cubit.state.screenStatus);
    return BlocListener<ClasificationCubit, ClasificationState>(
      listener: (context, state) {
        if (state.screenStatus == CLScreenStatus.submissionFailure) {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              backgroundColor: Colors.green[800]!,
              textScaleFactor: 1.0,
              message: state.errorMessage ?? 'Error',
            ),
          );
        } else if (state.screenStatus == CLScreenStatus.submissionSuccess) {
          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(25),
        title: const Text('Asignar el horario del partido'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton.icon(
                  icon: const Icon(Icons.date_range, color: Color(0xff358aac)),
                  onPressed: () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 1095)),
                    );
                    if (selected != null) {
                      setState(() {
                        day = selected;
                      });
                    }
                  },
                  label: Text(
                    'Fecha: ${day != null ? DateFormat('dd-MM-yyyy').format(day!) : 'Sin asignar'}',
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton.icon(
                  icon: const Icon(Icons.date_range, color: Color(0xff358aac)),
                  onPressed: () async {
                    final TimeOfDay? time = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (time != null) {
                      setState(() {
                        hour = time;
                      });
                      startHour = DateTime(2000, 1, 1, time.hour, time.minute);
                    }
                  },
                  label: Text(
                    hour == null
                        ? 'Sin asignar'
                        : 'Hora: ${hour?.hour}:${hour?.minute}',
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          if (screenState == CLScreenStatus.submissionInProgress)
            Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            ),
          if (screenState != CLScreenStatus.submissionInProgress)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCELAR'),
            ),
          if (screenState != CLScreenStatus.submissionInProgress)
            TextButton(
              onPressed: () {
                context
                    .read<ClasificationCubit>()
                    .onUpdateMatchDate(day, startHour, widget.match.matchId);
              },
              child: const Text('GUARDAR'),
            ),
        ],
      ),
    );
  }
}

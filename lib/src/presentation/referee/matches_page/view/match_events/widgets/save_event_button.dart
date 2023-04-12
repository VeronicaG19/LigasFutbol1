import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/cubit/events/events_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/widgets/button_custom.dart';

class SaveEventButton extends StatelessWidget {
  const SaveEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                context.read<EventsCubit>().onPressSaveEvent();
                Navigator.pop(context);
              },
              child: ButtonCustom(
                textBtn: ' Guardar evento',
                iconBtn: Icons.save_outlined,
                fontColor: Colors.white,
                backgroundColor: Colors.cyan.shade700,
                isOutline: false,
              ),
            ),
          ],
        );
      },
    );
  }
}

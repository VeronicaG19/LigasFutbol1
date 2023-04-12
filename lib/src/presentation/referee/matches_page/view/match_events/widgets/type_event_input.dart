import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/util/event_util.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/cubit/events/events_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TypeEventInput extends StatelessWidget {
  const TypeEventInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      buildWhen: (previous, current) =>
          previous.typeEventValidator != current.typeEventValidator,
      builder: (context, state) {
        if (state.eventsList.isNotEmpty) {
          return DropdownButtonHideUnderline(
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
                      'Evento',
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
              items: state.eventsList
                  .map((item) => DropdownMenuItem<EventUtil>(
                        value: item,
                        child: Text(
                          item.label!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[200],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              onChanged: (value) =>
                  context.read<EventsCubit>().onEventTypeChange(event: value!),
              value: state.eventUtilSelected,
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
                  color: Colors.blueGrey,
                ),
                color: Colors.blueGrey,
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
          );
        } else {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blue[800]!,
              size: 50,
            ),
          );
        }
      },
    );
  }
}

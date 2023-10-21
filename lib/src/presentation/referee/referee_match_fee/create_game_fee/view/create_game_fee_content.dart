import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../../domain/match_event/util/event_util.dart';
import '../../../../app/app.dart';
import '../../refree_match_fee_list/cubit/referee_match_fee_list_cubit.dart';
import '../cubit/create_game_fee_cubit.dart';

class CreateGameFeeContent extends StatefulWidget{
  const CreateGameFeeContent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateGameFeeContentState();
}

class _CreateGameFeeContentState extends State<CreateGameFeeContent> {
  @override
  Widget build(BuildContext context) {
    final referee = context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return BlocConsumer<CreateGameFeeCubit, CreateGameFeeState>(
      listener: (context, state){
        if (state.statusForm == FormzStatus.submissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Tarifa creada correctamente'),
                  duration: Duration(seconds: 5)),
            );
          context.read<RefereeMatchFeeListCubit>().loadFeeList(activeId: referee.activeId);
          Navigator.pop(context);
        }else if (state.statusForm == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? ''),
                  duration: const Duration(seconds: 5)),
            );
        } else {
          context.read<RefereeMatchFeeListCubit>().loadFeeList(activeId: referee.activeId);
          //Navigator.pop(context);
        }
      },
      builder: (context, state){
        return Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: ListView(
            shrinkWrap: true,
            children: const [
              _ButtonFootballType(),
              SizedBox(height: 15,),
              _FeeValue(),
              SizedBox(height: 50,),
              _SubmitButton(),
            ],
          ),
        );
      },
    );
  }
}

class _ButtonFootballType extends StatefulWidget{
  const _ButtonFootballType({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonFootballTypeState();
}

class _ButtonFootballTypeState extends State<_ButtonFootballType>{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGameFeeCubit, CreateGameFeeState>(
        builder: (context, state){
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
                      'Tipo de juego',
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
              items: state.footballTypeList
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
              onChanged: (value) {
                context.read<CreateGameFeeCubit>().onFootballTypeChange(value!);
              },
              value: state.footballTypeValue,
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
        }
    );
  }
}

class _FeeValue extends StatelessWidget {
  const _FeeValue({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateGameFeeCubit>();
    return BlocBuilder<CreateGameFeeCubit, CreateGameFeeState>(
      buildWhen: (previous, current) => previous.feeValue != current.feeValue,
      builder: (context, state) {
        return TextFormField(
          key: const Key('fee_value'),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          maxLength: 10, 
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          onChanged: cubit.onFeeValueChanged,
          onFieldSubmitted: (value) => state.statusForm.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Monto a cobrar (MXN)",
            labelStyle: const TextStyle(fontSize: 13),
            border: const OutlineInputBorder(),
            errorText: state.feeValue.invalid ? "Escriba el monto a cobrar" : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final referee = context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    final Color? color = Colors.green[800];
    return BlocBuilder<CreateGameFeeCubit, CreateGameFeeState>(
      buildWhen: (previous, current) => previous.statusForm != current.statusForm,
      builder: (context, state) {
        return state.statusForm.isSubmissionInProgress
            ? LoadingAnimationWidget.fourRotatingDots(
          color: color!,
          size: 50,
        )
            : ElevatedButton(
          key: const Key('new_fee_submit_button'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50.0),
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: state.statusForm.isValidated
              ? () {
            FocusScope.of(context).unfocus();
            context.read<CreateGameFeeCubit>().createPrice(referee.activeId!);
          }
          : null,
          child: const Text(
            'Guardar',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white60, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
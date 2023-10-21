import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/domain/lookupvalue/entity/lookupvalue.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/detail/cubit/category_lm_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddCategoryPage extends StatelessWidget {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);

    return TextButton(
      onPressed: () async {
        showDialog(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
                backgroundColor: Colors.grey[200],
                title: const Text('Agregar categoria'),
                content: BlocProvider.value(
                    value: BlocProvider.of<CategoryLmCubit>(context)
                      ..getSoccerGender(),
                    // create: (_) =>
                    //   locator<CategoryLmCubit>()..getLookUpValueByTypeLM(),
                    child: BlocConsumer<CategoryLmCubit, CategoryLmState>(
                        listener: (context, state) {
                      /*  if (state.status == FormzStatus.submissionSuccess) {
                        showTopSnackBar(
                          context,
                          CustomSnackBar.success(
                            backgroundColor: color2!,
                            textScaleFactor: 1.0,
                            message: "Se creo correctamente la categoria",
                          ),
                        );
                      }*/
                    }, builder: (context, state) {
                      if (state.screenStatus == ScreenStatus.loading) {
                        return Center(
                          child: LoadingAnimationWidget.fourRotatingDots(
                            color: const Color(0xff358aac),
                            size: 50,
                          ),
                        );
                      }
                      return Container(
                        color: Colors.grey[200],
                        width: 600,
                        height: double.maxFinite,
                        child: ListView(children: <Widget>[
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                radius: 70,
                                backgroundColor: const Color(0xff0791a3),
                                child: Image.asset(
                                  'assets/images/categoria2.png',
                                  fit: BoxFit.cover,
                                  height: 90,
                                  width: 90,
                                  color: Colors.grey[300],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      child: _CategoryNameInput(),
                                    ),
                                    const Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 15, right: 15),
                                            child: _MinAgeInput(),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 15, right: 15),
                                            child: _MaxAgeInput(),
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: _TypeInputs(),
                                        )),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: _CommentInput(),
                                    ),
                                    const Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 15, right: 15),
                                            child: _YellowForPunishmentInput(),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 15, right: 15),
                                            child: _RedForPunishmentInput(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    state.status.isSubmissionInProgress
                                        ? Center(
                                            child: LoadingAnimationWidget
                                                .fourRotatingDots(
                                              color: const Color(0xff358aac),
                                              size: 50,
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: () async {
                                                    context
                                                        .read<CategoryLmCubit>()
                                                        .resetInputsAndForm();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        16.0, 10.0, 16.0, 10.0),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xff740404),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15.0)),
                                                    ),
                                                    child: Text(
                                                      'Salir',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'SF Pro',
                                                        color: Colors.grey[200],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: () async {
                                                    await context
                                                        .read<CategoryLmCubit>()
                                                        .createCategoryId(
                                                            leagueManager);
                                                    if (state.validAge &&
                                                        state.allFormIsValid) {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        16.0, 10.0, 16.0, 10.0),
                                                    decoration: BoxDecoration(
                                                      color: (state.validAge &&
                                                              state
                                                                  .allFormIsValid)
                                                          ? const Color(
                                                              0xff045a74)
                                                          : Colors.grey,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(15.0),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Guardar cambios',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'SF Pro',
                                                        color: Colors.grey[200],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                  ])
                            ],
                          ),
                        ]),
                      );
                    })));
          },
        );
        /*   Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCategoryPage(),
                ),
              );*/
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
        decoration: const BoxDecoration(
          color: Color(0xff045a74),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Text(
          'Agregar categorias',
          style: TextStyle(
            fontFamily: 'SF Pro',
            color: Colors.grey[200],
            fontWeight: FontWeight.w500,
            fontSize: 10.0,
          ),
        ),
      ),
    );
  }
}

class _CategoryNameInput extends StatelessWidget {
  const _CategoryNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryLmCubit, CategoryLmState>(
      buildWhen: (previous, current) =>
          previous.categoryName != current.categoryName,
      builder: (context, state) => TextFormField(
        key: const Key('name_category_textField'),
        onChanged: (value) =>
            context.read<CategoryLmCubit>().onChangeCategoryName(value),
        onFieldSubmitted: (value) => state.status.isSubmissionInProgress,
        decoration: InputDecoration(
          labelText: "Nombre Categoría",
          labelStyle: const TextStyle(fontSize: 13),
          errorText: state.categoryName.invalid ? "Nombre muy corto" : null,
        ),
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}

class _MinAgeInput extends StatelessWidget {
  const _MinAgeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryLmCubit, CategoryLmState>(
      buildWhen: (previous, current) => (previous.minAge != current.minAge ||
          previous.validAge != current.validAge),
      builder: (context, state) {
        return TextFormField(
          key: const Key('age_min_textField'),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) =>
              context.read<CategoryLmCubit>().onChangeMinAge(value),
          onFieldSubmitted: (value) => state.status.isSubmissionInProgress
              ? null
              : context.read<CategoryLmCubit>().updateCategoryId(),
          decoration: InputDecoration(
            labelText: "Edad minima",
            labelStyle: const TextStyle(fontSize: 13),
            errorText: (state.minAge.invalid || !state.validAge)
                ? "Debe ser menor a la máxima"
                : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _MaxAgeInput extends StatelessWidget {
  const _MaxAgeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryLmCubit, CategoryLmState>(
      buildWhen: (previous, current) => (previous.maxAge != current.maxAge ||
          previous.validAge != current.validAge),
      builder: (context, state) {
        return TextFormField(
          key: const Key('age_max_textField'),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) =>
              context.read<CategoryLmCubit>().onChangeMaxAge(value),
          onFieldSubmitted: (value) => state.status.isSubmissionInProgress
              ? null
              : context.read<CategoryLmCubit>().updateCategoryId(),
          decoration: InputDecoration(
            labelText: "Edad máxima",
            labelStyle: const TextStyle(fontSize: 13),
            errorText: (state.maxAge.invalid || !state.validAge)
                ? "Debe ser mayor a la minima"
                : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _CommentInput extends StatelessWidget {
  const _CommentInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryLmCubit, CategoryLmState>(
      buildWhen: (previous, current) => previous.comment != current.comment,
      builder: (context, state) {
        return TextFormField(
          key: const Key('comment_category_textField'),
          onChanged: (value) =>
              context.read<CategoryLmCubit>().onChangeComment(value),
          onFieldSubmitted: (value) => state.status.isSubmissionInProgress
              ? null
              : context.read<CategoryLmCubit>().updateCategoryId(),
          decoration: const InputDecoration(
            labelText: "Comentario",
            labelStyle: const TextStyle(fontSize: 13),
            // errorText: state.comment.invalid ? "Datos no válidos" : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _YellowForPunishmentInput extends StatelessWidget {
  const _YellowForPunishmentInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryLmCubit, CategoryLmState>(
      buildWhen: (previous, current) =>
          previous.yellowForPunishment != current.yellowForPunishment,
      builder: (context, state) {
        return TextFormField(
          key: const Key('yellow_target_textField'),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) => context
              .read<CategoryLmCubit>()
              .onChangeYellowForPunishment(value),
          onFieldSubmitted: (value) => state.status.isSubmissionInProgress
              ? null
              : context.read<CategoryLmCubit>().updateCategoryId(),
          decoration: InputDecoration(
            labelText: "Amarillas para suspensión",
            labelStyle: const TextStyle(fontSize: 13),
            errorText:
                state.yellowForPunishment.invalid ? "Datos no válidos" : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _RedForPunishmentInput extends StatelessWidget {
  const _RedForPunishmentInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryLmCubit, CategoryLmState>(
      buildWhen: (previous, current) =>
          previous.redForPunishment != current.redForPunishment,
      builder: (context, state) {
        return TextFormField(
          key: const Key('red_target_textField'),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) =>
              context.read<CategoryLmCubit>().onChangeRedForPunishment(value),
          onFieldSubmitted: (value) => state.status.isSubmissionInProgress
              ? null
              : context.read<CategoryLmCubit>().updateCategoryId(),
          decoration: InputDecoration(
            labelText: "Rojas para sanción de partidos",
            labelStyle: const TextStyle(fontSize: 13),
            errorText:
                state.redForPunishment.invalid ? "Datos no válidos" : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _TypeInputs extends StatefulWidget {
  const _TypeInputs({Key? key}) : super(key: key);

  @override
  State<_TypeInputs> createState() => _TypeInputsState();
}

class _TypeInputsState extends State<_TypeInputs> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryLmCubit, CategoryLmState>(
      builder: (context, state) {
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
                    'Tipo de categoria',
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
            items: state.lookupValueList
                .map((item) => DropdownMenuItem<LookUpValue>(
                      value: item,
                      child: Text(
                        item.lookupName ?? '-',
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
              context
                  .read<CategoryLmCubit>()
                  .onTypeChange(value as LookUpValue);
            },
            value: state.selectedLookupValue,
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
      },
    );
  }
}

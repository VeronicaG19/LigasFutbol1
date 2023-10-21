import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';

import '../../../../core/constans.dart';
import '../bloc/rep_user_post_bloc.dart';

class SeekPlayerDialog extends StatelessWidget {
  const SeekPlayerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CircleAvatar(
    //   radius: 70,
    //   backgroundColor: const Color(0xff0791a3),
    //   child: Image.asset(
    //     'assets/images/categoria2.png',
    //     fit: BoxFit.cover,
    //     height: 90,
    //     width: 90,
    //     color: Colors.grey[300],
    //   ),
    // ),
    return BlocConsumer<RepUserPostBloc, RepUserPostState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Colors.grey[200],
          title: const Text('Agregar publicación'),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _TitleInput(),
                const _DescriptionInput(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Expanded(
                      child: Text('Estado de la publicación'),
                    ),
                    const SizedBox(width: 15),
                    Switch(
                      onChanged: (val) => context
                          .read<RepUserPostBloc>()
                          .add(RepUserPostEvent.onPostStatusChange(val)),
                      value: state.postStatus == 'Y',
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: state.status == FormzStatus.submissionInProgress
              ? [const Center(child: CircularProgressIndicator())]
              : [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Regresar')),
                  if (state.selectedPost.postId != 0)
                    TextButton(
                      onPressed: () {
                        context
                            .read<RepUserPostBloc>()
                            .add(const RepUserPostEvent.deletePost());
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      child: const Text(
                        'Eliminar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      context
                          .read<RepUserPostBloc>()
                          .add(const RepUserPostEvent.createPost());
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<RepUserPostBloc, RepUserPostState>(
        buildWhen: (previous, current) =>
            previous.description != current.description ||
            current.screenState == BasicCubitScreenState.initial ||
            current.screenState == BasicCubitScreenState.loaded,
        builder: (context, state) {
          if (state.screenState == BasicCubitScreenState.initial) {
            return const SizedBox();
          }
          return TextFormField(
            key: const Key('description_form_input'),
            initialValue: state.description.value,
            onChanged: (value) => context
                .read<RepUserPostBloc>()
                .add(RepUserPostEvent.onDescriptionChange(value)),
            keyboardType: TextInputType.text,
            maxLines: 4,
            decoration: textInputDecoration.copyWith(
              labelText: 'Describe la necesidad',
              errorText:
                  state.description.invalid ? 'Texto demasiado corto' : null,
            ),
          );
        },
      ),
    );
  }
}

class _TitleInput extends StatelessWidget {
  const _TitleInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<RepUserPostBloc, RepUserPostState>(
        buildWhen: (previous, current) =>
            previous.title != current.title ||
            current.screenState == BasicCubitScreenState.initial ||
            current.screenState == BasicCubitScreenState.loaded,
        builder: (context, state) {
          if (state.screenState == BasicCubitScreenState.initial) {
            return const SizedBox();
          }
          return TextFormField(
            key: const Key('title_form_input'),
            initialValue: state.title.value,
            onChanged: (value) => context
                .read<RepUserPostBloc>()
                .add(RepUserPostEvent.onTitleChange(value)),
            keyboardType: TextInputType.text,
            decoration: textInputDecoration.copyWith(
              labelText: '¿Qué buscas de un jugador?',
              errorText: state.title.invalid ? 'Texto demasiado corto' : null,
            ),
          );
        },
      ),
    );
  }
}

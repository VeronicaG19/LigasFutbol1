import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/lm_request_cubit.dart';

class RefereeDialogContent extends StatelessWidget {
  const RefereeDialogContent({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const RefereeDialogContent());

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((LmRequestCubit cubit) => cubit.state.requestStatus);

    return SizedBox(
      height: 300.0,
      width: 700.0,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            status == 1
                ? const Text('Responder solicitud')
                : const Text('Solicitud enviada'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                child: SizedBox(
                  height: 200.0,
                  child: TextField(
                    decoration: const InputDecoration(hintText: "Comentarios"),
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    onChanged: context.read<LmRequestCubit>().onCommentChanged,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

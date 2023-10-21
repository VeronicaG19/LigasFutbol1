import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../service_locator/injection.dart';
import 'cubit/rquest_cubit.dart';
import 'widgets/cancel_request_card_admin.dart';

class CancelLeagueRequest extends StatelessWidget {
  const CancelLeagueRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<RquestCubit>()..getLeagueCancelRequests(),
      child: BlocConsumer<RquestCubit, RquestState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: state.request.length,
              padding: const EdgeInsets.only(top: 40),
              itemBuilder: (context, index) => CancelRequestCardAdmin(
                request: state.request[index],
              ),
            );
          }
        },
      ),
    );
  }
}

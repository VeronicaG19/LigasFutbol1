import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/super_admin/requests/cubit/rquest_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/super_admin/requests/widgets/request_field_card_admin.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../service_locator/injection.dart';

class RequestFieldsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<RquestCubit>()..getPendingRequestField(),
      child: BlocConsumer<RquestCubit, RquestState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if(state.screenStatus == ScreenStatus.loading){
            return Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: const Color(0xff358aac),
                        size: 50,
                      ),
                    );
          }else{ 
            return  ListView.builder(
                  itemCount: state.request.length,
                  padding: EdgeInsets.only(top: 40),
                  itemBuilder: (context, index) {
                    return RequestFieldCardAdmin(request: state.request[index],
                    onTap:()=> context.read<RquestCubit>().onAcceptRequestField(state.request[index].requestId, true), 
                    onTapCancel: ()=> context.read<RquestCubit>().onAcceptRequestField(state.request[index].requestId, false),);
                  }); 
          } 
        },
      )
    );
  }
}
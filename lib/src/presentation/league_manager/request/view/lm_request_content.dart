import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums.dart';
import '../../../../domain/user_requests/entity/user_requests.dart';
import '../cubit/lm_request_cubit.dart';
import 'request_card.dart';

class LMRequestContent extends StatelessWidget {
  const LMRequestContent(
      {super.key, required this.title, required this.requestType});

  final String title;
  final LMRequestType requestType;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (requestType == LMRequestType.tournament ||
            requestType == LMRequestType.referee)
          SelectRequestTypeHeader(requestType: requestType),
        Padding(
          padding:
              const EdgeInsets.only(left: 50, right: 50, top: 15, bottom: 30),
          child: TextField(
            decoration: const InputDecoration(
              labelStyle: TextStyle(fontSize: 15),
              labelText: 'Buscar',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
            ),
            onChanged: context.read<LmRequestCubit>().onFilterRequestList,
          ),
        ),
        BlocBuilder<LmRequestCubit, LmRequestState>(
          builder: (context, state) {
            final list = <UserRequests>[];
            if (requestType == LMRequestType.league) {
              list.addAll(state.adminRequestList);
            } else if (requestType == LMRequestType.referee) {
              list.addAll(state.refereeRequestList);
            } else if (requestType == LMRequestType.tournament) {
              list.addAll(state.tournamentList);
            }
            if (list.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(25.0),
                child: Center(
                  child: Text('Sin solicitudes'),
                ),
              );
            }
            return SingleChildScrollView(
              child: GridView.builder(
                padding: const EdgeInsets.only(
                  right: 15,
                  left: 15,
                  bottom: 15,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 4 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (BuildContext ctx, index) => RequestCard(
                  requestType: requestType,
                  request: list[index],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SelectRequestTypeHeader extends StatefulWidget {
  const SelectRequestTypeHeader({Key? key, required this.requestType})
      : super(key: key);
  final LMRequestType requestType;

  @override
  State<SelectRequestTypeHeader> createState() =>
      _SelectRequestTypeHeaderState();
}

class _SelectRequestTypeHeaderState extends State<SelectRequestTypeHeader> {
  int selected = 0;
  static const String sentRequestLbl = 'Ver solicitudes recibidas';
  static const String receivedRequestLbl = 'Ver solicitudes enviadas';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SizedBox(
              width: 500,
              child: RadioListTile<int>(
                value: 0,
                groupValue: selected,
                onChanged: (value) {
                  setState(() {
                    selected = value!;
                  });
                  context.read<LmRequestCubit>().onChangeRequestType(value!);
                  // if (widget.requestType == LMRequestType.referee) {
                  // }
                },
                title: const Text(sentRequestLbl),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 500,
              child: RadioListTile<int>(
                value: 1,
                groupValue: selected,
                onChanged: (value) {
                  setState(() {
                    selected = value!;
                  });
                  context.read<LmRequestCubit>().onChangeRequestType(value!);
                  // if (widget.requestType == LMRequestType.referee) {
                  // }
                },
                title: const Text(receivedRequestLbl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

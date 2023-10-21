import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/enums.dart';
import '../../../../app/app.dart';
import '../../create_game_fee/view/create_game_fee_page.dart';
import '../cubit/referee_match_fee_list_cubit.dart';

class RefereeMatchFeeListContent extends StatelessWidget{
  const RefereeMatchFeeListContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefereeMatchFeeListCubit, RefereeMatchFeeListState>(
        builder: (context, state) {
          if (state.screenState == BasicCubitScreenState.loading) {
             return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: AppBar(
                  backgroundColor: Colors.grey[200],
                  title: Text(
                    'Tarifas',
                    style:
                    TextStyle(color: Colors.grey[200], fontWeight: FontWeight.w900),
                  ),
                  flexibleSpace: const Image(
                    image: AssetImage('assets/images/imageAppBar25.png'),
                    fit: BoxFit.cover,
                  ),
                  elevation: 0.0,
                ),
              ),
              body: Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            )
            );
          }
          else {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: AppBar(
                  backgroundColor: Colors.grey[200],
                  title: Text(
                    'Tarifas',
                    style:
                    TextStyle(color: Colors.grey[200], fontWeight: FontWeight.w900),
                  ),
                  flexibleSpace: const Image(
                    image: AssetImage('assets/images/imageAppBar25.png'),
                    fit: BoxFit.cover,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  BlocProvider.value(
                                    value: BlocProvider.of<RefereeMatchFeeListCubit>(context),
                                    child: const CreateGameFeePage(),
                                  )
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Text(
                          'Agregar',
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            color: Colors.grey[200],
                            fontWeight: FontWeight.w500,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                  elevation: 0.0,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: state.feeList.isNotEmpty ?
                ListView.builder(
                  itemCount: state.feeList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.monetization_on,
                                color: Colors.blueGrey,
                                size: 50,
                              ),
                              const SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  if(state.feeList[index].periotTime == 'SOCCER')
                                  const Text(
                                    "Tarifa para: Fútbol soccer",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if(state.feeList[index].periotTime == 'FUTBOL7')
                                    const Text(
                                      "Tarifa para: Fútbol 7",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  if(state.feeList[index].periotTime == 'INDORFUTBOL')
                                    const Text(
                                      "Tarifa para: Fútbol sala",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  if(state.feeList[index].periotTime == 'FASTFUTBOL')
                                    const Text(
                                      "Tarifa para: Fútbol rápido",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  const SizedBox(height: 8),
                                  Text("Tarifa: ${state.feeList[index].price} (${state.feeList[index].currency})"),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ],
                          ),
                          _ActionsRow(priceId: state.feeList[index].priceId!,)
                        ],
                      ),
                    );
                  },
                ) :
                const Center(child: Text("No tiene tarifas creadas."))
              ),
            );
          }
        }
    );
  }
}

class _ActionsRow extends StatelessWidget {
  const _ActionsRow({Key? key, required this.priceId}) : super(key: key);
  final int priceId;

  @override
  Widget build(BuildContext context) {
    final referee = context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /*TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit),
          label: const Text("Editar", style: TextStyle(color: Colors.blueAccent),
          ),
        ),*/
        TextButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (contextD) {
                return BlocProvider.value(
                  value: BlocProvider.of<RefereeMatchFeeListCubit>(context),
                  child: AlertDialog(
                    title: const Text('Eliminar tarifa'),
                    content: const Text('¿Deseas eliminar la tarifa?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(contextD),
                        child: const Text('REGRESAR'),
                      ),
                      TextButton(
                        onPressed: () {
                          context
                              .read<RefereeMatchFeeListCubit>()
                              .deletePrice(
                              priceId: priceId,
                              activeId: referee.activeId!
                          );
                          Navigator.pop(contextD);
                        },
                        child: const Text('ELIMINAR', style: TextStyle(color: Colors.red),),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          icon: Icon(Icons.delete, color: Colors.red[400],),
          label: Text("Eliminar", style: TextStyle(color: Colors.red[400]),),
        ),
      ],
    );
  }
}

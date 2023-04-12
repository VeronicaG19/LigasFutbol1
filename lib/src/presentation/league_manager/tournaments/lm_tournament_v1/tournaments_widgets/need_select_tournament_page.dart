import 'package:flutter/material.dart';

class NeedSlctTournamentPage extends StatelessWidget {
  const NeedSlctTournamentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Image.asset('assets/images/informacion.png',
         width: 200,
         height: 200,),
           const SizedBox(
                              width: 15,
                            ),
          const Text('Seleccione algún torneo para poder editar su información.', 
          style: TextStyle(
            fontSize: 30
          ),)
        ],
      ),
    );
  }
}
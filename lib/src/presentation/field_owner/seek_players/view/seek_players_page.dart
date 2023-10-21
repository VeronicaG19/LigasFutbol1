// import 'package:flutter/material.dart';
//
// class SeekPlayersPage extends StatelessWidget {
//   const SeekPlayersPage({Key? key}) : super(key: key);
//
//   static Route route() =>
//       MaterialPageRoute(builder: (_) => const SeekPlayersPage());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[200],
//         title: Text(
//           'Mis publicaciones',
//           style: TextStyle(
//               color: Colors.grey[200],
//               fontSize: 23,
//               fontWeight: FontWeight.w900),
//         ),
//         flexibleSpace: const Image(
//           image: AssetImage('assets/images/imageAppBar25.png'),
//           fit: BoxFit.cover,
//         ),
//         actions: const [
//           _TeamSwapOption(),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(bottom: 75),
//         child: ListView.separated(
//             itemBuilder: (context, index) => ListTile(
//                   leading: const Icon(
//                     Icons.message,
//                     color: Color(0xff0791a3),
//                   ),
//                   title: Text(
//                     'Mi publicacion d$index ni ddarle u ajustificacion le ofrecieron al escitor tom',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   subtitle: const Text(
//                     'descripcion de la publicacion.... xxxxxxxxxxxxxxxxxxxx para no aceptar la ofertadsadasd ',
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   trailing: const Icon(Icons.clear, color: Colors.red),
//                   onTap: () {
//                     showDialog(
//                       context: (context),
//                       builder: (context) => AlertDialog(
//                         title: const Text('Editar publicacion'),
//                         content: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const TextField(
//                               maxLines: 4,
//                               decoration: InputDecoration(
//                                 hintText: 'Decripcion',
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 const Text('Estado de la publicacion'),
//                                 Switch(
//                                   onChanged: (value) {},
//                                   value: false,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         actions: [],
//                       ),
//                     );
//                   },
//                   // trailing: Container(
//                   //   //color: Colors.blue,
//                   //   width: 75,
//                   //   child: Row(
//                   //     mainAxisAlignment: MainAxisAlignment.end,
//                   //     children: [
//                   //       Icon(
//                   //         Icons.delete,
//                   //         color: Colors.redAccent,
//                   //       ),
//                   //       SizedBox(width: 25),
//                   //       Icon(
//                   //         Icons.edit,
//                   //         color: Color(0xff0791a3),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                 ),
//             separatorBuilder: (context, value) => const Divider(),
//             itemCount: 20),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color(0xff0791a3),
//         onPressed: () {},
//         child: const Icon(
//           Icons.add,
//         ),
//       ),
//     );
//   }
// }
//
// class _TeamSwapOption extends StatefulWidget {
//   const _TeamSwapOption({Key? key}) : super(key: key);
//
//   @override
//   State<_TeamSwapOption> createState() => _TeamSwapOptionState();
// }
//
// class _TeamSwapOptionState extends State<_TeamSwapOption> {
//   int league = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     // final leagues =
//     //     context.select((AuthenticationBloc bloc) => bloc.state.refereeLeagues);
//     //league = leagues.isNotEmpty ? leagues.first : League.empty;
//     final items = List.generate(
//       5,
//       (index) => PopupMenuItem<int>(
//         value: 1,
//         child: Text('option $index'),
//       ),
//     );
//
//     return PopupMenuButton<int>(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//       icon: const Icon(Icons.sync_alt, size: 20),
//       onSelected: (option) {
//         // setState(() {
//         //   league = option;
//         // });
//         // context
//         //     .read<AuthenticationBloc>()
//         //     .add(ChangeRefereeLeagueEvent(option));
//       },
//       itemBuilder: (context) => items,
//       initialValue: league,
//       tooltip: 'Cambiar de equipo',
//     );
//   }
// }

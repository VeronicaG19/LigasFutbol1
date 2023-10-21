import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/domain/referee/entity/referee.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/edit_profile_image/view/profile_image_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/app.dart';
import '../../../referee_match_fee/refree_match_fee_list/view/referee_match_fee_list_page.dart';
import '../../referee_agenda/view/referee_agenda_page.dart';
import '../cubit/referee_profile_cubit.dart';
import 'edit_addres_page.dart';

enum PositionItemType {
  log,
  position,
}

class RefereeProfilePage extends StatefulWidget {
  const RefereeProfilePage({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const RefereeProfilePage());

  @override
  State<RefereeProfilePage> createState() => _RefereeProfilePageState();
}

class _RefereeProfilePageState extends State<RefereeProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final refereeData =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    final league =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeLeague);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Ficha de Árbitro - ' + league.leagueName,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fill,
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white24,
              child: Icon(
                Icons.share,
                size: 18,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              final box = context.findRenderObject() as RenderBox?;
              await Share.share(
                  '¡Ven y regístrate a Ligas fútbol!\n'
                  'Vive la experiencia como jugador, árbitro, etc, con una proyección profesional.'
                  ' En ligas fútbol tenemos las mejores ligas de la zona, no te quedes'
                  ' afuera y vive la experiencia.\n\n'
                  '¡Regístrate 𝐆𝐑𝐀𝐓𝐈𝐒 ahora!',
                  subject: '¡Regístrate 𝐆𝐑𝐀𝐓𝐈𝐒 ahora!',
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/imageAppBar25.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 380.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ProfileImageWidget(
                      radius: 50,
                    ),
                  ),
                  // IconButton(
                  //   iconSize: 80.0,
                  //   icon: const CircleAvatar(
                  //     backgroundImage: AssetImage(kDefaultAvatarImagePath),
                  //     radius: 50.0,
                  //     child: Align(
                  //       alignment: Alignment.bottomRight,
                  //       child: CircleAvatar(
                  //         backgroundColor: Colors.white,
                  //         radius: 10.0,
                  //         child: Icon(
                  //           Icons.edit,
                  //           size: 15.0,
                  //           color: Colors.blueAccent,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  //   onPressed: () {},
                  // ),
                  Text(
                    user.person.getFullName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 5.0),
                      color: Colors.white,
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: ListTile(
                                title: const Text(
                                  'Teléfono',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  user.person.getFormattedMainPhone.isEmpty
                                      ? 'Sin teléfono registrado'
                                      : user.person.getFormattedMainPhone,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ListTile(
                                title: const Text(
                                  'Correo',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  user.person.getMainEmail.isEmpty
                                      ? 'Sin correo electrónico registrado'
                                      : user.person.getMainEmail,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: _AddressCard(
                                  refereeData: refereeData,
                                  name: user.person.firstName),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          _RefMenuButton(
            title: 'Editar agenda',
            icon: Icons.menu_book_outlined,
            onTap: () => Navigator.push(context, RefereeAgendaPage.route()),
          ),
          _RefMenuButton(
              title: 'Administrar tarifas',
              icon: Icons.monetization_on,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RefereeMatchFeeListPage()))),
          /*_RefMenuButton(
            title: 'Ver documentos',
            icon: Icons.library_books,
            onTap: () => Navigator.push(context, DocsPage.route()),
          ),*/
        ],
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard(
      {super.key, required this.refereeData, required this.name});

  final Referee refereeData;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'Dirección',
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        refereeData.refereeAddress ?? 'Sin dirección registrada',
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        softWrap: true,
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.blueGrey,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => EditAddressPage(
                personId: refereeData.partyId ?? 0,
                personName: name,
              ),
            ),
          );
          /*if (await Permission.location.isRestricted ||
              await Permission.location.isDenied ||
              await Permission.location.isPermanentlyDenied) {
            Permission.location.request().then((value) {
              if (value == PermissionStatus.granted) {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => EditAddressPage(
                      personId: refereeData.partyId ?? 0,
                      personName: name,
                    ),
                  ),
                );
              }
            });
          }*/
        },
      ),
    );
  }
}

class _AddressDialog extends StatelessWidget {
  const _AddressDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((RefereeProfileCubit cubit) => cubit.state.status);
    final refereeData =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return BlocListener<RefereeProfileCubit, RefereeProfileState>(
      listenWhen: (_, state) =>
          state.status.isSubmissionSuccess || state.status.isSubmissionFailure,
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          final message = state.errorMessage ?? 'Ha ocurrido un error';
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(message)),
            );
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content:
                      Text('La dirección se ha actualizado correctamente.')),
            );
          context.read<AuthenticationBloc>().add(UpdateRefereeData(
              refereeData.copyWith(refereeAddress: state.address.value)));
          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        title: const Text('Dirección'),
        content: status.isSubmissionInProgress
            ? LoadingAnimationWidget.fourRotatingDots(
                color: Color(0xff358aac),
                size: 50,
              )
            : const _AddressInput(),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: status.isSubmissionInProgress
                ? null
                : () {
                    FocusScope.of(context).unfocus();
                    context
                        .read<RefereeProfileCubit>()
                        .onSubmitAddress(refereeData);
                  },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}

class _RefMenuButton extends StatelessWidget {
  const _RefMenuButton(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);
  final String title;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Card(
        color: Colors.blueGrey,
        child: ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: TextStyle(
                color: Colors.grey[200],
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: Colors.grey[200],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

class _AddressInput extends StatelessWidget {
  const _AddressInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refereeData =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return BlocBuilder<RefereeProfileCubit, RefereeProfileState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return TextField(
          maxLines: 2,
          key: const Key('refereeProfile_addressInput_textField'),
          onChanged: (value) =>
              context.read<RefereeProfileCubit>().onAddressChanged(value),
          onSubmitted: (value) => state.status.isSubmissionInProgress
              ? null
              : context
                  .read<RefereeProfileCubit>()
                  .onSubmitAddress(refereeData),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            helperText: '',
            errorText: state.address.invalid ? 'Dirección no válida' : null,
          ),
        );
      },
    );
  }
}

class PositionItem {
  PositionItem(this.type, this.displayValue);

  final PositionItemType type;
  final String displayValue;
}

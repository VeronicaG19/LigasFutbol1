import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/invitations/cubit/invitation_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/invitations/view/phone_contacts_page.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';

class InvitePage extends StatelessWidget {
  const InvitePage({Key? key}) : super(key: key);
  static Route route() => MaterialPageRoute(builder: (_) => const InvitePage());
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            'Invitar}',
          ),
          flexibleSpace: Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          elevation: 0.0,
        ),
      ),
      body: BlocProvider<InvitationCubit>(
        create: (_) => locator<InvitationCubit>(),
        child:
            const Padding(padding: EdgeInsets.all(8.0), child: InviteContent()),
      ),
      //InviteContent()
    );
  }
}

class InviteContent extends StatefulWidget {
  const InviteContent({Key? key}) : super(key: key);

  @override
  _InviteContentState createState() => _InviteContentState();
}

class _InviteContentState extends State<InviteContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = new TextEditingController();
    final Color? color = Color(0xff358aac);
    final Color? color2 = Colors.green[800];

    return BlocListener<InvitationCubit, InvitationState>(
        //listenWhen: (_, state) => state.status.isSubmissionFailure,
        listener: (context, state) {
          /* if (state.status.isSubmissionFailure) {
          showTopSnackBar(
            context,
            CustomSnackBar.info(
              backgroundColor: color!,
              textScaleFactor: 0.9,
              message: state.errorMessage ?? 'Error',
              maxLines: 3,
              textStyle: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          );
         ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ?? 'Error'),
                  duration: const Duration(seconds: 9)),
            );
          //Navigator.of(context).pop();
        } else if (state.status.isSubmissionSuccess) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: color2!,
              textScaleFactor: 1.0,
              message:
                  AppLocalizations.of(context)!.invitationSentSuccessfullyLabel,
            ),
          );
          /*  ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                    "${AppLocalizations.of(context)!.invitationSentSuccessfullyLabel}\n"),
                duration: const Duration(seconds: 9),
              ),
            );*/
          // Navigator.of(context).pop();
        }
      },*/
        },
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
          children: <Widget>[
            Icon(Icons.info, size: 100, color: Color(0xff358aac)),
            SizedBox(
              height: 15,
            ),
            Text(
              "Envía invitaciones a unirse a ligas fútbol",
              textAlign: TextAlign.center,

              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
              //style: style.kTextSubtitleMenu,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Solo tienes que escribir un número "
              "telefónico o correo electrónico que estén vigentes. Toma en cuenta las siguientes recomendaciones."
              "  El tipo de usuario que quieres invitar."
              "  El medio en donde quieres que llegue la invitación."
              "   Número telefónico vigente y no mayor a 10 dígitos."
              "  Correo electrónico vigente y con acceso al mismo.",
              style: const TextStyle(fontSize: 15),
              //style: style.kTextSubtitleMenu,
            ),
            const SizedBox(
              height: 20,
            ),
            GroupRadioButton(
              label: [
                Text("Presidente de liga"),
                Text("Jugador"),
                Text("Representante de equipo"),
                Text("Árbitro")
              ],
              padding: EdgeInsets.symmetric(vertical: 10),
              spaceBetween: 5,
              radioRadius: 10,
              color: Color(0xff358aac),
              onChanged: (listIndex) {
                print(listIndex);
              },
            ),
            const _ReceiverInput(),
            const SizedBox(
              height: 8,
            ),
            const _PickFromContactsBtn(),
            const SizedBox(
              height: 30,
              width: 30,
            ),
            const _SubmitButton(),
          ],
        ));
  }
}

class _ReceiverInput extends StatelessWidget {
  const _ReceiverInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitationCubit, InvitationState>(
      builder: (context, state) {
        return TextFormField(
          // controller: context.read<InvitationCubit>().getController,
          key: const Key('invitationPage_receiverInput_textField'),
          // onChanged: (value) =>
          //     context.read<InvitationCubit>().onInvitationSenderChanged(value),
          //  onFieldSubmitted: (value) => state.status.isSubmissionInProgress
          //     ? null
          //    : context.read<InvitationCubit>().onSendInvitation(),
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.emailOrPhoneLabel,
            helperText: 'Ejemplo 55 1234 5678',
            /*     errorText: state.invitationReceiver.invalid
                ? state.invitationReceiver.error ==
                        InvitationReceiverError.invalid
                    ? "Datos no válidos"
                    : "No te puedes autoinvitar"
                : null,*/
          ),
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color? color = Color(0xff358aac);
    return BlocBuilder<InvitationCubit, InvitationState>(
      //buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return /* state.status.isSubmissionInProgress
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                color: color!,
                size: 50,
              ))
            :*/
            ElevatedButton(
          key: const Key('invitationPage_submit_raisedButton'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            primary: Color(0xff358aac),
          ),
          onPressed: () {},
          /* onPressed: state.status.isValidated
                    ? () {
                        FocusScope.of(context).unfocus();
                        context.read<InvitationCubit>().onSendInvitation();
                      }
                    : null,*/
          child: Text(
            "Enviar invitación",
          ),
        );
      },
    );
  }
}

class _PickFromContactsBtn extends StatelessWidget {
  const _PickFromContactsBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('InvitePage_PickFromContactsBtn_TextButton'),
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => BlocProvider.value(
                value: BlocProvider.of<InvitationCubit>(context),
                child: const PhoneContactsPage()),
          ),
        );
        // if (phoneNumber != null) {
        //   context.read<InvitationCubit>().onSelectFromContacts(phoneNumber);
        // }
      },
      style: TextButton.styleFrom(
          minimumSize: const Size.fromHeight(50.0),
          backgroundColor: Color(0xff358aac),
          shape: (RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ))),
      child: Text(
        "Elegir desde mis contactos",
        style: TextStyle(color: theme.colorScheme.onPrimary),
      ),
    );
  }
}

class GroupRadioButton extends StatefulWidget {
  GroupRadioButton({
    required this.label,
    required this.padding,
    required this.onChanged,
    this.color = Colors.blue,
    this.radioRadius = 14.0,
    this.spaceBetween = 5.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final Color color;
  final List<Widget> label;
  final EdgeInsets padding;
  final Function(int) onChanged;
  final double radioRadius;
  final double spaceBetween;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  _GroupRadioButtonState createState() => _GroupRadioButtonState();
}

class _GroupRadioButtonState extends State<GroupRadioButton> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.label != null ? widget.label.length : 0,
        itemBuilder: (context, index) {
          return LabeledRadio(
            selectedIndex: selectedIndex,
            color: widget.color,
            onChanged: (value) {
              setState(() {
                selectedIndex = value;
                widget.onChanged(value);
                // print(value);
              });
            },
            index: index,
            label: widget.label[index],
            crossAxisAlignment: widget.crossAxisAlignment,
            mainAxisAlignment: widget.mainAxisAlignment,
            radioRadius: widget.radioRadius,
            spaceBetween: widget.spaceBetween,
            padding: widget.padding,
          );
        });
  }
}

class LabeledRadio extends StatelessWidget {
  LabeledRadio({
    required this.label,
    required this.index,
    required this.color,
    //@required this.groupValue,
    //@required this.value,
    required this.onChanged,
    required this.radioRadius,
    required this.padding,
    required this.spaceBetween,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.selectedIndex,
  });

  final Color color;
  final int selectedIndex;
  final Widget label;
  final index;
  final EdgeInsets padding;
  //final bool groupValue;
  //final bool value;
  final Function(int) onChanged;
  final double radioRadius;
  final double spaceBetween;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(index);
      },
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                //color: Const.mainColor,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              padding: EdgeInsets.all(2),
              child: selectedIndex == index
                  ? Container(
                      height: radioRadius,
                      width: radioRadius,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    )
                  : Container(
                      height: radioRadius,
                      width: radioRadius,
                    ),
            ),
            SizedBox(
              width: spaceBetween,
            ),
            label,
          ],
        ),
      ),
    );
  }
}

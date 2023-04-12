import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/invitations/cubit/invitation_cubit.dart';

class PhoneContactsPage extends StatefulWidget {
  const PhoneContactsPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PhoneContactsPage());
  }

  @override
  _PhoneContactsPageState createState() => _PhoneContactsPageState();
}

class _PhoneContactsPageState extends State<PhoneContactsPage> {
  List<Contact>? _contacts;
  List<Contact>? _contacts2;
  bool _permissionDenied = false;
  TextEditingController editingController = TextEditingController();

  void filterContacts(String filter) {
    _contacts2 = _contacts
        ?.where((element) =>
            element.displayName.toLowerCase().contains(filter.toLowerCase()))
        .toList();
    setState(() => _contacts2 = _contacts2);
  }

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  String normalizeNumber(String number) {
    String n = '';
    n = number.replaceAll(RegExp(r"\D"), "");
    if (n.length > 10) {
      n = n.substring(n.length - 10);
    }
    debugPrint(n.length.toString());
    return n;
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => {_contacts = contacts, _contacts2 = contacts});
    }
  }

  Color colorData(String letter) {
    Color? setColor = Colors.amber;
    switch (letter) {
      case "A":
        setColor = Color(0xffc78909);
        break;
      case "B":
        setColor = Color(0xff0467ac);
        break;
      case "C":
        setColor = Color(0xff6f8a9a);
        break;
      case "D":
        setColor = Color(0xff328414);
        break;
      case "E":
        setColor = Color(0xff7d5017);
        break;
      case "F":
        setColor = Color(0xff10795f);
        break;
      case "G":
        setColor = Color(0xff8a0b95);
        break;
      case "H":
        setColor = Color(0xff20970b);
        break;
      case "I":
        setColor = Color(0xff06976d);
        break;
      case "J":
        setColor = Color(0xff929706);
        break;
      case "K":
        setColor = Color(0xff97062f);
        break;
      case "L":
        setColor = Color(0xff975606);
        break;
      case "M":
        setColor = Color(0xff970606);
        break;
      case "N":
        setColor = Color(0xff065d97);
        break;
      case "Ñ":
        setColor = Color(0xff06974c);
        break;
      case "O":
        setColor = Color(0xff978406);
        break;
      case "P":
        setColor = Color(0xff069775);
        break;
      case "Q":
        setColor = Color(0xff429706);
        break;
      case "R":
        setColor = Color(0xff970688);
        break;
      case "S":
        setColor = Color(0xff975d06);
        break;
      case "T":
        setColor = Color(0xff8d9706);
        break;
      case "U":
        setColor = Color(0xff067a97);
        break;
      case "V":
        setColor = Color(0xff97067f);
        break;
      case "W":
        setColor = Color(0xff974a06);
        break;
      case "X":
        setColor = Color(0xff97061c);
        break;
      case "Y":
        setColor = Color(0xff429706);
        break;
      case "Z":
        setColor = Color(0xff979006);
        break;
    }

    return setColor;
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: const Text('Contactos')), body: _body());

  Widget _body() {
    if (_permissionDenied) {
      return const Center(child: Text('Permission denied'));
    }
    if (_contacts == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return BlocBuilder<InvitationCubit, InvitationState>(
      builder: (context, state) {
        if (state.status.isSubmissionInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            SizedBox(height: 15, width: 15),
            SizedBox(
              height: 45,
              child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: TextField(
                  onChanged: (value) {
                    filterContacts(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.lblinvitesrch,
                      hintText: AppLocalizations.of(context)!.lblinvitesrch,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _contacts2!.length,
                itemBuilder: (context, i) => Column(children: [
                  SizedBox(height: 20),
                  ListTile(
                    leading: CircleAvatar(
                        backgroundColor:
                            colorData(_contacts2![i].displayName[0]) as Color,
                        radius: 30,
                        child: Text(_contacts2![i].displayName[0],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                    title: Text(
                      _contacts2![i].displayName,
                    ),
                    onTap: () async {
                      final fullContact =
                          await FlutterContacts.getContact(_contacts2![i].id);
                      // normalizeNumber(fullContact?.phones.first.number ?? '');
                      // for (var phone in fullContact!.phones) {
                      //   print(phone.number.trim());
                      //   print(phone.normalizedNumber.substring(3));
                      // }
                      if (fullContact!.phones.isNotEmpty) {
                        final phoneNumber =
                            normalizeNumber(fullContact.phones.first.number);
                        final name = fullContact.displayName;
                        showDialog(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            title: const Text('Estás invitando a'),
                            content: Text(fullContact.phones.first.number),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(dialogContext),
                                  child: Text(AppLocalizations.of(context)!
                                      .aeCancelLbl)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                    context
                                        .read<InvitationCubit>()
                                        .onSelectFromContacts(
                                            phoneNumber, name);
                                  },
                                  child: const Text('Ok')),
                            ],
                          ),
                        );
                        // Navigator.of(context).pop(
                        //     fullContact.phones.first.normalizedNumber.substring(3));
                        /*else {
                        Navigator.of(context)
                            .pop(fullContact.phones.first.normalizedNumber);
                      }*/
                      }
                      // await Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (_) => ContactPage(fullContact!)));
                    },
                  )
                ]),
              ),
            ),
          ],
        );
      },
    );
  }
}

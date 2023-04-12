import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums.dart';
import '../../../app/app.dart';
import 'w_menu_option.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (_) => const PersonalData());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            'Datos personales',
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
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          PDMenuOption(
            icon: Icons.settings,
            title: 'Nombre',
            subtitle: user.person.getFullName,
            action: PersonalDataSubmitAction.updatePersonName,
          ),
          PDMenuOption(
            icon: Icons.edit,
            title: 'Correo electrónico',
            subtitle: user.person.getMainEmail,
            action: PersonalDataSubmitAction.updateEmail,
          ),
          PDMenuOption(
            icon: Icons.change_circle,
            title: 'Teléfono',
            subtitle: user.person.getFormattedMainPhone,
            action: PersonalDataSubmitAction.updatePhone,
          ),
        ],
      ),
    );
  }
}

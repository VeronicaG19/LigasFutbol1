import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/player_profile/view/player_profile_content.dart';

import '../../../app/app.dart';

class PlayerProfilePage extends StatelessWidget {
  const PlayerProfilePage({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const PlayerProfilePage());

  @override
  Widget build(BuildContext context) {
    final personId =
        context.read<AuthenticationBloc>().state.user.person.personId;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: PlayerProfileContent(personId: personId));
  }
}

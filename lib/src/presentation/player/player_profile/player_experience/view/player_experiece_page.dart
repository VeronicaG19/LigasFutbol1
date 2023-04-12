import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../service_locator/injection.dart';
import '../../../soccer_team/players/experiences_player/cubit/experiences_cubit.dart';
import '../../../soccer_team/players/experiences_player/esperiences_page.dart';
import '../cubit/player_experience_cubit.dart';

class PlayerExperiencePage extends StatelessWidget {
  const PlayerExperiencePage({Key? key}) : super(key: key);

  static Route route(ExperiencesCubit cubit) =>
      MaterialPageRoute(builder: (_) => BlocProvider.value(value: cubit,
        child: const PlayerExperiencePage(),));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          title: const Text(
            'Agregar experiencia',
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          elevation: 0.0,
        ),
      ),
      body: BlocProvider<PlayerExperienceCubit>(
        create: (_) => locator<PlayerExperienceCubit>(),
        child: const _PlayerExperienceContent(),
      ),
    );
  }
}

class _PlayerExperienceContent extends StatelessWidget {
  const _PlayerExperienceContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final personId =
        context.read<AuthenticationBloc>().state.user.person.personId;
    return BlocConsumer<PlayerExperienceCubit, PlayerExperienceState>(
      listener: (context, state){
        if(state.status == FormzStatus.submissionSuccess){
          context.read<ExperiencesCubit>().getExperiencesByPlayer(personId!);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: const [
              _TitleInput(),
              _DescriptionInput(),
              _LeagueInput(),
              _CategoryInput(),
              _TournamentInput(),
              _TeamInput(),
              _SubmitButton(),
            ],
          ),
        );
      },
    );
  }
}

final _myInputDecoration = InputDecoration(
  hintStyle: const TextStyle(color: Colors.black45),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(
      width: 3,
      color: Colors.orange,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(width: 3, color: Colors.blue),
    borderRadius: BorderRadius.circular(15),
  ),
  labelStyle: const TextStyle(
      color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 15),
);

class _TitleInput extends StatelessWidget {
  const _TitleInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partyId = context
        .select((AuthenticationBloc bloc) => bloc.state.user.person.personId);
    return BlocBuilder<PlayerExperienceCubit, PlayerExperienceState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        final cubit = context.read<PlayerExperienceCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            key: const Key('player_experience_title_input_textField'),
            onChanged: cubit.onTitleChanged,
            onSubmitted: (value) => state.status.isSubmissionInProgress
                ? null
                : cubit.onSubmitNewExperience(partyId ?? 0),
            keyboardType: TextInputType.text,
            decoration: _myInputDecoration.copyWith(
              labelText: 'Título',
              hintText: 'Con que título te gustaría ver tu publicación',
              errorText: state.title.invalid
                  ? 'Ingresa los datos faltantes' //AppLocalizations.of(context)!.aeInvalidUsernameMsg
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partyId = context
        .select((AuthenticationBloc bloc) => bloc.state.user.person.personId);
    return BlocBuilder<PlayerExperienceCubit, PlayerExperienceState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        final cubit = context.read<PlayerExperienceCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            key: const Key('player_experience_description_input_textField'),
            onChanged: cubit.onDescriptionChanged,
            onSubmitted: (value) => state.status.isSubmissionInProgress
                ? null
                : cubit.onSubmitNewExperience(partyId ?? 0),
            keyboardType: TextInputType.text,
            decoration: _myInputDecoration.copyWith(
              labelText: 'Descripción',
              hintText: 'Coloca una breve historia de tu publicación',
              errorText: state.description.invalid
                  ? 'Ingresa los datos faltantes' //AppLocalizations.of(context)!.aeInvalidUsernameMsg
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _LeagueInput extends StatelessWidget {
  const _LeagueInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partyId = context
        .select((AuthenticationBloc bloc) => bloc.state.user.person.personId);
    return BlocBuilder<PlayerExperienceCubit, PlayerExperienceState>(
      buildWhen: (previous, current) => previous.league != current.league,
      builder: (context, state) {
        final cubit = context.read<PlayerExperienceCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            key: const Key('player_experience_league_input_textField'),
            onChanged: cubit.onLeagueChanged,
            onSubmitted: (value) => state.status.isSubmissionInProgress
                ? null
                : cubit.onSubmitNewExperience(partyId ?? 0),
            keyboardType: TextInputType.text,
            decoration: _myInputDecoration.copyWith(
              labelText: 'Liga',
            ),
          ),
        );
      },
    );
  }
}

class _CategoryInput extends StatelessWidget {
  const _CategoryInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partyId = context
        .select((AuthenticationBloc bloc) => bloc.state.user.person.personId);
    return BlocBuilder<PlayerExperienceCubit, PlayerExperienceState>(
      buildWhen: (previous, current) => previous.category != current.category,
      builder: (context, state) {
        final cubit = context.read<PlayerExperienceCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            key: const Key('player_experience_category_input_textField'),
            onChanged: cubit.onCategoryChanged,
            onSubmitted: (value) => state.status.isSubmissionInProgress
                ? null
                : cubit.onSubmitNewExperience(partyId ?? 0),
            keyboardType: TextInputType.text,
            decoration: _myInputDecoration.copyWith(
              labelText: 'Categoría',
            ),
          ),
        );
      },
    );
  }
}

class _TournamentInput extends StatelessWidget {
  const _TournamentInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partyId = context
        .select((AuthenticationBloc bloc) => bloc.state.user.person.personId);
    return BlocBuilder<PlayerExperienceCubit, PlayerExperienceState>(
      buildWhen: (previous, current) =>
          previous.tournament != current.tournament,
      builder: (context, state) {
        final cubit = context.read<PlayerExperienceCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            key: const Key('player_experience_tournament_input_textField'),
            onChanged: cubit.onTournamentChanged,
            onSubmitted: (value) => state.status.isSubmissionInProgress
                ? null
                : cubit.onSubmitNewExperience(partyId ?? 0),
            keyboardType: TextInputType.text,
            decoration: _myInputDecoration.copyWith(
              labelText: 'Torneo',
            ),
          ),
        );
      },
    );
  }
}

class _TeamInput extends StatelessWidget {
  const _TeamInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partyId = context
        .select((AuthenticationBloc bloc) => bloc.state.user.person.personId);
    return BlocBuilder<PlayerExperienceCubit, PlayerExperienceState>(
      buildWhen: (previous, current) => previous.team != current.team,
      builder: (context, state) {
        final cubit = context.read<PlayerExperienceCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            key: const Key('player_experience_team_input_textField'),
            onChanged: cubit.onTeamChanged,
            onSubmitted: (value) => state.status.isSubmissionInProgress
                ? null
                : cubit.onSubmitNewExperience(partyId ?? 0),
            keyboardType: TextInputType.text,
            decoration: _myInputDecoration.copyWith(
              labelText: 'Equipo',
            ),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partyId = context
        .select((AuthenticationBloc bloc) => bloc.state.user.person.personId);
    final personId =
        context.read<AuthenticationBloc>().state.user.person.personId;
    final Color? color = Colors.green[800];
    return BlocBuilder<PlayerExperienceCubit, PlayerExperienceState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? LoadingAnimationWidget.fourRotatingDots(
                color: color!,
                size: 50,
              )
            : ElevatedButton(
                key: const Key('player_experience_submit_button'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50.0),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: state.status.isValidated
                    ? () {
                        FocusScope.of(context).unfocus();
                        context.read<PlayerExperienceCubit>()
                            .onSubmitNewExperience(partyId ?? 0);
                      }
                    : null,
                child: const Text(
                  'Guardar', //AppLocalizations.of(context)!.aeLoginButtonLbl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white60, fontWeight: FontWeight.bold),
                ),
              );
      },
    );
  }
}

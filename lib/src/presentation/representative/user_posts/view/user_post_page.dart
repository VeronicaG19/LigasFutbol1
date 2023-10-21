import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../core/enums.dart';
import '../../../../domain/team/entity/team.dart';
import '../../../../domain/user_post/entity/user_post.dart';
import '../../../../service_locator/injection.dart';
import '../../../app/app.dart';
import '../bloc/rep_user_post_bloc.dart';
import 'seek_player_dialog.dart';

class UserPostPage extends StatelessWidget {
  const UserPostPage({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const UserPostPage());

  @override
  Widget build(BuildContext context) {
    final personId = context
        .select((AuthenticationBloc bloc) => bloc.state.user.person.personId);
    return BlocProvider(
      create: (context) => locator<RepUserPostBloc>()
        ..add(RepUserPostEvent.requestTeamsList(personId: personId ?? 0)),
      child: const _UserPostContent(),
    );
  }
}

class _UserPostContent extends StatelessWidget {
  const _UserPostContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'Mis publicaciones',
          style: TextStyle(
              color: Colors.grey[200],
              fontSize: 20,
              fontWeight: FontWeight.w900),
        ),
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.cover,
        ),
        actions: const [
          _TeamSwapOption(),
        ],
      ),
      body: BlocConsumer<RepUserPostBloc, RepUserPostState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Publicación realizada')));
          }
          if (state.status == FormzStatus.submissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? 'Error')));
          }
        },
        buildWhen: (previous, current) =>
            previous.userPostsList != current.userPostsList ||
            current.screenState == BasicCubitScreenState.loading,
        builder: (context, state) {
          if (state.screenState == BasicCubitScreenState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.userPostsList.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text('Sin elementos'),
                ),
                OutlinedButton(
                    onPressed: () => context.read<RepUserPostBloc>().add(
                        RepUserPostEvent.requestPostsList(
                            authorId: state.selectedTeam.teamId ?? 0)),
                    child: const Text('Recargar')),
              ],
            );
          }
          return RefreshIndicator(
            onRefresh: () async => context.read<RepUserPostBloc>().add(
                RepUserPostEvent.requestPostsList(
                    authorId: state.selectedTeam.teamId ?? 0)),
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      leading: const Icon(
                        Icons.message,
                        color: Color(0xff0791a3),
                      ),
                      title: Text(
                        state.userPostsList[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        state.userPostsList[index].description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: state.userPostsList[index].statusPost == 'Y'
                          ? const Icon(Icons.check, color: Colors.green)
                          : const Icon(Icons.clear, color: Colors.red),
                      onTap: () => showDialog(
                        context: (context),
                        builder: (_) {
                          context.read<RepUserPostBloc>().add(
                              RepUserPostEvent.selectPost(
                                  post: state.userPostsList[index]));
                          return BlocProvider.value(
                            value: BlocProvider.of<RepUserPostBloc>(context),
                            child: const SeekPlayerDialog(),
                          );
                        },
                      ),
                    ),
                separatorBuilder: (context, value) => const Divider(),
                itemCount: state.userPostsList.length),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<RepUserPostBloc, RepUserPostState>(
        builder: (context, state) {
          if (state.screenState == BasicCubitScreenState.loading) {
            return const SizedBox();
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Buscando jugadores'),
                ),
              ),
              if (state.screenState == BasicCubitScreenState.sending)
                const SizedBox(
                  height: 50,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (state.screenState != BasicCubitScreenState.sending)
                Switch(
                  onChanged: (val) => context
                      .read<RepUserPostBloc>()
                      .add(RepUserPostEvent.changeTeamRPStatus(val)),
                  value: state.selectedTeam.requestPlayers == 'Y',
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff0791a3),
        onPressed: () => showDialog(
          context: context,
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<RepUserPostBloc>(context)
              ..add(const RepUserPostEvent.selectPost(post: UserPost.empty)),
            child: const SeekPlayerDialog(),
          ),
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class _TeamSwapOption extends StatelessWidget {
  const _TeamSwapOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTeam =
        context.select((RepUserPostBloc bloc) => bloc.state.selectedTeam);

    return BlocBuilder<RepUserPostBloc, RepUserPostState>(
      buildWhen: (previous, current) =>
          previous.teamList != current.teamList ||
          previous.selectedTeam != current.selectedTeam,
      builder: (context, state) {
        return PopupMenuButton<Team>(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          icon: const Icon(Icons.sync_alt, size: 20),
          onSelected: (option) => context
              .read<RepUserPostBloc>()
              .add(RepUserPostEvent.selectTeam(team: option)),
          itemBuilder: (context) => List.generate(
            state.teamList.length,
            (index) => PopupMenuItem<Team>(
              value: state.teamList[index],
              child: Text(state.teamList[index].teamName ?? ''),
            ),
          ),
          initialValue: selectedTeam,
          tooltip: 'Cambiar de equipo',
        );
      },
    );
  }
}

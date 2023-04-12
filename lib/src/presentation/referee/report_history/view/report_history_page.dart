import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../service_locator/injection.dart';
import '../cubit/report_history_cubit.dart';
import 'report_detail.dart';

class ReportHistoryPage extends StatelessWidget {
  const ReportHistoryPage({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const ReportHistoryPage());

  @override
  Widget build(BuildContext context) {
    final referee =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reportes de arbitraje',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fill,
        ),
        elevation: 0.0,
      ),
      body: BlocProvider(
        create: (_) => locator<ReportHistoryCubit>()
          ..onLoadInitialData(referee.refereeId ?? 0),
        child: const _ReportHistoryContent(),
      ),
    );
  }
}

class _ReportHistoryContent extends StatelessWidget {
  const _ReportHistoryContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportHistoryCubit, ReportHistoryState>(
      builder: (context, state) {
        if (state.screenState == BasicCubitScreenState.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Color(0xff358aac),
              size: 50,
            ),
          );
        }
        return state.reportList.isEmpty
            ? const Center(
                child: Text('Sin contenido'),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.reportList[index].partido,
                        style: TextStyle(fontSize: 15)),
                    subtitle: Text(state.reportList[index].ligayTorneo,
                        style: TextStyle(fontSize: 12)),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xff358aac),
                      size: 18,
                    ),
                    onTap: () => Navigator.push(context,
                        ReportDetailPage.route(state.reportList[index])),
                  );
                },
                itemCount: state.reportList.length,
              );
      },
    );
  }
}

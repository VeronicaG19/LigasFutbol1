import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/fees_tab/fees_tab.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/field_detail/cubit/fo_field_detail_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/field_tab/view/field_tab.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'field_detail/view/field_detail.dart';
import 'schedule/view/schedule_page.dart';

class FieldAvailabilityListPage extends StatelessWidget {
  const FieldAvailabilityListPage({Key? key, required this.field})
      : super(key: key);

  final Field field;
  static Route route(Field field) => MaterialPageRoute(
      builder: (_) => FieldAvailabilityListPage(field: field));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<FoFieldDetailCubit>()..getFieldsAvailability(field.activeId!),
      child: _PageContent(
        field: field,
      ),
    );
  }
}

class _PageContent extends StatefulWidget {
  const _PageContent({Key? key, required this.field}) : super(key: key);

  final Field field;

  @override
  State<_PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<_PageContent>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {
        index = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Disponibilidad de cancha',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.fill,
          ),
          elevation: 0.0,
          bottom: TabBar(
            controller: _controller,
            tabs: const [
              Tab(text: 'Disponibilidad'),
              Tab(text: 'Tarifas'),
              Tab(text: 'Campo'),
            ],
            onTap: (index) {
              setState(() {
                this.index = index;
              });
            },
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            _ReportHistoryContent(field: widget.field),
            FeesTab(field: widget.field),
            FieldTab(field: widget.field),
          ],
        ),
        floatingActionButton: index == 0
            ? FloatingActionButton(
                backgroundColor: const Color(0xff358aac),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (_) {
                      return BlocProvider.value(
                        value: BlocProvider.of<FoFieldDetailCubit>(context)
                          ..onLoadFieldData(widget.field),
                        child: FieldDetail(
                          field: widget.field,
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}

class _ReportHistoryContent extends StatelessWidget {
  const _ReportHistoryContent({Key? key, required this.field})
      : super(key: key);
  final Field field;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoFieldDetailCubit, FoFieldDetailState>(
      builder: (context, state) {
        if (state.screenState == BasicCubitScreenState.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        }
        return state.availability!.isEmpty
            ? const Center(
                child: Text('Sin contenido'),
              )
            : ListView.builder(
                itemCount: state.availability!.length,
                itemBuilder: (context, index) {
                  final item = state.availability![index];
                  const noDateLabel = 'Sin fecha asignada';
                  final firstDate = item.openingDate == null
                      ? noDateLabel
                      : DateFormat('dd-MM-yyyy HH:mm')
                          .format(item.openingDate!);
                  final secondDate = item.expirationDate == null
                      ? noDateLabel
                      : DateFormat('dd-MM-yyyy HH:mm')
                          .format(item.expirationDate!);
                  return Column(
                    children: [
                      const Divider(),
                      ListTile(
                        title: const Text('Periodo de fecha disponible'),
                        subtitle: Text('$firstDate a $secondDate'),
                        onTap: () => Navigator.push(
                          context,
                          SchedulePage.route(item),
                        ),
                      ),
                      const Divider()
                    ],
                  );
                },
              );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/core/constans.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/fees_tab/fees_tab.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/field_detail/cubit/fo_field_detail_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/ratting_all/view/field_rating_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/update_field/view/update_field.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../player/user_menu/widget/help_menu_button.dart';
import '../player/user_menu/widget/tutorial_widget.dart';
import 'field_detail/view/field_detail.dart';
import 'schedule/view/schedule_page.dart';

class FieldAvailabilityListPage extends StatelessWidget {
  const FieldAvailabilityListPage({
    Key? key,
    required this.field,
  }) : super(key: key);

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
    const double tabSize = 50;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            HelpMeButton(
              iconData: Icons.help,
              tuto: TutorialType.filedOwner2,
            ),
          ],
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(140),
            child: Column(
              children: [
                _FieldInfo(field: widget.field),
                Align(
                  alignment: Alignment.center,
                  child: TabBar(
                    controller: _controller,
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 2.0,
                    unselectedLabelColor: Colors.white70,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white38,
                    ),
                    tabs: [
                      Tab(
                        key: CoachKey.agendField,
                        height: tabSize,
                        child: const _FieldOwnerTab(
                          title: 'Disponibilidad',
                          icon: Icons.calendar_month_outlined,
                        ),
                      ),
                      Tab(
                        key: CoachKey.priecesField,
                        height: tabSize,
                        child: const _FieldOwnerTab(
                          title: 'Tarifas',
                          icon: Icons.monetization_on,
                        ),
                      ),
                      // Tab(key: CoachKey.detailField, text: 'Campo'),
                      Tab(
                        key: CoachKey.detailQualifications,
                        height: tabSize,
                        child: const _FieldOwnerTab(
                          title: 'Reseñas',
                          icon: Icons.reviews,
                        ),
                      ),
                    ],
                    onTap: (index) {
                      setState(() {
                        this.index = index;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            _ReportHistoryContent(field: widget.field),
            FeesTab(field: widget.field),
            // FieldTab(field: widget.field),
            FieldRattingPage(field: widget.field),
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

class _FieldInfo extends StatelessWidget {
  final Field field;

  const _FieldInfo({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                UpdateField.route(field),
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.cyan.shade600,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${field.fieldName}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${field.fieldsAddress}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              Text(
                '${field.sportType}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FieldOwnerTab extends StatelessWidget {
  final String title;
  final IconData icon;

  const _FieldOwnerTab({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white70,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
            Icon(icon)
          ],
        ),
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

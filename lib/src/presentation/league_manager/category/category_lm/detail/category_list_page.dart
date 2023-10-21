import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/detail/cubit/category_lm_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/constans.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  @override
  Widget build(BuildContext context) {
    // final Color? color = Colors.blue[800];
    // final Color? color2 = Colors.green[800];
    return BlocBuilder<CategoryLmCubit, CategoryLmState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        }
        return ListView(
          shrinkWrap: true,
          children: [
            Container(
              color: Colors.white54,
              child: Column(
                key: CoachKey.mainSelectCategoryAdminLeg,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Categorías",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocConsumer<CategoryLmCubit, CategoryLmState>(
                    listenWhen: (_, state) =>
                        state.status.isSubmissionFailure ||
                        state.status.isSubmissionSuccess,
                    listener: (context, state) {
                      if (state.screenStatus ==
                              ScreenStatus.updatedSuccessful &&
                          state.status.isSubmissionSuccess) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              content: Text("Se actualizó correctamente."),
                            ),
                          );
                      } else if (state.screenStatus ==
                              ScreenStatus.successfullyCreated &&
                          state.status.isSubmissionSuccess) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              content: Text("Categoría creada correctamente."),
                            ),
                          );
                      } else if (state.status.isSubmissionFailure) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              content: Text("Error inesperado"),
                            ),
                          );
                      }
                    },
                    builder: (context, state) {
                      return (state.categoryList.isEmpty)
                          ? const _BoxAlert()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.categoryList.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            const Color(0xff0791a3),
                                        child: Image.asset(
                                          'assets/images/categoria2.png',
                                          fit: BoxFit.cover,
                                          height: 28,
                                          width: 28,
                                          color: Colors.grey[300],
                                        ), /*Icon(
                                    //    Icons.sports_basketball_sharp,
                                    Icons.app_registration,
                                    size: 25,
                                    color: Colors.grey[200],
                                  ),*/
                                      ),
                                      /*  trailing: Text(
                                    state.categoryList[index].sportType!,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xff358aac))),*/
                                      title: Text(
                                          state.categoryList[index]
                                              .categoryName!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      subtitle: Text(context
                                          .read<CategoryLmCubit>()
                                          .genderType(state
                                              .categoryList[index].gender!)!),
                                      onTap: () {
                                        context
                                            .read<CategoryLmCubit>()
                                            .onCategoryIdChange(state
                                                .categoryList[index]
                                                .categoryId!);
                                        context
                                            .read<CategoryLmCubit>()
                                            .getInfoCategoryId(
                                                categoryId: state
                                                    .categoryList[index]
                                                    .categoryId!);
                                        print(
                                            "Id categoria ---->${state.categoryList[index].categoryId}");
                                      },
                                    ),
                                    const Divider(),
                                  ],
                                );
                              },
                              padding: const EdgeInsets.only(
                                  top: 25, right: 15, left: 15),
                            );
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class _BoxAlert extends StatelessWidget {
  const _BoxAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'No hay categorias disponibles',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

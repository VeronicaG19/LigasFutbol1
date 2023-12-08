import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/bloc/authentication_bloc.dart';

class InternalizationButton extends StatefulWidget {
  const InternalizationButton({Key? key, required this.type}) : super(key: key);
  final int type;

  @override
  State<InternalizationButton> createState() => _InternalizationButtonState();
}

class _InternalizationButtonState extends State<InternalizationButton> {
  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'Español',
      'Ingles',
    ];
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) =>
          previous.selectedLanguage != current.selectedLanguage,
      builder: (context, state) {
        if (state.status == AuthenticationStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return widget.type == 1
            ? DropdownButtonHideUnderline(
                child: DropdownButton2(
                  dropdownDecoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  selectedItemHighlightColor: Colors.grey,
                  isExpanded: false,
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: state.selectedLanguage == "es" ? "Español" : "Ingles",
                  onChanged: (value) {
                    if (value == 'Español') {
                      context
                          .read<AuthenticationBloc>()
                          .add(const ChangeSelectedLanguage('es', 1));
                    } else {
                      context
                          .read<AuthenticationBloc>()
                          .add(const ChangeSelectedLanguage('en', 1));
                    }
                  },
                  buttonHeight: 40,
                  buttonWidth: 120,
                  icon: ImageIcon(
                    color: Colors.transparent,
                    state.selectedLanguage == "es"
                        ? const AssetImage("assets/images/idioma_es.png")
                        : const AssetImage("assets/images/idioma_en.png"),
                  ),
                  itemHeight: 40,
                ),
              ) /*Padding(
                padding: EdgeInsets.only(left: 50, right: 50, bottom: 5),
                child: ,
              )*/
            : DropdownButtonHideUnderline(
                child: DropdownButton2(
                  dropdownDecoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  selectedItemHighlightColor: Colors.grey,
                  isExpanded: false,
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: state.selectedLanguage == "es" ? "Español" : "Ingles",
                  onChanged: (value) {
                    if (value == 'Español') {
                      context
                          .read<AuthenticationBloc>()
                          .add(const ChangeSelectedLanguage('es', 2));
                    } else {
                      context
                          .read<AuthenticationBloc>()
                          .add(const ChangeSelectedLanguage('en', 2));
                    }
                    //   Navigator.pop(context);
                  },
                  buttonHeight: 40,
                  buttonWidth: 250,
                  icon: ImageIcon(
                    color: Colors.transparent,
                    state.selectedLanguage == "es"
                        ? const AssetImage("assets/images/idioma_es.png")
                        : const AssetImage("assets/images/idioma_en.png"),
                  ),
                  itemHeight: 40,
                ),
              );
      },
    );
  }
}

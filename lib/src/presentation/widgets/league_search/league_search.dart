import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/entity/league.dart';

class LeagueSearch extends StatefulWidget {
  const LeagueSearch(
      {Key? key,
      required this.list,
      required this.selectedValue,
      required this.function})
      : super(key: key);
  final List<League> list;
  final League selectedValue;
  final Function function;

  @override
  State<LeagueSearch> createState() => _LeagueSearchState();
}

class _LeagueSearchState extends State<LeagueSearch> {
  @override
  Widget build(BuildContext context) {
    Widget _customPopupItemBuilderExample2(
        BuildContext context, League item, bool isSelected) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: !isSelected
            ? null
            : BoxDecoration(
                border: Border.all(color: Color(0xff358aac)),
                borderRadius: BorderRadius.circular(5),
                color: Color(0xff358aac),
              ),
        child: ListTile(
          selected: isSelected,
          title: Text(item.leagueName),
          subtitle: Text(item.leagueDescription.toString()),
          leading: const CircleAvatar(
              backgroundColor: Color(0xff358aac),
              child: Icon(
                Icons.emoji_events_rounded,
                size: 25,
              )),
        ),
      );
    }

    return DropdownSearch<League>(
      //asyncItems: (filter) => getData(filter),
      items: widget.list,

      filterFn: (user, filter) => user.userFilter(filter),
      itemAsString: (League u) => u.leagueName,
      compareFn: (i, s) => i.isEqual(s),
      onChanged: (League? value) => widget.function(value),
      selectedItem: widget.selectedValue,
      /*onChanged: (League? value) {
        print("Valor--->$value");
        setState(() {
          selectedValue1 = value!.leagueName;
        });
        context.read<LeagueCubit>().getTournamentByLeagueId(
            int.parse(value!.leagueId.toString()));
      },*/
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(labelText: "Ligas"),
        baseStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      popupProps: PopupPropsMultiSelection.dialog(
        isFilterOnline: true,
        showSelectedItems: true,
        showSearchBox: true,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Buscar liga:",
              style: TextStyle(
                fontWeight: FontWeight.w800,
              )),
        ),
        itemBuilder: _customPopupItemBuilderExample2,
      ),
    );
  }
}

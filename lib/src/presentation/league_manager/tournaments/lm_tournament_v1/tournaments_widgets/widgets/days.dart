import 'package:equatable/equatable.dart';

import '../../../../../../core/enums.dart';

class Days extends Equatable {
  final DaysEnum? daysEnum;
  final bool? isSelected;
  const Days({required this.daysEnum, required this.isSelected});

  Days copyWith({
    DaysEnum? daysEnum,
    bool? isSelected,
  }) {
    return Days(
      daysEnum: daysEnum ?? this.daysEnum,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  DaysEnum getDaySelected(int day) {
    switch (day) {
      case 1:
        return DaysEnum.lunes;
      case 2:
        return DaysEnum.martes;
      case 3:
        return DaysEnum.miercoles;
      case 4:
        return DaysEnum.jueves;
      case 5:
        return DaysEnum.viernes;
      case 6:
        return DaysEnum.sabado;
      case 7:
        return DaysEnum.domingo;
      default:
        return DaysEnum.lunes;
    }
  }

  int getNUmberDay(DaysEnum day) {
    switch (day) {
      case DaysEnum.lunes:
        return 1;
      case DaysEnum.martes:
        return 2;
      case DaysEnum.miercoles:
        return 3;
      case DaysEnum.jueves:
        return 4;
      case DaysEnum.viernes:
        return 5;
      case DaysEnum.sabado:
        return 6;
      case DaysEnum.domingo:
        return 7;
      default:
        return 1;
    }
  }

  @override
  List<Object?> get props => [daysEnum, isSelected];
}

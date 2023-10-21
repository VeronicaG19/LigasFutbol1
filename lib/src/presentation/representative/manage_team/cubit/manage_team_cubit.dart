import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team/dto/create_team/create_team_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/domain/team/service/i_team_service.dart';
import 'package:ligas_futbol_flutter/src/domain/uniform/dto/uniform_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/uniform/service/i_uniform_service.dart';

part 'manage_team_state.dart';

@injectable
class ManageTeamCubit extends Cubit<ManageTeamState> {
  ManageTeamCubit(
    this._iTeamService,
    this._uniformService,
  ) : super(const ManageTeamState());

  final ITeamService _iTeamService;
  final IUniformService _uniformService;

  Future<void> getTeamInfo({required int teamId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final request = await _iTeamService.getDetailTeamByIdTeam(teamId);
    request.fold(
      (l) => emit(state.copyWith(
        screenStatus: ScreenStatus.error,
        errorMessage: l.errorMessage,
      )),
      (r) {
        emit(state.copyWith(screenStatus: ScreenStatus.loaded, teamInfo: r));
      },
    );
  }

  Future<void> uploadTeamLogo({
    required Team team,
    XFile? xFile,
    CroppedFile? file,
  }) async {
    final list = await file?.readAsBytes() ?? await xFile?.readAsBytes();
    final photo = base64Encode(list!);

    emit(state.copyWith(teamlogoImageSelected: photo, showTeamLogo: xFile));
    final request = await _iTeamService.updateTeam(CreateTeamDTO(
      teamId: team.teamId,
      logoImage: photo,
      categoryId: team.categoryId?.categoryId,
      fiedlId: 0,
      firstManagerId: 0,
      leageAuxId: 0,
      appoved: 0,
      teamName: state.teamInfo.teamName,
      teamPhothoImage: null,
      uniformLocalImage: null,
      uniformVisitImage: null,
    ));

    request.fold(
      (l) => emit(state.copyWith(
        screenStatus: ScreenStatus.error,
        errorMessage: l.errorMessage,
      )),
      (r) {
        emit(state.copyWith(screenStatus: ScreenStatus.savedInformation));
        getTeamInfo(teamId: team.teamId!);
      },
    );
  }

  Future<void> getUniformsOfTeamById({required int teamId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loadingUniforms));

    final request = await _uniformService.getUniformsByTeamId(teamId);

    request.fold(
      (l) => emit(state.copyWith(
        screenStatus: ScreenStatus.error,
        errorMessage: l.errorMessage,
      )),
      (r) {
        emit(state.copyWith(
            screenStatus: ScreenStatus.uniformsLoaded, uniformsList: r));
      },
    );
  }

  Future<void> uploadImgLocal({
    required UniformDto uniformDto,
    XFile? xFile,
    CroppedFile? file,
  }) async {
    final list = await file?.readAsBytes() ?? await xFile?.readAsBytes();
    final photo = base64Encode(list!);

    emit(state.copyWith(
        uniformLocalImageSelected: photo,
        showUniformL: xFile,
        screenStatus: ScreenStatus.uniformsLoaded));

    final request = await _uniformService.saveUniformOfTeam(UniformDto(
      // * SHORT
      teamId: uniformDto.teamId,
      teamName: uniformDto.teamName,
      uniformId: uniformDto.uniformId ?? 0,
      // * SHIRT
      fileTshirtId: (uniformDto.fileTshirtId != null &&
              uniformDto.uniformTshirtId != null)
          ? uniformDto.fileTshirtId
          : 0,
      uniformTshirtId: (uniformDto.fileTshirtId != null &&
              uniformDto.uniformTshirtId != null)
          ? uniformDto.uniformTshirtId
          : 0,
      uniformTshirtImage: photo,
      // * SHORT
      fileShortId: uniformDto.fileShortId ?? 0,
      uniformShortId: uniformDto.uniformShortId ?? 0,
      uniformShortImage: uniformDto.uniformShortImage ?? '',
      uniformType: 'LOCAL',
    ));

    request.fold(
      (l) => emit(state.copyWith(
        screenStatus: ScreenStatus.error,
        errorMessage: l.errorMessage,
      )),
      (r) {
        emit(state.copyWith(
          screenStatus: ScreenStatus.uniformSaved,
          uniformDto: r,
        ));

        getUniformsOfTeamById(teamId: uniformDto.teamId!);
      },
    );
  }

  Future<void> uploadImgVisitant({
    required UniformDto uniformDto,
    XFile? xFile,
    CroppedFile? file,
  }) async {
    final list = await file?.readAsBytes() ?? await xFile?.readAsBytes();
    final photo = base64Encode(list!);

    emit(state.copyWith(uniformVisitImageSelected: photo, showUniformV: xFile));
    final request = await _uniformService.saveUniformOfTeam(UniformDto(
      // * SHORT
      teamId: uniformDto.teamId,
      teamName: uniformDto.teamName,
      uniformId: uniformDto.uniformId ?? 0,
      // * SHIRT
      fileTshirtId: (uniformDto.fileTshirtId != null &&
              uniformDto.uniformTshirtId != null)
          ? uniformDto.fileTshirtId
          : 0,
      uniformTshirtId: (uniformDto.fileTshirtId != null &&
              uniformDto.uniformTshirtId != null)
          ? uniformDto.uniformTshirtId
          : 0,
      uniformTshirtImage: photo,
      // * SHORT
      fileShortId: uniformDto.fileShortId ?? 0,
      uniformShortId: uniformDto.uniformShortId ?? 0,
      uniformShortImage: uniformDto.uniformShortImage ?? '',
      uniformType: 'VISIT',
    ));

    request.fold(
      (l) => emit(state.copyWith(
        screenStatus: ScreenStatus.error,
        errorMessage: l.errorMessage,
      )),
      (r) {
        emit(state.copyWith(
          screenStatus: ScreenStatus.uniformSaved,
          uniformDto: r,
        ));

        getUniformsOfTeamById(teamId: uniformDto.teamId!);
      },
    );
  }

  Future<void> convertImgToBs({
    XFile? xFile,
    CroppedFile? file,
  }) async {
    final imgLength = await file?.readAsBytes() ?? await xFile?.readAsBytes();

    // Convertir bytes a megabytes
    double megabytesImagen = imgLength!.length / (1024 * 1024);

    // Devolver el tamaño de la imagen
    emit(state.copyWith(
      imageIsLarge: !(megabytesImagen < 1),
    ));
  }
}

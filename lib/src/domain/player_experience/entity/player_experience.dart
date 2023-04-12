import 'package:equatable/equatable.dart';

class PlayerExperience extends Equatable {
  final DateTime? dateEnd;
  final DateTime? dateStart;
  final String enabledFlag;
  final int experienceId;
  final String experiencesDescription;
  final int experiencesPosition;
  final String experiencesTitle;
  final File file;
  final String leagueName;
  final int partyId;
  final String privacity;
  final String team;
  final String teamCategory;
  final String tournament;
  final int typeExperience;

  const PlayerExperience({
    this.dateEnd,
    this.dateStart,
    required this.enabledFlag,
    required this.experienceId,
    required this.experiencesDescription,
    required this.experiencesPosition,
    required this.experiencesTitle,
    required this.file,
    required this.leagueName,
    required this.partyId,
    required this.privacity,
    required this.team,
    required this.teamCategory,
    required this.tournament,
    required this.typeExperience,
  });

  static const empty = PlayerExperience(
      enabledFlag: 'Y',
      experienceId: 0,
      experiencesDescription: '',
      experiencesPosition: 0,
      experiencesTitle: '',
      file: File.empty,
      leagueName: '',
      partyId: 0,
      privacity: '',
      team: '',
      teamCategory: '',
      tournament: '',
      typeExperience: 0);

  Map<String, dynamic> toJson() {
    return {
      'dateEnd': dateEnd,
      'dateStart': dateStart,
      'enabledFlag': enabledFlag,
      'experienceId': experienceId,
      'experiencesDescription': experiencesDescription,
      'experiencesPosition': experiencesPosition,
      'experiencesTitle': experiencesTitle,
      'file': file,
      'leagueName': leagueName,
      'partyId': partyId,
      'privacity': privacity,
      'team': team,
      'teamCategory': teamCategory,
      'tournament': tournament,
      'typeExperience': typeExperience,
    };
  }

  factory PlayerExperience.fromJson(Map<String, dynamic> json) {
    final dateEndS = json['dateEnd']?.toString();
    final DateTime? dateEndD =
        dateEndS != null ? DateTime.parse(dateEndS) : null;

    final dateStartS = json['dateStart']?.toString();
    final DateTime? dateStartD =
        dateStartS != null ? DateTime.parse(dateStartS) : null;
    return PlayerExperience(
      dateEnd: dateEndD ?? DateTime.now(),
      dateStart: dateStartD ?? DateTime.now(),
      enabledFlag: json['enabledFlag'] ?? '',
      experienceId: json['experienceId'] ?? 0,
      experiencesDescription: json['experiencesDescription'] ?? '',
      experiencesPosition: json['experiencesPosition'] ?? 0,
      experiencesTitle: json['experiencesTitle'] ?? '',
      //file: File.fromJson(json['fileId']),
      leagueName: json['leagueName'] ?? '',
      partyId: json['partyId'] ?? 0,
      privacity: json['privacity'] ?? '',
      team: json['team'] ?? '',
      teamCategory: json['teamCategory'] ?? '',
      tournament: json['tournament'] ?? '',
      typeExperience: json['typeExperience'] ?? 0, file: File.fromJson(json),
    );
  }

  PlayerExperience copyWith({
    DateTime? dateEnd,
    DateTime? dateStart,
    String? enabledFlag,
    int? experienceId,
    String? experiencesDescription,
    int? experiencesPosition,
    String? experiencesTitle,
    File? file,
    String? leagueName,
    int? partyId,
    String? privacity,
    String? team,
    String? teamCategory,
    String? tournament,
    int? typeExperience,
  }) {
    return PlayerExperience(
      dateEnd: dateEnd ?? this.dateEnd,
      dateStart: dateStart ?? this.dateStart,
      enabledFlag: enabledFlag ?? this.enabledFlag,
      experienceId: experienceId ?? this.experienceId,
      experiencesDescription:
          experiencesDescription ?? this.experiencesDescription,
      experiencesPosition: experiencesPosition ?? this.experiencesPosition,
      experiencesTitle: experiencesTitle ?? this.experiencesTitle,
      file: file ?? this.file,
      leagueName: leagueName ?? this.leagueName,
      partyId: partyId ?? this.partyId,
      privacity: privacity ?? this.privacity,
      team: team ?? this.team,
      teamCategory: teamCategory ?? this.teamCategory,
      tournament: tournament ?? this.tournament,
      typeExperience: typeExperience ?? this.typeExperience,
    );
  }

  @override
  List<Object?> get props => [
        dateEnd,
        dateStart,
        enabledFlag,
        experienceId,
        experiencesDescription,
        experiencesPosition,
        experiencesTitle,
        file,
        leagueName,
        partyId,
        privacity,
        team,
        teamCategory,
        tournament,
        typeExperience,
      ];
}

class File extends Equatable {
  final String approveResource;
  final int auxId;
  final String document;
  final int fileId;
  final String fileName;
  final String fileType;
  final String mimetype;

  const File({
    required this.approveResource,
    required this.auxId,
    required this.document,
    required this.fileId,
    required this.fileName,
    required this.fileType,
    required this.mimetype,
  });

  Map<String, dynamic> toJson() {
    return {
      'approveResource': approveResource,
      'auxId': auxId,
      'document': document,
      'fileId': fileId,
      'fileName': fileName,
      'fileType': fileType,
      'mimetype': mimetype,
    };
  }

  static const empty = File(
      approveResource: '',
      auxId: 0,
      document: '',
      fileId: 0,
      fileName: '',
      fileType: '',
      mimetype: '');

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      approveResource: json['approveResource'] ?? '',
      auxId: json['auxId'] ?? 0,
      document: json['document'] ?? '',
      fileId: json['fileId'] ?? 0,
      fileName: json['fileName'] ?? '',
      fileType: json['fileType'] ?? '',
      mimetype: json['mimetype'] ?? '',
    );
  }

  File copyWith({
    String? approveResource,
    int? auxId,
    String? document,
    int? fileId,
    String? fileName,
    String? fileType,
    String? mimetype,
  }) {
    return File(
      approveResource: approveResource ?? this.approveResource,
      auxId: auxId ?? this.auxId,
      document: document ?? this.document,
      fileId: fileId ?? this.fileId,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      mimetype: mimetype ?? this.mimetype,
    );
  }

  @override
  List<Object> get props => [
        approveResource,
        auxId,
        document,
        fileId,
        fileName,
        fileType,
        mimetype,
      ];

  @override
  String toString() {
    return 'File{approveResource: $approveResource, auxId: $auxId, document: $document, fileId: $fileId, fileName: $fileName, fileType: $fileType, mimetype: $mimetype}';
  }
}

import 'package:equatable/equatable.dart';

class RecomendationDto extends Equatable {
   const  RecomendationDto({
        required this.id,
        required this.recomemendedTo,
        required this.recommendationStatus,
        required this.recommended,
        required this.recommendedBy,
        required this.recommendedById,
        required this.recommendedId,
        required this.recommendedToId,
        required this.typeOfRecomendation,
    });

    final int? id;
    final String? recomemendedTo;
    final String? recommendationStatus;
    final String? recommended;
    final String? recommendedBy;
    final int? recommendedById;
    final int? recommendedId;
    final int? recommendedToId;
    final String? typeOfRecomendation;

    RecomendationDto copyWith({
        int? id,
        String? recomemendedTo,
        String? recommendationStatus,
        String? recommended,
        String? recommendedBy,
        int? recommendedById,
        int? recommendedId,
        int? recommendedToId,
        String? typeOfRecomendation,
    }) {
        return RecomendationDto(
            id: id ?? this.id,
            recomemendedTo: recomemendedTo ?? this.recomemendedTo,
            recommendationStatus: recommendationStatus ?? this.recommendationStatus,
            recommended: recommended ?? this.recommended,
            recommendedBy: recommendedBy ?? this.recommendedBy,
            recommendedById: recommendedById ?? this.recommendedById,
            recommendedId: recommendedId ?? this.recommendedId,
            recommendedToId: recommendedToId ?? this.recommendedToId,
            typeOfRecomendation: typeOfRecomendation ?? this.typeOfRecomendation,
        );
    }

    factory RecomendationDto.fromJson(Map<String, dynamic> json){ 
        return RecomendationDto(
            id: json["id"],
            recomemendedTo: json["recomemended_To"],
            recommendationStatus: json["recommendation_Status"],
            recommended: json["recommended"],
            recommendedBy: json["recommended_By"],
            recommendedById: json["recommended_By_Id"],
            recommendedId: json["recommended_Id"],
            recommendedToId: json["recommended_To_Id"],
            typeOfRecomendation: json["type_Of_Recomendation"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "recomemended_To": recomemendedTo,
        "recommendation_Status": recommendationStatus,
        "recommended": recommended,
        "recommended_By": recommendedBy,
        "recommended_By_Id": recommendedById,
        "recommended_Id": recommendedId,
        "recommended_To_Id": recommendedToId,
        "type_Of_Recomendation": typeOfRecomendation,
    };

    @override
    String toString(){
        return "$id, $recomemendedTo, $recommendationStatus, $recommended, $recommendedBy, $recommendedById, $recommendedId, $recommendedToId, $typeOfRecomendation, ";
    }

    @override
    List<Object?> get props => [
    id, recomemendedTo, recommendationStatus, recommended, recommendedBy, recommendedById, recommendedId, recommendedToId, typeOfRecomendation, ];
}

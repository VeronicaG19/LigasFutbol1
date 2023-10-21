import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/converters/string_datetime_converter.dart';

part 'user_post.freezed.dart';
part 'user_post.g.dart';

@freezed
class UserPost with _$UserPost {
  const factory UserPost({
    @Default(0) final int categoryId,
    @Default('') final String categoryName,
    @Default('') final String description,
    @StringDateTimeConverter() final DateTime? expirationDate,
    @Default(0) final int madeById,
    @Default('') final String name,
    @Default(0) final int postId,
    @Default('') final String postType,
    @Default('') final String statusPost,
    @Default('') final String title,
    @Default(0) final int publicationMadeById,
  }) = _UserPost;

  const UserPost._();

  factory UserPost.fromJson(Map<String, dynamic> json) =>
      _$UserPostFromJson(json);

  static const empty = UserPost();

  bool get isEmpty => this == empty;

  bool get isNotEmpty => this != empty;
}

import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/user_post/entity/user_post.dart';

import '../../../core/endpoints.dart';
import 'i_user_post_repository.dart';

@LazySingleton(as: IUserPostRepository)
class UserPostRepositoryImpl implements IUserPostRepository {
  final ApiClient _apiClient;

  UserPostRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<String> createNewPost(UserPost post) =>
      _apiClient.postData(
          endpoint: userPostEndpoint,
          data: post.toJson(),
          converter: (response) => response['result'].toString());

  @override
  RepositoryResponse<List<UserPost>> getPostsByTournament(int tournamentId,
          {bool requiresAuthToken = true}) =>
      _apiClient.fetchCollectionData(
          requiresAuthToken: requiresAuthToken,
          endpoint: '$getUserPostByTournamentEndpoint/$tournamentId',
          converter: UserPost.fromJson);

  @override
  RepositoryResponse<String> deleteNewPost(int postId) => _apiClient.deleteData(
      endpoint: '$deleteUserPostEndpoint/$postId',
      converter: (response) => response['result'].toString());

  @override
  RepositoryResponse<String> editNewPost(UserPost post) =>
      _apiClient.updateData(
          endpoint: userPostEndpoint,
          data: post.toJson(),
          converter: (response) => response['result'].toString());

  @override
  RepositoryResponse<List<UserPost>> getPostByAuthorAndType(
          {required int authorId, required String type}) =>
      _apiClient.fetchCollectionData(
          endpoint: '$getUserPostByAuthorAndTypeEndpoint/$authorId/$type',
          converter: UserPost.fromJson);

  @override
  RepositoryResponse<UserPost> getPostById(int postId) => _apiClient.fetchData(
      endpoint: '$getUserPostByPostIdEndpoint/$postId',
      converter: UserPost.fromJson);
}

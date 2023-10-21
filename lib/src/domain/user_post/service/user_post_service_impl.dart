import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/user_post/entity/user_post.dart';

import '../repository/i_user_post_repository.dart';
import 'i_user_post_service.dart';

@LazySingleton(as: IUserPostService)
class UserPostServiceImpl implements IUserPostService {
  final IUserPostRepository _repository;

  UserPostServiceImpl(this._repository);

  @override
  RepositoryResponse<String> createNewPost(UserPost post) =>
      _repository.createNewPost(post);

  @override
  Future<List<UserPost>> getPostsByTournament(int tournamentId,
          {bool requiresAuthToken = true}) =>
      _repository
          .getPostsByTournament(tournamentId,
              requiresAuthToken: requiresAuthToken)
          .then((value) => value.fold((l) => [], (r) => r));

  @override
  RepositoryResponse<String> deleteNewPost(int postId) =>
      _repository.deleteNewPost(postId);

  @override
  RepositoryResponse<String> editNewPost(UserPost post) =>
      _repository.editNewPost(post);

  @override
  Future<List<UserPost>> getPostByAuthorAndType(
          {required int authorId, required String type}) =>
      _repository
          .getPostByAuthorAndType(authorId: authorId, type: type)
          .then((value) => value.fold((l) => [], (r) => r));

  @override
  RepositoryResponse<UserPost> getPostById(int postId) =>
      _repository.getPostById(postId);
}

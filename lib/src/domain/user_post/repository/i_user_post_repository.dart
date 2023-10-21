import '../../../core/typedefs.dart';
import '../entity/user_post.dart';

abstract class IUserPostRepository {
  RepositoryResponse<String> createNewPost(final UserPost post);
  RepositoryResponse<String> editNewPost(final UserPost post);
  RepositoryResponse<String> deleteNewPost(final int postId);
  RepositoryResponse<List<UserPost>> getPostsByTournament(
      final int tournamentId,
      {final bool requiresAuthToken = true});
  RepositoryResponse<UserPost> getPostById(final int postId);
  RepositoryResponse<List<UserPost>> getPostByAuthorAndType(
      {required final int authorId, required final String type});
}

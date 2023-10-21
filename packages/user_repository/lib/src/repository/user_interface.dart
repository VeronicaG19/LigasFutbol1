import '../models/person.dart';
import '../models/user.dart';
import '../typedef.dart';

abstract class UserInterface {
  RepoResponse<User> getUserDataByUserName({String? userName});
  RepoResponse<Person> getPersonDataByPersonId(int personId,
      {bool requiresAuthToken = true});
  RepoResponse<Person> getPersonDataByUserName(String userName);
  RepoResponse<User> changeEmail(String email, User user, bool isChangingUser);
  RepoResponse<User> changePhone(String phone, User user, bool isChangingUser);
  RepoResponse<User> changePersonName(
      String firstName, String lastName, User user);
  RepoResponse<User> changePassword(String password, User user);
  RepoResponse<User> changeUserName(String userName, User user);
  RepoResponse<User> updatePersonData(User user);
  Future<String> getPassword();
  User get getUser;
}

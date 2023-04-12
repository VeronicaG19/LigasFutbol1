import 'package:flutter/widgets.dart';
import 'package:user_repository/user_repository.dart';

import '../../app/view/loading_screen.dart';
import '../../field_owner/main_page/field_owner_main_page.dart';
import '../../league_manager/main_page/league_manager_main_page.dart';
import '../../player/main_page/player_main_page.dart';
import '../../referee/main_page/referee_main_page.dart';
import '../../representative/main_page/representative_main_page.dart';
import '../../super_admin/main_page/super_admin_main_page.dart';

List<Page> onGenerateRolViewPages(
    ApplicationRol rol, List<Page<dynamic>> pages) {
  switch (rol) {
    case ApplicationRol.player:
      return [PlayerMainPage.page()];
    case ApplicationRol.referee:
      return [RefereeMainPage.page()];
    case ApplicationRol.leagueManager:
      return [LeagueManagerMainPage.page()];
    case ApplicationRol.teamManager:
      return [RepresentativeMainPage.page()];
    case ApplicationRol.superAdmin:
      return [SuperAdminMainPage.page()];
    case ApplicationRol.fieldOwner:
      return [FieldOwnerMainPage.page()];
    default:
      return [LoadingScreen.page()];
  }
}

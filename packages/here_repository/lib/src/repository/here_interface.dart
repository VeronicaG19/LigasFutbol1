
import '../models/apihere_response_addresess.dart';
import '../models/reverse_geo_api_here.dart';
import '../typedef.dart';

abstract class IApiHereInterface {
 /// Get all addres search
 //
  /// * @param [address]
  HereRepoResponse<ApiHereResponseAddresses> getAddresssesWithText(String address);

  HereRepoResponse<ReverseHeoApiHere> getReverseGeoAddres(String latLengt);
}
class Endpoints {
  static late String _baseURL;
  static late String _appNameGlobal;

  static void init(String baseUrl, String appName) {
    _baseURL = baseUrl;
    _appNameGlobal = appName;
  }

///
/// Get a list of addres
///
///* @param [apiKey, searchtext]
/// https://geocoder.ls.hereapi.com
///METHOD GET
static String get getApiHereSearchData => '$_baseURL/6.2/geocode.json';

///
/// Get a addres based on a lat and length
///
///* @param [apiKey, lat and length ]
/// https://revgeocode.search.hereapi.com/
///METHOD GET
static String get getReverseGeo => 'https://revgeocode.search.hereapi.com/v1/revgeocode';
}

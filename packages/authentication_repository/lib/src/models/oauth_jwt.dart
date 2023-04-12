// import 'package:equatable/equatable.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
//
// /// {@template authentication_repository}
// /// Entity for OauthJWT.
// /// {@endtemplate}
// class OauthJWT extends Equatable {
//   /// Default constructor
//   const OauthJWT({
//     required this.accessToken,
//     // required this.username,
//     // required this.userId,
//     // required this.password,
//     required this.tokenDuration,
//     this.authenticationDate,
//   });
//
//   /// Convert a JSON object into a [OauthJWT] Entity.
//   factory OauthJWT.fromJson(Map<String, dynamic> json) {
//     final date = json['authentication_date']?.toString();
//     final DateTime? dateTime = date != null ? DateTime.parse(date) : null;
//     return OauthJWT(
//       accessToken: json['access_token'].toString(),
//       // userId: json['userId'] ?? 0,
//       // username: json['username'].toString(),
//       // password: json['password'].toString(),
//       tokenDuration: json['expires_in'] as int,
//       authenticationDate: dateTime,
//     );
//   }
//
//   /// The access token.
//   final String accessToken;
//
//   /*/// THe user name.
//   final String username;
//
//   /// The user password.
//   final String password;*/
//
//   /// Token duration.
//   final int tokenDuration;
//
//   /// Authentication date
//   final DateTime? authenticationDate;
//
//   /// Constructor to copy a property with the same object.
//   OauthJWT copyWith({
//     // int? userId,
//     // String? username,
//     // String? password,
//     // String? accessToken,
//     int? tokenDuration,
//     DateTime? authenticationDate,
//   }) {
//     return OauthJWT(
//       // userId: userId ?? this.userId,
//       // username: username ?? this.username,
//       // password: password ?? this.password,
//       // accessToken: accessToken ?? this.accessToken,
//       tokenDuration: tokenDuration ?? this.tokenDuration,
//       authenticationDate: authenticationDate ?? this.authenticationDate,
//     );
//   }
//
//   /// Empty OauthJWT which represents an unauthenticated user.
//   static const empty = OauthJWT(
//     // accessToken: '',
//     // username: '',
//     // password: '',
//     tokenDuration: 0,
//   );
//
//   /// Convenience getter to determine whether the current OauthJWT is empty.
//   bool get isEmpty => this == OauthJWT.empty;
//
//   /// Convenience getter to determine whether the current OauthJWT is not empty.
//   bool get isNotEmpty => this != OauthJWT.empty;
//
//   @override
//   List<Object?> get props => [authenticationDate, tokenDuration];
//
//   /// Convert a [OauthJWT] entity to JSON object.
//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'expires_in': tokenDuration,
//       'authentication_date': authenticationDate.toString(),
//     };
//   }
//
//   /*/// Return the user name from the token.
//   String getUserName() {
//     final decodedToken = JwtDecoder.decode(accessToken);
//     final userName = decodedToken['user_name']?.toString() ?? '';
//     return userName;
//   }*/
//
//   /// Validates the token expiration date.
//   bool validateToken(String accessToken) {
//     final hasExpired = !JwtDecoder.isExpired(accessToken);
//     final validateDate = _getExpirationDateByTime().isAfter(DateTime.now());
//     return hasExpired || validateDate;
//   }
//
//   /// Return token expiration date.
//   DateTime _getExpirationDate(String accessToken) =>
//       JwtDecoder.getExpirationDate(accessToken);
//
//   /// Returns the expiration date from the token duration.
//   DateTime _getExpirationDateByTime() {
//     if (authenticationDate != null) {
//       return authenticationDate!.add(Duration(seconds: tokenDuration));
//     } else {
//       return DateTime.now();
//     }
//   }
// }

import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthConstant {
  static const accountExistsWithDifferentCredentials =
      'account-exists-with-different-credential';
  static const googleCom = 'google.com';
  static const emailScope = 'email';
  const AuthConstant._();
}

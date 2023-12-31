import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/auth/models/auth_result.dart';
import 'package:instagram_clone/state/post/typedefs/user_id.dart';

// auth state model for different auth scenario
@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;

  const AuthState(
      {required this.result, required this.isLoading, required this.userId});
  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;
  AuthState copyWithLoading(bool loading) =>
      AuthState(result: result, isLoading: loading, userId: userId);

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) &&
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(result, isLoading, userId);
}

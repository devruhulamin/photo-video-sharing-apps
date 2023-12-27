import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/backend/authenticator.dart';
import 'package:instagram_clone/state/auth/models/auth_result.dart';
import 'package:instagram_clone/state/auth/models/auth_state.dart';
import 'package:instagram_clone/state/post/typedefs/user_id.dart';
import 'package:instagram_clone/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.userId != null) {
      state = AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: _authenticator.userId);
    }
  }
  Future<void> logout() async {
    state = state.copyWithLoading(true);
    await _authenticator.logout();
    state = const AuthState.unknown();
    state = state.copyWithLoading(false);
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWithLoading(true);

    final result = await _authenticator.googleLogin();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      saveUserInfo(userId: userId);
      state = AuthState(result: result, isLoading: false, userId: userId);
    }
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWithLoading(true);

    final result = await _authenticator.facebookLogin();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      saveUserInfo(userId: userId);
      state = AuthState(result: result, isLoading: false, userId: userId);
    }
  }

  Future<void> saveUserInfo({required UserId userId}) =>
      _userInfoStorage.saveUserInfo(
          userId: userId,
          email: _authenticator.userEmail,
          displayName: _authenticator.displayName);
}

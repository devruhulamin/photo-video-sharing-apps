import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/main.dart';
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
    // state = state.copyWithLoading(false);
  }

  // singup with email and password
  // login with email and password and linking account
  Future<void> signUpWithEmailPassword(
      {required String email, required String password}) async {
    state = state.copyWithLoading(true);

    final result = await _authenticator.signUpWithEmailPassword(
      email: email,
      password: password,
    );

    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      saveUserInfo(userId: userId);
      state = AuthState(result: result, isLoading: false, userId: userId);
      'auth state updated'.log();
    } else {
      state = const AuthState.unknown();
    }
  }

  // login with email and password and linking account
  Future<void> loginWithEmailPassword(
      {required String email, required String password}) async {
    state = state.copyWithLoading(true);

    final result = await _authenticator.loginWithEmailPassword(
      email: email,
      password: password,
    );

    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      saveUserInfo(userId: userId);
      state = AuthState(result: result, isLoading: false, userId: userId);
    } else {
      state = const AuthState.unknown();
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWithLoading(true);

    final result = await _authenticator.googleLogin();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      saveUserInfo(userId: userId);
      state = AuthState(result: result, isLoading: false, userId: userId);
    } else {
      state = const AuthState.unknown();
    }
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWithLoading(true);

    final result = await _authenticator.facebookLogin();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      saveUserInfo(userId: userId);
      state = AuthState(result: result, isLoading: false, userId: userId);
    } else {
      state = const AuthState.unknown();
    }
  }

  Future<void> saveUserInfo({required UserId userId}) =>
      _userInfoStorage.saveUserInfo(
          userId: userId,
          email: _authenticator.userEmail,
          displayName: _authenticator.displayName);
}

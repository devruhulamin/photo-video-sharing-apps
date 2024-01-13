import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone/state/auth/constant/constant.dart';
import 'package:instagram_clone/state/auth/models/auth_result.dart';

class Authenticator {
  const Authenticator();
  User? get currentUser => FirebaseAuth.instance.currentUser;
  String? get userId => currentUser?.uid;
  String get displayName => currentUser?.displayName ?? '';
  String get userEmail => currentUser?.email ?? '';
  bool get isAlreadyLogin => userId != null;

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  Future<AuthResult> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credentials = e.credential;
      if (e.code == AuthConstant.accountExistsWithDifferentCredentials &&
          email != null &&
          credentials != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (providers.contains(AuthConstant.googleCom)) {
          await googleLogin();
          await FirebaseAuth.instance.currentUser
              ?.linkWithCredential(credentials);
          return AuthResult.success;
        }
      }
    }
    return AuthResult.failure;
  }

  Future<AuthResult> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credentials = e.credential;
      if (e.code == AuthConstant.accountExistsWithDifferentCredentials &&
          email != null &&
          credentials != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (providers.contains(AuthConstant.googleCom)) {
          await googleLogin();
          await FirebaseAuth.instance.currentUser
              ?.linkWithCredential(credentials);
          return AuthResult.success;
        }
      }
    }
    return AuthResult.failure;
  }

  Future<AuthResult> facebookLogin() async {
    final result = await FacebookAuth.instance.login();

    final accessToken = result.accessToken?.token;
    if (accessToken == null) {
      return AuthResult.aborted;
    }
    final oauthCredntial = FacebookAuthProvider.credential(accessToken);
    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredntial);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;

      if (e.code == AuthConstant.accountExistsWithDifferentCredentials &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (providers.contains(AuthConstant.googleCom)) {
          await googleLogin();

          await FirebaseAuth.instance.currentUser
              ?.linkWithCredential(credential);
          return AuthResult.success;
        }
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> googleLogin() async {
    final googleSignIn = GoogleSignIn(scopes: [AuthConstant.emailScope]);

    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;

    final oauthCredentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}

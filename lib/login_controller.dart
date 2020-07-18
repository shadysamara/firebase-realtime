import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  Auth._();
  static final Auth auth = Auth._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FacebookLogin facebookLogin = FacebookLogin();

  Future<String> signinWithGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential authCredential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      AuthResult authResult =
          await firebaseAuth.signInWithCredential(authCredential);
      FirebaseUser firebaseUser = authResult.user;
      return '${firebaseUser.isAnonymous}';
    } catch (error) {
      print(error.toString());
    }
  }

  Future<bool> signOutUser() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    return firebaseUser != null;
  }

  createUserUsingEmailAndPassword() async {}
  signInUsingEailAndPassword() async {}

  Future<String> loginUsingFacebook() async {
    final facebookLogin = FacebookLogin();
    FacebookLoginResult result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        AuthCredential authCredential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        AuthResult authResult =
            await FirebaseAuth.instance.signInWithCredential(authCredential);

        FirebaseUser firebaseUser = authResult.user;
        return firebaseUser.displayName;
        break;
      case FacebookLoginStatus.cancelledByUser:
        return 'cancled';
        break;
      case FacebookLoginStatus.error:
        return 'error ${result.errorMessage}';
        break;
    }
  }
}

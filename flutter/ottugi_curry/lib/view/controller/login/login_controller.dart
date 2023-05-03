import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController {

  Future loginGoogle() async {
    // final googleUser = await GoogleSignIn().signIn();
    GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: '533961426623-17qecigrqom78pqt8ts3p5kccjb1d6ns.apps.googleusercontent.com',
    );
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      print(googleSignInAccount);
    }


  }
}
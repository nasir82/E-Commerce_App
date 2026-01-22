import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_e_commerce_app/data/repositories/user/user_repository.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/login.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/onboarding.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/verify_email.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/user_controller.dart';
import 'package:flutter_e_commerce_app/navigation/navigaton_menu.dart';
import 'package:flutter_e_commerce_app/utils/exceptions/exceptions.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:flutter_e_commerce_app/utils/local_storage/local_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  User? authUser = FirebaseAuth.instance.currentUser;
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // function to show relevant screens
  Future<void> screenRedirect() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        await LocalStorageHelper.init(user.uid);
        Get.put(UserController());
        UserController.instance.fetchUserRecord();
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreem(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      // Local storage
      deviceStorage.writeIfNull("isFirstTime", true);
      deviceStorage.read("isFirstTime") != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  Future<UserCredential> registerWithEmailandPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Loaders.warnigSnackbar(title: "Something went wrong: $e}");
      rethrow;
    }
  }


  Future<UserCredential> logInWithEmailAndPassword(
      String email, String password) async {
    try {

      final userCred = _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCred;
      
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw "Can't log in  try again later";
    }
  }

  Future<void> sendEmailVerificaton() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw "undone";
    }
  }

  Future<void> logOut() async {
    try {
      //await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(const LoginScreen());
    } on FirebaseAuthException catch (e) {
      FirebaseExceptionsCustom(e.code).message;
    } on FirebaseException catch (e) {
      FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  // Future<UserCredential?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication? googleAuth =
  //         await userAccount?.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
  //     return _auth.signInWithCredential(credential);
  //   } on FirebaseAuthException catch (e) {
  //     throw FirebaseExceptionsCustom(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw FirebaseExceptionsCustom(e.code).message;
  //   } catch (e) {
     
  //     return null;
  //   }
  // }
  //forgot password
   Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw "undone";
    }
  }
  Future<void> reauthenticateWithEmailAndPassword(String email,String password)async{

    try {

      // email auth provider provide creadential via email and password
      
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      await _auth.currentUser!.reauthenticateWithCredential(credential);

    }on FirebaseAuthException catch(e){
      throw FirebaseExceptionsCustom(e.code).message;
    }on FirebaseException catch(e){
      throw FirebaseExceptionsCustom(e.code).message;
    }
    
     catch (e) {
      throw "Something went wrong";
    }
  }

  Future<void> deleteAccount() async{
   try {
     await UserRepository.instance.removeUserInfo(_auth.currentUser!.uid);
     await _auth.currentUser?.delete();

    }on FirebaseAuthException catch(e){
      throw FirebaseExceptionsCustom(e.code).message;
    }on FirebaseException catch(e){
      throw FirebaseExceptionsCustom(e.code).message;
    }
    
     catch (e) {
      throw "Something went wrong";
    }
  }
}


/**
 * works in authentication repository
 * 
 * SignIn
 * SignUp
 * email verification
 * password reset
 * re authenticate
 * delete account with user infor
 * create account with social media
 * 
 */

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/app.dart';
import 'package:flutter_e_commerce_app/features/authentications/data/repository/authentication_repository.dart';
import 'package:flutter_e_commerce_app/firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async{
  final binding = WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    /**  
     * here the firebase initialization complete and then our authentication repository is 
     * ensure initialization as it is needed to check wheter signIn or not.
    */
    (value)=> Get.put(AuthenticationRepository())
  );
  runApp(const MainApp());
}


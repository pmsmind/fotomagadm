import 'package:flutter/material.dart';
import 'package:fotomag3/screens/auth.dart';
import 'package:fotomag3/screens/landing.dart';
import 'package:fotomag3/services/auth.dart';
import 'package:provider/provider.dart';
import 'domain/workout.dart';
import 'screens/Home.dart';
import 'screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fotomag3/domain/user.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var aw = StreamProvider<CustomUser?>.value(
    value: AuthService().currentUser,
    initialData: null
  );
  runApp(FotomagApp());
}

class FotomagApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Фотомагазин',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(124, 174, 246, 1.0),
          textTheme: TextTheme(title: TextStyle(color: Colors.white))
      ),
      home: LandingPage()

    );

  }

}


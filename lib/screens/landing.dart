import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fotomag3/domain/user.dart';
import 'package:fotomag3/screens/Home.dart';
import 'package:fotomag3/screens/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatelessWidget{
 const LandingPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomUser? user = Provider.of<CustomUser>(context);
    final bool isLoggedIn = user != null;


    return isLoggedIn ? HomePage() : AuthorizationPage();
  }

}
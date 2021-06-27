import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomUser {
  late String id;

  CustomUser.fromFirebase(User user){
    id = user.uid;
  }

}
import 'dart:js';

import 'package:DevQuiz/home/home_page.dart';
import 'package:flutter/material.dart';
import '../core/app_gradients.dart';
import "../core/app_images.dart";

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.linear,
          ),
          child: Center(
            child: Image.asset(AppImages.logo),
          ),
      ),
    );
  }
}
import 'package:fitness_app_hello_world/app/data/AIFoodSuggestionsPage.dart';
import 'package:fitness_app_hello_world/app/data/goals.dart';
import 'package:fitness_app_hello_world/app/data/weighttracking.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Goals()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;


    double imageHeight = screenHeight * 0.70;




    return Scaffold(
      body: Column(
        children: [
          Container(
            height: imageHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            "Gdsc",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Fitness",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "There is no instant way to a healthy life",
            style: TextStyle(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: CustomProgressBar(),
          ),
          SizedBox(height: 40),
           Text(
              "Get Started",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            
         
            
         
        ],
      ),
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 116.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: LinearProgressIndicator(
          minHeight: 6.0,
          value: 0.25,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreenAccent),
          backgroundColor: Color(0xFF1E2227),
        ),
      ),
    );
  }
}



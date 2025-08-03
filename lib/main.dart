import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app_hello_world/app/data/AIFoodSuggestionsPage.dart';
import 'package:fitness_app_hello_world/app/data/dahsboard.dart';
import 'package:fitness_app_hello_world/app/data/goals.dart';
import 'package:fitness_app_hello_world/app/data/login.dart';
import 'package:fitness_app_hello_world/app/data/onboarding.dart';

import 'package:fitness_app_hello_world/app/data/signup.dart';
import 'package:fitness_app_hello_world/app/data/weighttracking.dart';
import 'package:fitness_app_hello_world/app/firebase/firebase_options.dart';
import 'package:fitness_app_hello_world/app/firebase/firebaseapi.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      navigatorKey: navigatorKey, 
     
      home: AuthenticationWrapper(),
    
       
      routes: {
        '/onboarding': (context) => const Onboarding(),
        '/signup': (context) => SignupPage(),

        '/dashboard': (context) => DashboardPage(
              targetWeight: '70',
              targetCalories: '2000',
        ),
        '/goals': (context) => Goals(),
        '/weighttracking': (context) => WeightTrackingPage(),
        '/Food suggestions': (context) => FoodSuggestionScreen(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseApi firebaseApi = FirebaseApi();

  @override
  void initState() {
    super.initState();
    firebaseApi.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Text('Welcome to Home Page'),
      ),
    );
  }
}
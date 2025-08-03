import 'package:flutter/material.dart';
import 'package:fitness_app_hello_world/app/data/weighttracking.dart';
import 'package:fitness_app_hello_world/app/data/AIFoodSuggestionsPage.dart'; 

class DashboardPage extends StatefulWidget {
  final String targetWeight;
  final String targetCalories;

  DashboardPage({required this.targetWeight, required this.targetCalories});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController stepsController = TextEditingController();
  String caloriesBurned = "0";

  void calculateCaloriesBurned() {
    final int steps = int.tryParse(stepsController.text) ?? 0;
    final double burned = steps * 0.02;
    setState(() {
      caloriesBurned = burned.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFBBF246),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                backgroundColor: Colors.grey,
              ),
              SizedBox(height: 20),
              DashboardBlock(
                title: 'Target Weight',
                value: widget.targetWeight,
              ),
              SizedBox(height: 10),
              DashboardBlock(
                title: 'Target Calories',
                value: widget.targetCalories,
              ),
              SizedBox(height: 10),
              TextField(
                controller: stepsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter number of steps",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (value) {
                  calculateCaloriesBurned();
                },
              ),
              SizedBox(height: 20),
              DashboardBlock(
                title: 'Calories Burned',
                value: caloriesBurned,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FoodSuggestionScreen()),
                  );
                },
                child: Text(
                  "AI",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WeightTrackingPage()),
                  );
                },
                child: Text("Weight Tracking", style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardBlock extends StatelessWidget {
  final String title;
  final String value;

  DashboardBlock({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFBBF246),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

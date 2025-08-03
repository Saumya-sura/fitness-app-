import 'package:fitness_app_hello_world/app/data/dahsboard.dart';
import 'package:flutter/material.dart';


class WeightTrackingPage extends StatefulWidget {
  @override
  _WeightTrackingPageState createState() => _WeightTrackingPageState();
}

class _WeightTrackingPageState extends State<WeightTrackingPage> {
  Map<String, double> weightEntries = {
    "Day 1": 72.0,
    "Day 2": 71.5,
    "Day 3": 71.0,
  };

  TextEditingController _weightController = TextEditingController();

  void _addWeightEntry(String day) {
    if (_weightController.text.isNotEmpty) {
      setState(() {
        weightEntries[day] = double.parse(_weightController.text);
      });
      _weightController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Tracker'),
        backgroundColor: Color(0xFFBBF246),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Track Your Weight',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              for (String day in weightEntries.keys)
                Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(day, style: Theme.of(context).textTheme.bodyMedium),
                    subtitle: Text('${weightEntries[day]} kg',
                        style: TextStyle(fontSize: 18)),
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Color(0xFFBBF246)),
                      onPressed: () {
                        _weightController.text = weightEntries[day].toString();
                        _addWeightEntry(day);
                      },
                    ),
                  ),
                ),
              SizedBox(height: 20),
              TextField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: 'Enter Weight (kg)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _addWeightEntry("Day ${weightEntries.length + 1}");
                },
                child: Text('Add Weight Entry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFBBF246),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashboardPage(
                              targetWeight: "75", 
                              targetCalories: "2000", 
                            )),
                  );
                },
                child: Text('Back to Dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 38, 35, 35),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart'; // Import the flutter_markdown package
import 'package:google_generative_ai/google_generative_ai.dart';

class FoodSuggestionScreen extends StatefulWidget {
  @override
  _FoodSuggestionScreenState createState() => _FoodSuggestionScreenState();
}

class _FoodSuggestionScreenState extends State<FoodSuggestionScreen> {
  List<String> suggestions = [];
  bool isLoading = false;
  String errorMessage = '';
  final TextEditingController _inputController = TextEditingController();

  Future<void> _fetchSuggestions(String userInput) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: "AIzaSyA8qb9l4xljwQ49nzITCz3qRIb3SKnBEYU", 
      );

      final prompt = 'I have these ingredients: $userInput. Give me healthy recipes.';

      final response = await model.generateContent([Content.text(prompt)]);
      final responseBody = response.text ?? '';

      print('Response: $responseBody'); 

      if (responseBody.isNotEmpty) {
        final suggestionsList = responseBody.split('\n').where((s) => s.isNotEmpty).toList();
        setState(() {
          suggestions = suggestionsList;
          isLoading = false;
        });
      } else {
        setState(() {
          suggestions = [];
          isLoading = false;
          errorMessage = 'No suggestions available.';
        });
      }
    } catch (e) {
      print('Failed to load suggestions: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load suggestions. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Suggestions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: 'Enter ingredients (e.g., spicy, chicken, low-carb)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final userInput = _inputController.text;
                if (userInput.isNotEmpty) {
                  _fetchSuggestions(userInput);
                }
              },
              child: Text('Get Suggestions'),
            ),
            SizedBox(height: 10),
            Flexible(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                      ? Center(child: Text(errorMessage))
                      : suggestions.isEmpty
                          ? Center(child: Text('No suggestions available'))
                          : ListView.builder(
                              itemCount: suggestions.length,
                              itemBuilder: (context, index) {
                                return MarkdownBody( // Use MarkdownBody to render Markdown formatted text
                                  data: suggestions[index],
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }
}

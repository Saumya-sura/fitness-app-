from flask import Flask, request, jsonify
import requests

app = Flask(_name_)

# Spoonacular API key
SPOONACULAR_API_KEY = 'd897286e63f186bdf4e97bfa5005ae279289416c'

# Function to call Spoonacular API and get recipes based on query
def get_recipes(ingredients, dietary_restrictions, cuisine, meal_type):
    url = f"https://api.spoonacular.com/recipes/complexSearch"
    params = {
        'apiKey': SPOONACULAR_API_KEY,
        'includeIngredients': ingredients,
        'diet': dietary_restrictions,
        'cuisine': cuisine,
        'type': meal_type,
        'number': 5  # Number of recipes to return
    }
    response = requests.get(url, params=params)
    return response.json()

# Basic NLP to extract key information from user input
def parse_user_input(user_input):
    # This is a very basic example. You can expand this with a more robust NLP solution.
    ingredients = []
    dietary_restrictions = ""
    cuisine = ""
    meal_type = ""

    # Example phrases to extract ingredients, dietary restrictions, etc.
    if "spicy" in user_input.lower():
        ingredients.append("spicy")
    if "chicken" in user_input.lower():
        ingredients.append("chicken")
    if "low-carb" in user_input.lower() or "keto" in user_input.lower():
        dietary_restrictions = "ketogenic"
    if "vegan" in user_input.lower():
        dietary_restrictions = "vegan"
    if "breakfast" in user_input.lower():
        meal_type = "breakfast"
    if "dinner" in user_input.lower():
        meal_type = "dinner"

    # Converting list to a comma-separated string for API use
    ingredients_str = ','.join(ingredients)

    return ingredients_str, dietary_restrictions, cuisine, meal_type

@app.route('/suggest', methods=['POST'])
def suggest_food():
    user_input = request.json.get('user_input')
    ingredients, dietary_restrictions, cuisine, meal_type = parse_user_input(user_input)
    
    recipes = get_recipes(ingredients, dietary_restrictions, cuisine, meal_type)
    
    return jsonify(recipes)

if _name_ == '_main_':
    app.run(debug=True)
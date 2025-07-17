import 'package:serverpod/serverpod.dart';
import 'package:meta/meta.dart';
import '../generated/protocol.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

@visibleForTesting
var generateContent =
    (String apiKey, String prompt) async => (await GenerativeModel(
          model: 'gemini-1.5-flash-latest',
          apiKey: apiKey,
        ).generateContent(
          [Content.text(prompt)],
        ))
            .text;

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
class RecipesEndpoint extends Endpoint {
  @override
  bool requireLogin = true;

  Future<Recipe> generateRecipe(Session session, String ingredients) async {
    final geminiApiKey = session.passwords['gemini'];
    if (geminiApiKey == null) {
      throw Exception('Gemini API key not found');
    }
    final userId = (await session.authenticated)?.userId;
    final recipe = Recipe(
      author: 'author ',
      text: 'text',
      date: DateTime.now(),
      ingredients: ingredients,
      userId: userId,
    );

    // Save the recipe to the database, the returned recipe has the id set
    final recipeWithId = await Recipe.db.insertRow(session, recipe);
    return recipeWithId;
  }

  Future<List<Recipe>> getRecipes(Session session) async {
    final userId = (await session.authenticated)?.userId;
    return Recipe.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.deletedAt.equals(null),
      orderBy: (t) => t.date,
      orderDescending: true,
    );
  }

  Future<void> deleteRecipe(Session session, int recipeId) async {
    // Find the recipe in the database
    final userId = (await session.authenticated)?.userId;
    final recipe = await Recipe.db.findById(session, recipeId);
    if (recipe == null || recipe.userId != userId) {
      throw Exception('Recipe not found');
    }

    session.log('Deleting recipe with id: $recipeId');
    // Delete the recipe from the database
    recipe.deletedAt = DateTime.now();
    await Recipe.db.updateRow(session, recipe);
  }

//----------------------------------------------------------------------
  @visibleForTesting
  Future<Recipe> generateRecipe2(Session session, String ingredients) async {
    /// Generates a recipe using the Gemini API.
    ///
    /// The user will provide a free text input with the ingredients and the API
    /// will generate a recipe using the following prompt:
    ///
    /// 'Generate a recipe using the following ingredients: $ingredients, always put the title '
    /// 'of the recipe in the first line, and then the instructions. The recipe should be easy '
    /// 'to follow and include all necessary steps. Please provide a detailed recipe.'
    ///
    //
    final cacheKey = 'recipe-${ingredients.hashCode}';
    final cachedRecipe = await session.caches.local.get<Recipe>(cacheKey);
    if (cachedRecipe != null) {
      final userId = (await session.authenticated)?.userId;
      session.log('Recipe found in cache for ingredients: $ingredients');
      cachedRecipe.userId = userId;

      final recipeWithId = await Recipe.db
          .insertRow(session, cachedRecipe.copyWith(userId: userId));

      return recipeWithId;
    }

    final geminiApiKey = session.passwords['gemini'];

    if (geminiApiKey == null) {
      throw Exception('Gemini API key not found');
    }

    // A prompt to generate a recipe, the user will provide a free text input with the ingredients
    final prompt =
        'Generate a recipe using the following ingredients: $ingredients, always put the title '
        'of the recipe in the first line, and then the instructions. The recipe should be easy '
        'to follow and include all necessary steps. Please provide a detailed recipe.';

    final responseText = await generateContent(geminiApiKey, prompt);

    // Check if the response is empty or null
    if (responseText == null || responseText.isEmpty) {
      throw Exception('No response from Gemini API');
    }

    final recipe = Recipe(
      author: 'Gemini',
      text: responseText,
      date: DateTime.now(),
      ingredients: ingredients,
    );

    final recipeWithId = await Recipe.db.insertRow(session, recipe);

    return recipeWithId;
  }
}

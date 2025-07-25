import 'package:serverpod/serverpod.dart';
import 'package:meta/meta.dart';
import '../generated/protocol.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// magic_recipe_server/lib/src/recipes/receipes_endpoint.dart
@visibleForTesting
var generateContent =
    (String apiKey, List<Content> prompt) async => (await GenerativeModel(
          model: 'gemini-1.5-flash-latest',
          apiKey: apiKey,
        ).generateContent(
          prompt,
        ))
            .text;

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
class RecipesEndpoint extends Endpoint {
  @override
  bool requireLogin = true;

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
  Stream<Recipe> generateRecipe2(Session session, String ingredients,
      [String? imagePath]) async* {
    final geminiApiKey = session.passwords['gemini'];

    if (geminiApiKey == null) {
      throw Exception('Gemini API key not found');
    }

    final cacheKey = 'recipe-${ingredients.hashCode}-$imagePath';
    final cachedRecipe = await session.caches.local.get<Recipe>(cacheKey);

    if (cachedRecipe != null) {
      final userId = (await session.authenticated)?.userId;
      session.log('Recipe found in cache for ingredients: $ingredients');
      cachedRecipe.userId = userId;

      final recipeWithId = await Recipe.db
          .insertRow(session, cachedRecipe.copyWith(userId: userId));

      yield recipeWithId;
    }

    final List<Content> prompt = [];
    if (imagePath != null) {
      final imageData = await session.storage
          .retrieveFile(storageId: 'public', path: imagePath);

      if (imageData == null) {
        throw Exception('Image not found');
      }

      prompt.add(
        Content.data(
          'image/jpeg',
          imageData.buffer.asUint8List(),
        ),
      );
      prompt.add(Content.text('''
Generate a recipe using the detected ingeredients. Always put the title
of the recipe in the first line, and then the instructions. The recipe
should be easy to follow and include all necessary steps. Please provide
a detailed recipe. Only put the title in the first line, no markup.'''));
    }

    // A prompt to generate a recipe, the user will provide a free text input with the ingredients
    final textPrompt =
        'Generate a recipe using the following ingredients: $ingredients, always put the title '
        'of the recipe in the first line, and then the instructions. The recipe should be easy '
        'to follow and include all necessary steps. Please provide a detailed recipe.';

    if (prompt.isEmpty) {
      prompt.add(Content.text(textPrompt));
    }

    // final responseText = await generateContent(geminiApiKey, prompt);

    // Check if the response is empty or null
    // if (responseText == null || responseText.isEmpty) {
    //   throw Exception('No response from Gemini API');
    // }
    final userId = (await session.authenticated)?.userId;

    final recipe = Recipe(
        author: 'Gemini',
        text: 'responseText',
        date: DateTime.now(),
        ingredients: ingredients,
        imagePath: imagePath);

    await session.caches.local
        .put(cacheKey, recipe, lifetime: const Duration(days: 1));

    final recipeWithId =
        await Recipe.db.insertRow(session, recipe.copyWith(userId: userId));

    yield recipeWithId;
  }

  Future<(String? description, String path)> getUploadDescription(
      Session session, String filename) async {
    const Uuid uuid = Uuid();

    // Generate a unique path for the file
    // Using a uuid prevents collisions and enumeration attacks
    final path = 'uploads/${uuid.v4()}/$filename';

    final description = await session.storage.createDirectFileUploadDescription(
      storageId: 'public',
      path: path,
    );

    return (description, path);
  }

  Future<bool> verifyUpload(Session session, String path) async {
    return await session.storage.verifyDirectFileUpload(
      storageId: 'public',
      path: path,
    );
  }

  Future<String> getPublicUrlForPath(Session session, String path) async {
    final publicUrl =
        await session.storage.getPublicUrl(storageId: 'public', path: path);

    session.log('Public URL:\n$publicUrl');
    return publicUrl.toString();
  }
}

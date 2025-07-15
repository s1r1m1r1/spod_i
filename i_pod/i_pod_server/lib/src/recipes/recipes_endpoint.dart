import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

// This is an example endpoint of your server. It's best practice to use the
// `Endpoint` ending of the class name, but it will be removed when accessing
// the endpoint from the client. I.e., this endpoint can be accessed through
// `client.greeting` on the client side.

// After adding or modifying an endpoint, you will need to run
// `serverpod generate` to update the server and client code.

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
class RecipesEndpoint extends Endpoint {
  // This method is called when the client calls the `hello` method on the
  // `greeting` endpoint.
  //
  // The `Session` parameter contains the context of the client request.
  // It provides access to the database and other server-side resources like
  // secrets from your password file, the cache, storage, and server-event
  // messaging.

  Future<Recipe> generateRecipe(Session session, String ingredients) async {
    final geminiApiKey = session.passwords['gemini'];
    if (geminiApiKey == null) {
      throw Exception('Gemini API key not found');
    }
    final recipe = Recipe(
        author: 'author ',
        text: 'text',
        date: DateTime.now(),
        ingredients: ingredients);

    // Save the recipe to the database, the returned recipe has the id set
    final recipeWithId = await Recipe.db.insertRow(session, recipe);
    return recipeWithId;
  }

  Future<List<Recipe>> getRecipes(Session session) async {
    return Recipe.db.find(
      session,
      orderBy: (t) => t.date,
      orderDescending: true,
    );
  }
}

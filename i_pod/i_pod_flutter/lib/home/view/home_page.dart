import 'package:flutter/material.dart';
import 'package:i_pod_client/i_pod_client.dart';

import '../../admin/view/admin_page.dart';
import '../../login/view/login_page.dart';
import '../../main.dart';
import '../widgets/image_widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  /// Holds the last result or null if no result exists yet.
  Recipe? _recipe;

  final _recipeHistory = <Recipe>[];

  /// Holds the last error message that we've received from the server or null if no
  /// error exists yet.
  String? _errorMessage;
  String? _imagePath;

  final _textEditingController = TextEditingController();

  bool _loading = false;

  void _callGenerateRecipe() async {
    try {
      setState(() {
        _errorMessage = null;
        _recipe = null;
        _loading = true;
      });
      await for (final result in client.recipes
          .generateRecipe2(_textEditingController.text, _imagePath)) {
        setState(() {
          _errorMessage = null;
          _recipe = result;
        });
      }

      setState(() {
        _loading = false;
        if (_recipe != null) _recipeHistory.insert(0, _recipe!);
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
        _recipe = null;
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Get the favourite recipes from the database
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getRecipes();
  }

  void getRecipes() {
    client.recipes.getRecipes().then((List<Recipe> favouriteRecipes) {
      _recipeHistory.clear();
      _recipeHistory.addAll(favouriteRecipes);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          // Show nav button if we are admin
          if (sessionManager.signedInUser?.scopeNames
                  .contains('serverpod.admin') ??
              false)
            IconButton(
                icon: const Icon(Icons.admin_panel_settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminDashboard(),
                    ),
                  );
                })
          else
            Text('-----'),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await sessionManager.signOutDevice();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: ListView.builder(
                itemCount: _recipeHistory.length,
                itemBuilder: (context, index) {
                  final recipe = _recipeHistory[index];
                  return ListTile(
                    title: Text(recipe.text),
                    subtitle: Text('${recipe.author} - ${recipe.date}'),
                    onTap: () {
                      // Show the recipe in the text field
                      _textEditingController.text = recipe.ingredients;
                      setState(() {
                        _recipe = recipe;
                      });
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        // Delete the recipe from the database
                        await client.recipes.deleteRecipe(recipe.id!);
                        setState(
                          () {
                            _recipeHistory.removeAt(index);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your ingredients',
                      ),
                    ),
                  ),
                  ImageUploadButton(
                    key: ValueKey(_imagePath),
                    onImagePathChanged: (imagePath) {
                      setState(() {
                        _imagePath = imagePath;
                      });
                    },
                    imagePath: _imagePath,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ElevatedButton(
                      onPressed: _loading ? null : _callGenerateRecipe,
                      child: _loading
                          ? const Text('Loading...')
                          : const Text('Send to Server'),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child:
                          // Change the ResultDisplay to use the Recipe object
                          ResultDisplay(
                        resultMessage: _recipe != null
                            ? '${_recipe?.author} on ${_recipe?.date}:\n${_recipe?.text}'
                            : null,
                        errorMessage: _errorMessage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ResultDisplays shows the result of the call. Either the returned result from
/// the `example.greeting` endpoint method or an error message.
class ResultDisplay extends StatelessWidget {
  final String? resultMessage;
  final String? errorMessage;

  const ResultDisplay({
    super.key,
    this.resultMessage,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    String text;
    Color backgroundColor;
    if (errorMessage != null) {
      backgroundColor = Colors.red[300]!;
      text = errorMessage!;
    } else if (resultMessage != null) {
      backgroundColor = Colors.green[300]!;
      text = resultMessage!;
    } else {
      backgroundColor = Colors.grey[300]!;
      text = 'No server response yet.';
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 50),
      child: Container(
        color: backgroundColor,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}

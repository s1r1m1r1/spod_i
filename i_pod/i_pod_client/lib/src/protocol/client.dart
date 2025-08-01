/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i3;
import 'package:i_pod_client/src/protocol/recipe.dart' as _i4;
import 'protocol.dart' as _i5;

/// {@category Endpoint}
class EndpointAdmin extends _i1.EndpointRef {
  EndpointAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i2.Future<List<_i3.UserInfo>> listUsers() =>
      caller.callServerEndpoint<List<_i3.UserInfo>>(
        'admin',
        'listUsers',
        {},
      );

  _i2.Future<void> blockUser(int userId) => caller.callServerEndpoint<void>(
        'admin',
        'blockUser',
        {'userId': userId},
      );

  _i2.Future<void> unblockUser(int userId) => caller.callServerEndpoint<void>(
        'admin',
        'unblockUser',
        {'userId': userId},
      );

  _i2.Future<void> triggerDeletedRecipeCleanup() =>
      caller.callServerEndpoint<void>(
        'admin',
        'triggerDeletedRecipeCleanup',
        {},
      );

  _i2.Future<void> scheduleDeletedRecipeCleanup() =>
      caller.callServerEndpoint<void>(
        'admin',
        'scheduleDeletedRecipeCleanup',
        {},
      );

  _i2.Future<void> stopCleanupTask() => caller.callServerEndpoint<void>(
        'admin',
        'stopCleanupTask',
        {},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointRecipes extends _i1.EndpointRef {
  EndpointRecipes(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'recipes';

  _i2.Future<List<_i4.Recipe>> getRecipes() =>
      caller.callServerEndpoint<List<_i4.Recipe>>(
        'recipes',
        'getRecipes',
        {},
      );

  _i2.Future<void> deleteRecipe(int recipeId) =>
      caller.callServerEndpoint<void>(
        'recipes',
        'deleteRecipe',
        {'recipeId': recipeId},
      );

  _i2.Stream<_i4.Recipe> generateRecipe2(
    String ingredients, [
    String? imagePath,
  ]) =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i4.Recipe>, _i4.Recipe>(
        'recipes',
        'generateRecipe2',
        {
          'ingredients': ingredients,
          'imagePath': imagePath,
        },
        {},
      );

  _i2.Future<(String?, String)> getUploadDescription(String filename) =>
      caller.callServerEndpoint<(String?, String)>(
        'recipes',
        'getUploadDescription',
        {'filename': filename},
      );

  _i2.Future<bool> verifyUpload(String path) => caller.callServerEndpoint<bool>(
        'recipes',
        'verifyUpload',
        {'path': path},
      );

  _i2.Future<String> getPublicUrlForPath(String path) =>
      caller.callServerEndpoint<String>(
        'recipes',
        'getPublicUrlForPath',
        {'path': path},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i3.Caller(client);
  }

  late final _i3.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i5.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    admin = EndpointAdmin(this);
    recipes = EndpointRecipes(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointRecipes recipes;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'admin': admin,
        'recipes': recipes,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}

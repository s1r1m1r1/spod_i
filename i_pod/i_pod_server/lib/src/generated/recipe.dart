/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// Our AI generated Recipe
abstract class Recipe implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Recipe._({
    this.id,
    required this.author,
    required this.text,
    required this.date,
    required this.ingredients,
    this.deletedAt,
    this.userId,
    this.imagePath,
  });

  factory Recipe({
    int? id,
    required String author,
    required String text,
    required DateTime date,
    required String ingredients,
    DateTime? deletedAt,
    int? userId,
    String? imagePath,
  }) = _RecipeImpl;

  factory Recipe.fromJson(Map<String, dynamic> jsonSerialization) {
    return Recipe(
      id: jsonSerialization['id'] as int?,
      author: jsonSerialization['author'] as String,
      text: jsonSerialization['text'] as String,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      ingredients: jsonSerialization['ingredients'] as String,
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
      userId: jsonSerialization['userId'] as int?,
      imagePath: jsonSerialization['imagePath'] as String?,
    );
  }

  static final t = RecipeTable();

  static const db = RecipeRepository._();

  @override
  int? id;

  /// The author of the recipe
  String author;

  /// The recipe text
  String text;

  /// The date the recipe was created
  DateTime date;

  /// The ingredients the user has passed in
  String ingredients;

  /// If the recipe was deleted, we store the date it was deleted
  DateTime? deletedAt;

  /// The user id of the user who created the recipe
  int? userId;

  /// Image path of the user upload
  String? imagePath;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Recipe]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Recipe copyWith({
    int? id,
    String? author,
    String? text,
    DateTime? date,
    String? ingredients,
    DateTime? deletedAt,
    int? userId,
    String? imagePath,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'author': author,
      'text': text,
      'date': date.toJson(),
      'ingredients': ingredients,
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      if (userId != null) 'userId': userId,
      if (imagePath != null) 'imagePath': imagePath,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'author': author,
      'text': text,
      'date': date.toJson(),
      'ingredients': ingredients,
      if (imagePath != null) 'imagePath': imagePath,
    };
  }

  static RecipeInclude include() {
    return RecipeInclude._();
  }

  static RecipeIncludeList includeList({
    _i1.WhereExpressionBuilder<RecipeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RecipeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RecipeTable>? orderByList,
    RecipeInclude? include,
  }) {
    return RecipeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Recipe.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Recipe.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RecipeImpl extends Recipe {
  _RecipeImpl({
    int? id,
    required String author,
    required String text,
    required DateTime date,
    required String ingredients,
    DateTime? deletedAt,
    int? userId,
    String? imagePath,
  }) : super._(
          id: id,
          author: author,
          text: text,
          date: date,
          ingredients: ingredients,
          deletedAt: deletedAt,
          userId: userId,
          imagePath: imagePath,
        );

  /// Returns a shallow copy of this [Recipe]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Recipe copyWith({
    Object? id = _Undefined,
    String? author,
    String? text,
    DateTime? date,
    String? ingredients,
    Object? deletedAt = _Undefined,
    Object? userId = _Undefined,
    Object? imagePath = _Undefined,
  }) {
    return Recipe(
      id: id is int? ? id : this.id,
      author: author ?? this.author,
      text: text ?? this.text,
      date: date ?? this.date,
      ingredients: ingredients ?? this.ingredients,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
      userId: userId is int? ? userId : this.userId,
      imagePath: imagePath is String? ? imagePath : this.imagePath,
    );
  }
}

class RecipeTable extends _i1.Table<int?> {
  RecipeTable({super.tableRelation}) : super(tableName: 'recipe') {
    author = _i1.ColumnString(
      'author',
      this,
    );
    text = _i1.ColumnString(
      'text',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    ingredients = _i1.ColumnString(
      'ingredients',
      this,
    );
    deletedAt = _i1.ColumnDateTime(
      'deletedAt',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    imagePath = _i1.ColumnString(
      'imagePath',
      this,
    );
  }

  /// The author of the recipe
  late final _i1.ColumnString author;

  /// The recipe text
  late final _i1.ColumnString text;

  /// The date the recipe was created
  late final _i1.ColumnDateTime date;

  /// The ingredients the user has passed in
  late final _i1.ColumnString ingredients;

  /// If the recipe was deleted, we store the date it was deleted
  late final _i1.ColumnDateTime deletedAt;

  /// The user id of the user who created the recipe
  late final _i1.ColumnInt userId;

  /// Image path of the user upload
  late final _i1.ColumnString imagePath;

  @override
  List<_i1.Column> get columns => [
        id,
        author,
        text,
        date,
        ingredients,
        deletedAt,
        userId,
        imagePath,
      ];
}

class RecipeInclude extends _i1.IncludeObject {
  RecipeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Recipe.t;
}

class RecipeIncludeList extends _i1.IncludeList {
  RecipeIncludeList._({
    _i1.WhereExpressionBuilder<RecipeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Recipe.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Recipe.t;
}

class RecipeRepository {
  const RecipeRepository._();

  /// Returns a list of [Recipe]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Recipe>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RecipeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RecipeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RecipeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Recipe>(
      where: where?.call(Recipe.t),
      orderBy: orderBy?.call(Recipe.t),
      orderByList: orderByList?.call(Recipe.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Recipe] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Recipe?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RecipeTable>? where,
    int? offset,
    _i1.OrderByBuilder<RecipeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RecipeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Recipe>(
      where: where?.call(Recipe.t),
      orderBy: orderBy?.call(Recipe.t),
      orderByList: orderByList?.call(Recipe.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Recipe] by its [id] or null if no such row exists.
  Future<Recipe?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Recipe>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Recipe]s in the list and returns the inserted rows.
  ///
  /// The returned [Recipe]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Recipe>> insert(
    _i1.Session session,
    List<Recipe> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Recipe>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Recipe] and returns the inserted row.
  ///
  /// The returned [Recipe] will have its `id` field set.
  Future<Recipe> insertRow(
    _i1.Session session,
    Recipe row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Recipe>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Recipe]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Recipe>> update(
    _i1.Session session,
    List<Recipe> rows, {
    _i1.ColumnSelections<RecipeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Recipe>(
      rows,
      columns: columns?.call(Recipe.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Recipe]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Recipe> updateRow(
    _i1.Session session,
    Recipe row, {
    _i1.ColumnSelections<RecipeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Recipe>(
      row,
      columns: columns?.call(Recipe.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Recipe]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Recipe>> delete(
    _i1.Session session,
    List<Recipe> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Recipe>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Recipe].
  Future<Recipe> deleteRow(
    _i1.Session session,
    Recipe row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Recipe>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Recipe>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RecipeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Recipe>(
      where: where(Recipe.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RecipeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Recipe>(
      where: where?.call(Recipe.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

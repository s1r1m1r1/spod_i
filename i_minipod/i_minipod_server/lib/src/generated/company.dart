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

abstract class Company
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Company._({
    required this.name,
    this.foundedDate,
    required this.employees,
  });

  factory Company({
    required String name,
    DateTime? foundedDate,
    required List<String> employees,
  }) = _CompanyImpl;

  factory Company.fromJson(Map<String, dynamic> jsonSerialization) {
    return Company(
      name: jsonSerialization['name'] as String,
      foundedDate: jsonSerialization['foundedDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['foundedDate']),
      employees: (jsonSerialization['employees'] as List)
          .map((e) => e as String)
          .toList(),
    );
  }

  String name;

  DateTime? foundedDate;

  List<String> employees;

  /// Returns a shallow copy of this [Company]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Company copyWith({
    String? name,
    DateTime? foundedDate,
    List<String>? employees,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (foundedDate != null) 'foundedDate': foundedDate?.toJson(),
      'employees': employees.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'name': name,
      if (foundedDate != null) 'foundedDate': foundedDate?.toJson(),
      'employees': employees.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompanyImpl extends Company {
  _CompanyImpl({
    required String name,
    DateTime? foundedDate,
    required List<String> employees,
  }) : super._(
          name: name,
          foundedDate: foundedDate,
          employees: employees,
        );

  /// Returns a shallow copy of this [Company]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Company copyWith({
    String? name,
    Object? foundedDate = _Undefined,
    List<String>? employees,
  }) {
    return Company(
      name: name ?? this.name,
      foundedDate: foundedDate is DateTime? ? foundedDate : this.foundedDate,
      employees: employees ?? this.employees.map((e0) => e0).toList(),
    );
  }
}

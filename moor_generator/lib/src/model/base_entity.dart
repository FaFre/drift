//@dart=2.9
import 'package:moor_generator/moor_generator.dart';

/// Some schema entity found.
///
/// Most commonly a table, but it can also be a trigger.
abstract class MoorSchemaEntity implements HasDeclaration {
  /// All entities that have to be created before this entity can be created.
  ///
  /// For tables, this can be contents of a `REFERENCES` clause. For triggers,
  /// it would be the tables watched.
  ///
  /// If an entity contains an (invalid) null reference, that should not be
  /// included in [references].
  ///
  /// The generator will verify that the graph of entities and [references]
  /// is acyclic and sort them topologically.
  Iterable<MoorSchemaEntity> get references;

  /// A human readable name of this entity, like the table name.
  String get displayName;

  /// The getter in a generated database accessor referring to this model.
  ///
  /// Returns null for entities that shouldn't have a getter.
  String get dbGetterName;
}

abstract class MoorEntityWithResultSet extends MoorSchemaEntity {
  /// The columns declared in this table or view.
  List<MoorColumn> get columns;

  /// The name of the Dart row class for this result set.
  String get dartTypeName;

  /// The name of the Dart class storing additional properties like type
  /// converters.
  String get entityInfoName;
}

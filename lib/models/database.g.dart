// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BroadcastingFoldersTable extends BroadcastingFolders
    with TableInfo<$BroadcastingFoldersTable, BroadcastingFolder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BroadcastingFoldersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, path];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'broadcasting_folders';
  @override
  VerificationContext validateIntegrity(
    Insertable<BroadcastingFolder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BroadcastingFolder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BroadcastingFolder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
    );
  }

  @override
  $BroadcastingFoldersTable createAlias(String alias) {
    return $BroadcastingFoldersTable(attachedDatabase, alias);
  }
}

class BroadcastingFolder extends DataClass
    implements Insertable<BroadcastingFolder> {
  final int id;
  final String name;
  final String path;
  const BroadcastingFolder({
    required this.id,
    required this.name,
    required this.path,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['path'] = Variable<String>(path);
    return map;
  }

  BroadcastingFoldersCompanion toCompanion(bool nullToAbsent) {
    return BroadcastingFoldersCompanion(
      id: Value(id),
      name: Value(name),
      path: Value(path),
    );
  }

  factory BroadcastingFolder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BroadcastingFolder(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      path: serializer.fromJson<String>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'path': serializer.toJson<String>(path),
    };
  }

  BroadcastingFolder copyWith({int? id, String? name, String? path}) =>
      BroadcastingFolder(
        id: id ?? this.id,
        name: name ?? this.name,
        path: path ?? this.path,
      );
  BroadcastingFolder copyWithCompanion(BroadcastingFoldersCompanion data) {
    return BroadcastingFolder(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      path: data.path.present ? data.path.value : this.path,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BroadcastingFolder(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, path);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BroadcastingFolder &&
          other.id == this.id &&
          other.name == this.name &&
          other.path == this.path);
}

class BroadcastingFoldersCompanion extends UpdateCompanion<BroadcastingFolder> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> path;
  const BroadcastingFoldersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
  });
  BroadcastingFoldersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String path,
  }) : name = Value(name),
       path = Value(path);
  static Insertable<BroadcastingFolder> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? path,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (path != null) 'path': path,
    });
  }

  BroadcastingFoldersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? path,
  }) {
    return BroadcastingFoldersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BroadcastingFoldersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }
}

class $SyncedFoldersTable extends SyncedFolders
    with TableInfo<$SyncedFoldersTable, SyncedFolder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncedFoldersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sourceUuidMeta = const VerificationMeta(
    'sourceUuid',
  );
  @override
  late final GeneratedColumn<String> sourceUuid = GeneratedColumn<String>(
    'source_uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sourceUuid, name, path];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'synced_folders';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncedFolder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_uuid')) {
      context.handle(
        _sourceUuidMeta,
        sourceUuid.isAcceptableOrUnknown(data['source_uuid']!, _sourceUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceUuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncedFolder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncedFolder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sourceUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
    );
  }

  @override
  $SyncedFoldersTable createAlias(String alias) {
    return $SyncedFoldersTable(attachedDatabase, alias);
  }
}

class SyncedFolder extends DataClass implements Insertable<SyncedFolder> {
  final int id;
  final String sourceUuid;
  final String name;
  final String path;
  const SyncedFolder({
    required this.id,
    required this.sourceUuid,
    required this.name,
    required this.path,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_uuid'] = Variable<String>(sourceUuid);
    map['name'] = Variable<String>(name);
    map['path'] = Variable<String>(path);
    return map;
  }

  SyncedFoldersCompanion toCompanion(bool nullToAbsent) {
    return SyncedFoldersCompanion(
      id: Value(id),
      sourceUuid: Value(sourceUuid),
      name: Value(name),
      path: Value(path),
    );
  }

  factory SyncedFolder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncedFolder(
      id: serializer.fromJson<int>(json['id']),
      sourceUuid: serializer.fromJson<String>(json['sourceUuid']),
      name: serializer.fromJson<String>(json['name']),
      path: serializer.fromJson<String>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceUuid': serializer.toJson<String>(sourceUuid),
      'name': serializer.toJson<String>(name),
      'path': serializer.toJson<String>(path),
    };
  }

  SyncedFolder copyWith({
    int? id,
    String? sourceUuid,
    String? name,
    String? path,
  }) => SyncedFolder(
    id: id ?? this.id,
    sourceUuid: sourceUuid ?? this.sourceUuid,
    name: name ?? this.name,
    path: path ?? this.path,
  );
  SyncedFolder copyWithCompanion(SyncedFoldersCompanion data) {
    return SyncedFolder(
      id: data.id.present ? data.id.value : this.id,
      sourceUuid: data.sourceUuid.present
          ? data.sourceUuid.value
          : this.sourceUuid,
      name: data.name.present ? data.name.value : this.name,
      path: data.path.present ? data.path.value : this.path,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncedFolder(')
          ..write('id: $id, ')
          ..write('sourceUuid: $sourceUuid, ')
          ..write('name: $name, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceUuid, name, path);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncedFolder &&
          other.id == this.id &&
          other.sourceUuid == this.sourceUuid &&
          other.name == this.name &&
          other.path == this.path);
}

class SyncedFoldersCompanion extends UpdateCompanion<SyncedFolder> {
  final Value<int> id;
  final Value<String> sourceUuid;
  final Value<String> name;
  final Value<String> path;
  const SyncedFoldersCompanion({
    this.id = const Value.absent(),
    this.sourceUuid = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
  });
  SyncedFoldersCompanion.insert({
    this.id = const Value.absent(),
    required String sourceUuid,
    required String name,
    required String path,
  }) : sourceUuid = Value(sourceUuid),
       name = Value(name),
       path = Value(path);
  static Insertable<SyncedFolder> custom({
    Expression<int>? id,
    Expression<String>? sourceUuid,
    Expression<String>? name,
    Expression<String>? path,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceUuid != null) 'source_uuid': sourceUuid,
      if (name != null) 'name': name,
      if (path != null) 'path': path,
    });
  }

  SyncedFoldersCompanion copyWith({
    Value<int>? id,
    Value<String>? sourceUuid,
    Value<String>? name,
    Value<String>? path,
  }) {
    return SyncedFoldersCompanion(
      id: id ?? this.id,
      sourceUuid: sourceUuid ?? this.sourceUuid,
      name: name ?? this.name,
      path: path ?? this.path,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceUuid.present) {
      map['source_uuid'] = Variable<String>(sourceUuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncedFoldersCompanion(')
          ..write('id: $id, ')
          ..write('sourceUuid: $sourceUuid, ')
          ..write('name: $name, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BroadcastingFoldersTable broadcastingFolders =
      $BroadcastingFoldersTable(this);
  late final $SyncedFoldersTable syncedFolders = $SyncedFoldersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    broadcastingFolders,
    syncedFolders,
  ];
}

typedef $$BroadcastingFoldersTableCreateCompanionBuilder =
    BroadcastingFoldersCompanion Function({
      Value<int> id,
      required String name,
      required String path,
    });
typedef $$BroadcastingFoldersTableUpdateCompanionBuilder =
    BroadcastingFoldersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> path,
    });

class $$BroadcastingFoldersTableFilterComposer
    extends Composer<_$AppDatabase, $BroadcastingFoldersTable> {
  $$BroadcastingFoldersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BroadcastingFoldersTableOrderingComposer
    extends Composer<_$AppDatabase, $BroadcastingFoldersTable> {
  $$BroadcastingFoldersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BroadcastingFoldersTableAnnotationComposer
    extends Composer<_$AppDatabase, $BroadcastingFoldersTable> {
  $$BroadcastingFoldersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);
}

class $$BroadcastingFoldersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BroadcastingFoldersTable,
          BroadcastingFolder,
          $$BroadcastingFoldersTableFilterComposer,
          $$BroadcastingFoldersTableOrderingComposer,
          $$BroadcastingFoldersTableAnnotationComposer,
          $$BroadcastingFoldersTableCreateCompanionBuilder,
          $$BroadcastingFoldersTableUpdateCompanionBuilder,
          (
            BroadcastingFolder,
            BaseReferences<
              _$AppDatabase,
              $BroadcastingFoldersTable,
              BroadcastingFolder
            >,
          ),
          BroadcastingFolder,
          PrefetchHooks Function()
        > {
  $$BroadcastingFoldersTableTableManager(
    _$AppDatabase db,
    $BroadcastingFoldersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BroadcastingFoldersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BroadcastingFoldersTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BroadcastingFoldersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> path = const Value.absent(),
              }) =>
                  BroadcastingFoldersCompanion(id: id, name: name, path: path),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String path,
              }) => BroadcastingFoldersCompanion.insert(
                id: id,
                name: name,
                path: path,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BroadcastingFoldersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BroadcastingFoldersTable,
      BroadcastingFolder,
      $$BroadcastingFoldersTableFilterComposer,
      $$BroadcastingFoldersTableOrderingComposer,
      $$BroadcastingFoldersTableAnnotationComposer,
      $$BroadcastingFoldersTableCreateCompanionBuilder,
      $$BroadcastingFoldersTableUpdateCompanionBuilder,
      (
        BroadcastingFolder,
        BaseReferences<
          _$AppDatabase,
          $BroadcastingFoldersTable,
          BroadcastingFolder
        >,
      ),
      BroadcastingFolder,
      PrefetchHooks Function()
    >;
typedef $$SyncedFoldersTableCreateCompanionBuilder =
    SyncedFoldersCompanion Function({
      Value<int> id,
      required String sourceUuid,
      required String name,
      required String path,
    });
typedef $$SyncedFoldersTableUpdateCompanionBuilder =
    SyncedFoldersCompanion Function({
      Value<int> id,
      Value<String> sourceUuid,
      Value<String> name,
      Value<String> path,
    });

class $$SyncedFoldersTableFilterComposer
    extends Composer<_$AppDatabase, $SyncedFoldersTable> {
  $$SyncedFoldersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceUuid => $composableBuilder(
    column: $table.sourceUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncedFoldersTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncedFoldersTable> {
  $$SyncedFoldersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceUuid => $composableBuilder(
    column: $table.sourceUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncedFoldersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncedFoldersTable> {
  $$SyncedFoldersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceUuid => $composableBuilder(
    column: $table.sourceUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);
}

class $$SyncedFoldersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncedFoldersTable,
          SyncedFolder,
          $$SyncedFoldersTableFilterComposer,
          $$SyncedFoldersTableOrderingComposer,
          $$SyncedFoldersTableAnnotationComposer,
          $$SyncedFoldersTableCreateCompanionBuilder,
          $$SyncedFoldersTableUpdateCompanionBuilder,
          (
            SyncedFolder,
            BaseReferences<_$AppDatabase, $SyncedFoldersTable, SyncedFolder>,
          ),
          SyncedFolder,
          PrefetchHooks Function()
        > {
  $$SyncedFoldersTableTableManager(_$AppDatabase db, $SyncedFoldersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncedFoldersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncedFoldersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncedFoldersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sourceUuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> path = const Value.absent(),
              }) => SyncedFoldersCompanion(
                id: id,
                sourceUuid: sourceUuid,
                name: name,
                path: path,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sourceUuid,
                required String name,
                required String path,
              }) => SyncedFoldersCompanion.insert(
                id: id,
                sourceUuid: sourceUuid,
                name: name,
                path: path,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncedFoldersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncedFoldersTable,
      SyncedFolder,
      $$SyncedFoldersTableFilterComposer,
      $$SyncedFoldersTableOrderingComposer,
      $$SyncedFoldersTableAnnotationComposer,
      $$SyncedFoldersTableCreateCompanionBuilder,
      $$SyncedFoldersTableUpdateCompanionBuilder,
      (
        SyncedFolder,
        BaseReferences<_$AppDatabase, $SyncedFoldersTable, SyncedFolder>,
      ),
      SyncedFolder,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BroadcastingFoldersTableTableManager get broadcastingFolders =>
      $$BroadcastingFoldersTableTableManager(_db, _db.broadcastingFolders);
  $$SyncedFoldersTableTableManager get syncedFolders =>
      $$SyncedFoldersTableTableManager(_db, _db.syncedFolders);
}

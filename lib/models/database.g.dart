// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SharedFoldersTable extends SharedFolders
    with TableInfo<$SharedFoldersTable, SharedFolder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SharedFoldersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v7(),
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
  static const String $name = 'shared_folders';
  @override
  VerificationContext validateIntegrity(
    Insertable<SharedFolder> instance, {
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
  SharedFolder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SharedFolder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
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
  $SharedFoldersTable createAlias(String alias) {
    return $SharedFoldersTable(attachedDatabase, alias);
  }
}

class SharedFolder extends DataClass implements Insertable<SharedFolder> {
  final String id;
  final String name;
  final String path;
  const SharedFolder({
    required this.id,
    required this.name,
    required this.path,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['path'] = Variable<String>(path);
    return map;
  }

  SharedFoldersCompanion toCompanion(bool nullToAbsent) {
    return SharedFoldersCompanion(
      id: Value(id),
      name: Value(name),
      path: Value(path),
    );
  }

  factory SharedFolder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SharedFolder(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      path: serializer.fromJson<String>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'path': serializer.toJson<String>(path),
    };
  }

  SharedFolder copyWith({String? id, String? name, String? path}) =>
      SharedFolder(
        id: id ?? this.id,
        name: name ?? this.name,
        path: path ?? this.path,
      );
  SharedFolder copyWithCompanion(SharedFoldersCompanion data) {
    return SharedFolder(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      path: data.path.present ? data.path.value : this.path,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SharedFolder(')
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
      (other is SharedFolder &&
          other.id == this.id &&
          other.name == this.name &&
          other.path == this.path);
}

class SharedFoldersCompanion extends UpdateCompanion<SharedFolder> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> path;
  final Value<int> rowid;
  const SharedFoldersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SharedFoldersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String path,
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       path = Value(path);
  static Insertable<SharedFolder> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? path,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (path != null) 'path': path,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SharedFoldersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? path,
    Value<int>? rowid,
  }) {
    return SharedFoldersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SharedFoldersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _lastSyncMeta = const VerificationMeta(
    'lastSync',
  );
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
    'last_sync',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, path, lastSync];
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
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('last_sync')) {
      context.handle(
        _lastSyncMeta,
        lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta),
      );
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
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
      lastSync: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync'],
      ),
    );
  }

  @override
  $SyncedFoldersTable createAlias(String alias) {
    return $SyncedFoldersTable(attachedDatabase, alias);
  }
}

class SyncedFolder extends DataClass implements Insertable<SyncedFolder> {
  final String id;
  final String path;
  final DateTime? lastSync;
  const SyncedFolder({required this.id, required this.path, this.lastSync});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || lastSync != null) {
      map['last_sync'] = Variable<DateTime>(lastSync);
    }
    return map;
  }

  SyncedFoldersCompanion toCompanion(bool nullToAbsent) {
    return SyncedFoldersCompanion(
      id: Value(id),
      path: Value(path),
      lastSync: lastSync == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSync),
    );
  }

  factory SyncedFolder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncedFolder(
      id: serializer.fromJson<String>(json['id']),
      path: serializer.fromJson<String>(json['path']),
      lastSync: serializer.fromJson<DateTime?>(json['lastSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'path': serializer.toJson<String>(path),
      'lastSync': serializer.toJson<DateTime?>(lastSync),
    };
  }

  SyncedFolder copyWith({
    String? id,
    String? path,
    Value<DateTime?> lastSync = const Value.absent(),
  }) => SyncedFolder(
    id: id ?? this.id,
    path: path ?? this.path,
    lastSync: lastSync.present ? lastSync.value : this.lastSync,
  );
  SyncedFolder copyWithCompanion(SyncedFoldersCompanion data) {
    return SyncedFolder(
      id: data.id.present ? data.id.value : this.id,
      path: data.path.present ? data.path.value : this.path,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncedFolder(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('lastSync: $lastSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, path, lastSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncedFolder &&
          other.id == this.id &&
          other.path == this.path &&
          other.lastSync == this.lastSync);
}

class SyncedFoldersCompanion extends UpdateCompanion<SyncedFolder> {
  final Value<String> id;
  final Value<String> path;
  final Value<DateTime?> lastSync;
  final Value<int> rowid;
  const SyncedFoldersCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncedFoldersCompanion.insert({
    required String id,
    required String path,
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       path = Value(path);
  static Insertable<SyncedFolder> custom({
    Expression<String>? id,
    Expression<String>? path,
    Expression<DateTime>? lastSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
      if (lastSync != null) 'last_sync': lastSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncedFoldersCompanion copyWith({
    Value<String>? id,
    Value<String>? path,
    Value<DateTime?>? lastSync,
    Value<int>? rowid,
  }) {
    return SyncedFoldersCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
      lastSync: lastSync ?? this.lastSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncedFoldersCompanion(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('lastSync: $lastSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SharedFoldersTable sharedFolders = $SharedFoldersTable(this);
  late final $SyncedFoldersTable syncedFolders = $SyncedFoldersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sharedFolders,
    syncedFolders,
  ];
}

typedef $$SharedFoldersTableCreateCompanionBuilder =
    SharedFoldersCompanion Function({
      Value<String> id,
      required String name,
      required String path,
      Value<int> rowid,
    });
typedef $$SharedFoldersTableUpdateCompanionBuilder =
    SharedFoldersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> path,
      Value<int> rowid,
    });

class $$SharedFoldersTableFilterComposer
    extends Composer<_$AppDatabase, $SharedFoldersTable> {
  $$SharedFoldersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
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

class $$SharedFoldersTableOrderingComposer
    extends Composer<_$AppDatabase, $SharedFoldersTable> {
  $$SharedFoldersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
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

class $$SharedFoldersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SharedFoldersTable> {
  $$SharedFoldersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);
}

class $$SharedFoldersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SharedFoldersTable,
          SharedFolder,
          $$SharedFoldersTableFilterComposer,
          $$SharedFoldersTableOrderingComposer,
          $$SharedFoldersTableAnnotationComposer,
          $$SharedFoldersTableCreateCompanionBuilder,
          $$SharedFoldersTableUpdateCompanionBuilder,
          (
            SharedFolder,
            BaseReferences<_$AppDatabase, $SharedFoldersTable, SharedFolder>,
          ),
          SharedFolder,
          PrefetchHooks Function()
        > {
  $$SharedFoldersTableTableManager(_$AppDatabase db, $SharedFoldersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SharedFoldersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SharedFoldersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SharedFoldersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SharedFoldersCompanion(
                id: id,
                name: name,
                path: path,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                required String path,
                Value<int> rowid = const Value.absent(),
              }) => SharedFoldersCompanion.insert(
                id: id,
                name: name,
                path: path,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SharedFoldersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SharedFoldersTable,
      SharedFolder,
      $$SharedFoldersTableFilterComposer,
      $$SharedFoldersTableOrderingComposer,
      $$SharedFoldersTableAnnotationComposer,
      $$SharedFoldersTableCreateCompanionBuilder,
      $$SharedFoldersTableUpdateCompanionBuilder,
      (
        SharedFolder,
        BaseReferences<_$AppDatabase, $SharedFoldersTable, SharedFolder>,
      ),
      SharedFolder,
      PrefetchHooks Function()
    >;
typedef $$SyncedFoldersTableCreateCompanionBuilder =
    SyncedFoldersCompanion Function({
      required String id,
      required String path,
      Value<DateTime?> lastSync,
      Value<int> rowid,
    });
typedef $$SyncedFoldersTableUpdateCompanionBuilder =
    SyncedFoldersCompanion Function({
      Value<String> id,
      Value<String> path,
      Value<DateTime?> lastSync,
      Value<int> rowid,
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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);
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
                Value<String> id = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<DateTime?> lastSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncedFoldersCompanion(
                id: id,
                path: path,
                lastSync: lastSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String path,
                Value<DateTime?> lastSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncedFoldersCompanion.insert(
                id: id,
                path: path,
                lastSync: lastSync,
                rowid: rowid,
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
  $$SharedFoldersTableTableManager get sharedFolders =>
      $$SharedFoldersTableTableManager(_db, _db.sharedFolders);
  $$SyncedFoldersTableTableManager get syncedFolders =>
      $$SyncedFoldersTableTableManager(_db, _db.syncedFolders);
}

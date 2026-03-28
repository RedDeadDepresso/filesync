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
  $BroadcastingFoldersTable createAlias(String alias) {
    return $BroadcastingFoldersTable(attachedDatabase, alias);
  }
}

class BroadcastingFolder extends DataClass
    implements Insertable<BroadcastingFolder> {
  final String id;
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
    map['id'] = Variable<String>(id);
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

  BroadcastingFolder copyWith({String? id, String? name, String? path}) =>
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
  final Value<String> id;
  final Value<String> name;
  final Value<String> path;
  final Value<int> rowid;
  const BroadcastingFoldersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BroadcastingFoldersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String path,
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       path = Value(path);
  static Insertable<BroadcastingFolder> custom({
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

  BroadcastingFoldersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? path,
    Value<int>? rowid,
  }) {
    return BroadcastingFoldersCompanion(
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
    return (StringBuffer('BroadcastingFoldersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemoteFoldersTable extends RemoteFolders
    with TableInfo<$RemoteFoldersTable, RemoteFolder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemoteFoldersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
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
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, localPath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'remote_folders';
  @override
  VerificationContext validateIntegrity(
    Insertable<RemoteFolder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RemoteFolder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RemoteFolder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
    );
  }

  @override
  $RemoteFoldersTable createAlias(String alias) {
    return $RemoteFoldersTable(attachedDatabase, alias);
  }
}

class RemoteFolder extends DataClass implements Insertable<RemoteFolder> {
  final String id;
  final String name;
  final String localPath;
  const RemoteFolder({
    required this.id,
    required this.name,
    required this.localPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['local_path'] = Variable<String>(localPath);
    return map;
  }

  RemoteFoldersCompanion toCompanion(bool nullToAbsent) {
    return RemoteFoldersCompanion(
      id: Value(id),
      name: Value(name),
      localPath: Value(localPath),
    );
  }

  factory RemoteFolder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RemoteFolder(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      localPath: serializer.fromJson<String>(json['localPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'localPath': serializer.toJson<String>(localPath),
    };
  }

  RemoteFolder copyWith({String? id, String? name, String? localPath}) =>
      RemoteFolder(
        id: id ?? this.id,
        name: name ?? this.name,
        localPath: localPath ?? this.localPath,
      );
  RemoteFolder copyWithCompanion(RemoteFoldersCompanion data) {
    return RemoteFolder(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RemoteFolder(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('localPath: $localPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, localPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RemoteFolder &&
          other.id == this.id &&
          other.name == this.name &&
          other.localPath == this.localPath);
}

class RemoteFoldersCompanion extends UpdateCompanion<RemoteFolder> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> localPath;
  final Value<int> rowid;
  const RemoteFoldersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.localPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemoteFoldersCompanion.insert({
    required String id,
    required String name,
    required String localPath,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       localPath = Value(localPath);
  static Insertable<RemoteFolder> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? localPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (localPath != null) 'local_path': localPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemoteFoldersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? localPath,
    Value<int>? rowid,
  }) {
    return RemoteFoldersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      localPath: localPath ?? this.localPath,
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
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemoteFoldersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('localPath: $localPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BroadcastingFoldersTable broadcastingFolders =
      $BroadcastingFoldersTable(this);
  late final $RemoteFoldersTable remoteFolders = $RemoteFoldersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    broadcastingFolders,
    remoteFolders,
  ];
}

typedef $$BroadcastingFoldersTableCreateCompanionBuilder =
    BroadcastingFoldersCompanion Function({
      Value<String> id,
      required String name,
      required String path,
      Value<int> rowid,
    });
typedef $$BroadcastingFoldersTableUpdateCompanionBuilder =
    BroadcastingFoldersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> path,
      Value<int> rowid,
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

class $$BroadcastingFoldersTableOrderingComposer
    extends Composer<_$AppDatabase, $BroadcastingFoldersTable> {
  $$BroadcastingFoldersTableOrderingComposer({
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

class $$BroadcastingFoldersTableAnnotationComposer
    extends Composer<_$AppDatabase, $BroadcastingFoldersTable> {
  $$BroadcastingFoldersTableAnnotationComposer({
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
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BroadcastingFoldersCompanion(
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
              }) => BroadcastingFoldersCompanion.insert(
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
typedef $$RemoteFoldersTableCreateCompanionBuilder =
    RemoteFoldersCompanion Function({
      required String id,
      required String name,
      required String localPath,
      Value<int> rowid,
    });
typedef $$RemoteFoldersTableUpdateCompanionBuilder =
    RemoteFoldersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> localPath,
      Value<int> rowid,
    });

class $$RemoteFoldersTableFilterComposer
    extends Composer<_$AppDatabase, $RemoteFoldersTable> {
  $$RemoteFoldersTableFilterComposer({
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

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemoteFoldersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemoteFoldersTable> {
  $$RemoteFoldersTableOrderingComposer({
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

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemoteFoldersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemoteFoldersTable> {
  $$RemoteFoldersTableAnnotationComposer({
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

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);
}

class $$RemoteFoldersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemoteFoldersTable,
          RemoteFolder,
          $$RemoteFoldersTableFilterComposer,
          $$RemoteFoldersTableOrderingComposer,
          $$RemoteFoldersTableAnnotationComposer,
          $$RemoteFoldersTableCreateCompanionBuilder,
          $$RemoteFoldersTableUpdateCompanionBuilder,
          (
            RemoteFolder,
            BaseReferences<_$AppDatabase, $RemoteFoldersTable, RemoteFolder>,
          ),
          RemoteFolder,
          PrefetchHooks Function()
        > {
  $$RemoteFoldersTableTableManager(_$AppDatabase db, $RemoteFoldersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemoteFoldersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemoteFoldersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemoteFoldersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemoteFoldersCompanion(
                id: id,
                name: name,
                localPath: localPath,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String localPath,
                Value<int> rowid = const Value.absent(),
              }) => RemoteFoldersCompanion.insert(
                id: id,
                name: name,
                localPath: localPath,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemoteFoldersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemoteFoldersTable,
      RemoteFolder,
      $$RemoteFoldersTableFilterComposer,
      $$RemoteFoldersTableOrderingComposer,
      $$RemoteFoldersTableAnnotationComposer,
      $$RemoteFoldersTableCreateCompanionBuilder,
      $$RemoteFoldersTableUpdateCompanionBuilder,
      (
        RemoteFolder,
        BaseReferences<_$AppDatabase, $RemoteFoldersTable, RemoteFolder>,
      ),
      RemoteFolder,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BroadcastingFoldersTableTableManager get broadcastingFolders =>
      $$BroadcastingFoldersTableTableManager(_db, _db.broadcastingFolders);
  $$RemoteFoldersTableTableManager get remoteFolders =>
      $$RemoteFoldersTableTableManager(_db, _db.remoteFolders);
}

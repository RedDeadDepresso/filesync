import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

class BroadcastingFolders extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v7())();
  TextColumn get name => text().unique()();
  TextColumn get path => text().unique()();

  @override
  Set<Column> get primaryKey => {id};
}

class RemoteFolders extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get localPath => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [BroadcastingFolders, RemoteFolders])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  // Insert
  Future<int> insertBroadcastingFolder(BroadcastingFoldersCompanion entry) =>
      into(broadcastingFolders).insert(entry);

  // Get all (stream for UI updates)
  Stream<List<BroadcastingFolder>> watchBroadcastingFolders() =>
      select(broadcastingFolders).watch();

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}

// This creates a single instance of your database
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  // Clean up the database when the provider is destroyed
  ref.onDispose(() => db.close());

  return db;
});

final broadcastingFoldersProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchBroadcastingFolders();
});

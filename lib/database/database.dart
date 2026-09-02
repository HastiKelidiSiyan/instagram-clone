import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Stories extends Table {
  BoolColumn get seen => boolean().withDefault(const Constant(false))();
  IntColumn get userId => integer()();
  TextColumn get userJson => text()();

    @override
  Set<Column> get primaryKey => {userId};
}

class Posts extends Table {
  IntColumn get userId => integer()();
  TextColumn get userJson => text()();
  TextColumn get subtitle => text()();
  TextColumn get postImage => text()();
  TextColumn get caption => text()();
  TextColumn get likedByJson => text().nullable()();
  IntColumn get totalLikes => integer().withDefault(const Constant(0))();
  IntColumn get totalComments => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {userId};
}

class Messages extends Table {
  IntColumn get userId => integer()();
  TextColumn get userJson => text()();
  TextColumn get lastMessage => text()();
  DateTimeColumn get date => dateTime()();

    @override
  Set<Column> get primaryKey => {userId};
}

@DriftDatabase(tables: [Stories, Posts, Messages])
class AppDatabase extends _$AppDatabase {
  static final AppDatabase instance = AppDatabase();

  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      await migrator.deleteTable('users');
      await migrator.deleteTable('stories');
      await migrator.deleteTable('posts');
      await migrator.deleteTable('messages');
      await migrator.createAll();
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}

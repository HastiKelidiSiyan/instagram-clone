import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Users extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get username => text()();
  TextColumn get avatar => text()();
  IntColumn get totalPosts => integer().withDefault(const Constant(0))();
  IntColumn get totalFollowers => integer().withDefault(const Constant(0))();
  IntColumn get totalFollowings => integer().withDefault(const Constant(0))();
  TextColumn get bio => text()();

    @override
  Set<Column> get primaryKey => {id};
}

class Stories extends Table {
  BoolColumn get seen => boolean().withDefault(const Constant(false))();
  IntColumn get userId => integer()();

    @override
  Set<Column> get primaryKey => {userId};
}

class Posts extends Table {
  IntColumn get userId => integer()();
  TextColumn get subtitle => text()();
  TextColumn get postImage => text()();
  TextColumn get caption => text()();
  IntColumn get likedByUserId => integer()();
  IntColumn get totalLikes => integer().withDefault(const Constant(0))();
  IntColumn get totalComments => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {userId};
}

class Messages extends Table {
  IntColumn get userId => integer()();
  TextColumn get lastMessage => text()();
  DateTimeColumn get date => dateTime()();

    @override
  Set<Column> get primaryKey => {userId};
}

@DriftDatabase(tables: [Users, Stories, Posts, Messages])
class AppDatabase extends _$AppDatabase {
  static final AppDatabase instance = AppDatabase();

  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}

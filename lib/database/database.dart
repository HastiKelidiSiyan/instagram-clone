import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get username => text()();
  TextColumn get name => text()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get bio => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Stories extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get mediaUrl => text()();
  TextColumn get mediaType => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Posts extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get caption => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Messages extends Table {
  TextColumn get id => text()();
  TextColumn get conversationId => text().references(Conversations, #id)();
  TextColumn get senderId => text().references(Users, #id)();
  TextColumn get textContent => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Comments extends Table {
  TextColumn get id => text()();
  TextColumn get postId => text().references(Posts, #id)();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get textContent => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class PostMedia extends Table {
  TextColumn get id => text()();
  TextColumn get postId => text().references(Posts, #id)();
  TextColumn get mediaUrl => text()();
  TextColumn get mediaType => text()();
  IntColumn get position => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class Likes extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get postId => text().references(Posts, #id)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id, postId, userId};
}

class Follows extends Table {
  TextColumn get followerId => text().references(Users, #id)();
  TextColumn get followingId => text().references(Users, #id)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {followerId, followingId};
}

class StoryViews extends Table {
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get storyId => text().references(Stories, #id)();
  DateTimeColumn get viewedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {userId, storyId};
}

class ConversationMembers extends Table {
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get conversationId => text().references(Conversations, #id)();

  @override
  Set<Column> get primaryKey => {userId, conversationId};
}

class Conversations extends Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Stories,
    StoryViews,
    Posts,
    PostMedia,
    Likes,
    Comments,
    Conversations,
    ConversationMembers,
    Messages,
    Users,
    Follows
  ],
)
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
      await migrator.deleteTable('conversations');
      await migrator.deleteTable('likes');
      await migrator.deleteTable('follows');
      await migrator.deleteTable('post_media');
      await migrator.deleteTable('story_views');
      await migrator.deleteTable('conversation_members');
      await migrator.deleteTable('comments');
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

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get username => text().unique()();
  TextColumn get name => text()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get bio => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Stories extends Table {
  TextColumn get id => text()();
  TextColumn get userId =>
      text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get mediaUrl => text()();
  TextColumn get mediaType => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get expiresAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    "CHECK (media_type IN ('image', 'video'))",
    'CHECK (expires_at > created_at)',
  ];
}

class Posts extends Table {
  TextColumn get id => text()();
  TextColumn get userId =>
      text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get caption => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'CHECK (length(trim(caption)) > 0)',
  ];
}

class Messages extends Table {
  TextColumn get id => text()();
  TextColumn get conversationId =>
      text().references(Conversations, #id, onDelete: KeyAction.cascade)();
  TextColumn get senderId =>
      text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get textContent => text().named('text')();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Comments extends Table {
  TextColumn get id => text()();
  TextColumn get postId =>
      text().references(Posts, #id, onDelete: KeyAction.cascade)();
  TextColumn get userId =>
      text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get textContent => text().named('text')();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class PostMedia extends Table {
  TextColumn get id => text()();
  TextColumn get postId =>
      text().references(Posts, #id, onDelete: KeyAction.cascade)();
  TextColumn get mediaUrl => text()();
  TextColumn get mediaType => text()();
  IntColumn get position => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {postId, position},
  ];

  @override
  List<String> get customConstraints => [
    "CHECK (media_type IN ('image', 'video'))",
    'CHECK (position >= 0)',
  ];
}

class Likes extends Table {
  TextColumn get userId =>
      text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get postId =>
      text().references(Posts, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId, postId};
}

class Follows extends Table {
  TextColumn get followerId =>
      text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get followingId =>
      text().references(Users, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {followerId, followingId};

  @override
  List<String> get customConstraints => [
    'CHECK (follower_id <> following_id)',
  ];
}

class StoryViews extends Table {
  TextColumn get userId =>
      text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get storyId =>
      text().references(Stories, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get viewedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId, storyId};
}

class ConversationMembers extends Table {
  TextColumn get userId =>
      text().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get conversationId =>
      text().references(Conversations, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {userId, conversationId};
}

class Conversations extends Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

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
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      await migrator.deleteTable('story_views');
      await migrator.deleteTable('post_media');
      await migrator.deleteTable('likes');
      await migrator.deleteTable('comments');
      await migrator.deleteTable('messages');
      await migrator.deleteTable('conversation_members');
      await migrator.deleteTable('stories');
      await migrator.deleteTable('posts');
      await migrator.deleteTable('conversations');
      await migrator.deleteTable('follows');
      await migrator.deleteTable('users');
      await migrator.createAll();
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
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

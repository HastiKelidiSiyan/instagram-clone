// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
    'avatar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPostsMeta = const VerificationMeta(
    'totalPosts',
  );
  @override
  late final GeneratedColumn<int> totalPosts = GeneratedColumn<int>(
    'total_posts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalFollowersMeta = const VerificationMeta(
    'totalFollowers',
  );
  @override
  late final GeneratedColumn<int> totalFollowers = GeneratedColumn<int>(
    'total_followers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalFollowingsMeta = const VerificationMeta(
    'totalFollowings',
  );
  @override
  late final GeneratedColumn<int> totalFollowings = GeneratedColumn<int>(
    'total_followings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
    'bio',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    username,
    avatar,
    totalPosts,
    totalFollowers,
    totalFollowings,
    bio,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
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
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(
        _avatarMeta,
        avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta),
      );
    } else if (isInserting) {
      context.missing(_avatarMeta);
    }
    if (data.containsKey('total_posts')) {
      context.handle(
        _totalPostsMeta,
        totalPosts.isAcceptableOrUnknown(data['total_posts']!, _totalPostsMeta),
      );
    }
    if (data.containsKey('total_followers')) {
      context.handle(
        _totalFollowersMeta,
        totalFollowers.isAcceptableOrUnknown(
          data['total_followers']!,
          _totalFollowersMeta,
        ),
      );
    }
    if (data.containsKey('total_followings')) {
      context.handle(
        _totalFollowingsMeta,
        totalFollowings.isAcceptableOrUnknown(
          data['total_followings']!,
          _totalFollowingsMeta,
        ),
      );
    }
    if (data.containsKey('bio')) {
      context.handle(
        _bioMeta,
        bio.isAcceptableOrUnknown(data['bio']!, _bioMeta),
      );
    } else if (isInserting) {
      context.missing(_bioMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      avatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar'],
      )!,
      totalPosts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_posts'],
      )!,
      totalFollowers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_followers'],
      )!,
      totalFollowings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_followings'],
      )!,
      bio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bio'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String username;
  final String avatar;
  final int totalPosts;
  final int totalFollowers;
  final int totalFollowings;
  final String bio;
  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.avatar,
    required this.totalPosts,
    required this.totalFollowers,
    required this.totalFollowings,
    required this.bio,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['username'] = Variable<String>(username);
    map['avatar'] = Variable<String>(avatar);
    map['total_posts'] = Variable<int>(totalPosts);
    map['total_followers'] = Variable<int>(totalFollowers);
    map['total_followings'] = Variable<int>(totalFollowings);
    map['bio'] = Variable<String>(bio);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      username: Value(username),
      avatar: Value(avatar),
      totalPosts: Value(totalPosts),
      totalFollowers: Value(totalFollowers),
      totalFollowings: Value(totalFollowings),
      bio: Value(bio),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      username: serializer.fromJson<String>(json['username']),
      avatar: serializer.fromJson<String>(json['avatar']),
      totalPosts: serializer.fromJson<int>(json['totalPosts']),
      totalFollowers: serializer.fromJson<int>(json['totalFollowers']),
      totalFollowings: serializer.fromJson<int>(json['totalFollowings']),
      bio: serializer.fromJson<String>(json['bio']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'username': serializer.toJson<String>(username),
      'avatar': serializer.toJson<String>(avatar),
      'totalPosts': serializer.toJson<int>(totalPosts),
      'totalFollowers': serializer.toJson<int>(totalFollowers),
      'totalFollowings': serializer.toJson<int>(totalFollowings),
      'bio': serializer.toJson<String>(bio),
    };
  }

  User copyWith({
    int? id,
    String? name,
    String? username,
    String? avatar,
    int? totalPosts,
    int? totalFollowers,
    int? totalFollowings,
    String? bio,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    username: username ?? this.username,
    avatar: avatar ?? this.avatar,
    totalPosts: totalPosts ?? this.totalPosts,
    totalFollowers: totalFollowers ?? this.totalFollowers,
    totalFollowings: totalFollowings ?? this.totalFollowings,
    bio: bio ?? this.bio,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      username: data.username.present ? data.username.value : this.username,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      totalPosts: data.totalPosts.present
          ? data.totalPosts.value
          : this.totalPosts,
      totalFollowers: data.totalFollowers.present
          ? data.totalFollowers.value
          : this.totalFollowers,
      totalFollowings: data.totalFollowings.present
          ? data.totalFollowings.value
          : this.totalFollowings,
      bio: data.bio.present ? data.bio.value : this.bio,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('avatar: $avatar, ')
          ..write('totalPosts: $totalPosts, ')
          ..write('totalFollowers: $totalFollowers, ')
          ..write('totalFollowings: $totalFollowings, ')
          ..write('bio: $bio')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    username,
    avatar,
    totalPosts,
    totalFollowers,
    totalFollowings,
    bio,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.username == this.username &&
          other.avatar == this.avatar &&
          other.totalPosts == this.totalPosts &&
          other.totalFollowers == this.totalFollowers &&
          other.totalFollowings == this.totalFollowings &&
          other.bio == this.bio);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> username;
  final Value<String> avatar;
  final Value<int> totalPosts;
  final Value<int> totalFollowers;
  final Value<int> totalFollowings;
  final Value<String> bio;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.username = const Value.absent(),
    this.avatar = const Value.absent(),
    this.totalPosts = const Value.absent(),
    this.totalFollowers = const Value.absent(),
    this.totalFollowings = const Value.absent(),
    this.bio = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String username,
    required String avatar,
    this.totalPosts = const Value.absent(),
    this.totalFollowers = const Value.absent(),
    this.totalFollowings = const Value.absent(),
    required String bio,
  }) : name = Value(name),
       username = Value(username),
       avatar = Value(avatar),
       bio = Value(bio);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? username,
    Expression<String>? avatar,
    Expression<int>? totalPosts,
    Expression<int>? totalFollowers,
    Expression<int>? totalFollowings,
    Expression<String>? bio,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (avatar != null) 'avatar': avatar,
      if (totalPosts != null) 'total_posts': totalPosts,
      if (totalFollowers != null) 'total_followers': totalFollowers,
      if (totalFollowings != null) 'total_followings': totalFollowings,
      if (bio != null) 'bio': bio,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? username,
    Value<String>? avatar,
    Value<int>? totalPosts,
    Value<int>? totalFollowers,
    Value<int>? totalFollowings,
    Value<String>? bio,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      totalPosts: totalPosts ?? this.totalPosts,
      totalFollowers: totalFollowers ?? this.totalFollowers,
      totalFollowings: totalFollowings ?? this.totalFollowings,
      bio: bio ?? this.bio,
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
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (totalPosts.present) {
      map['total_posts'] = Variable<int>(totalPosts.value);
    }
    if (totalFollowers.present) {
      map['total_followers'] = Variable<int>(totalFollowers.value);
    }
    if (totalFollowings.present) {
      map['total_followings'] = Variable<int>(totalFollowings.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('avatar: $avatar, ')
          ..write('totalPosts: $totalPosts, ')
          ..write('totalFollowers: $totalFollowers, ')
          ..write('totalFollowings: $totalFollowings, ')
          ..write('bio: $bio')
          ..write(')'))
        .toString();
  }
}

class $StoriesTable extends Stories with TableInfo<$StoriesTable, Story> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _seenMeta = const VerificationMeta('seen');
  @override
  late final GeneratedColumn<bool> seen = GeneratedColumn<bool>(
    'seen',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("seen" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [seen, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Story> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('seen')) {
      context.handle(
        _seenMeta,
        seen.isAcceptableOrUnknown(data['seen']!, _seenMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  Story map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Story(
      seen: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}seen'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
    );
  }

  @override
  $StoriesTable createAlias(String alias) {
    return $StoriesTable(attachedDatabase, alias);
  }
}

class Story extends DataClass implements Insertable<Story> {
  final bool seen;
  final int userId;
  const Story({required this.seen, required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['seen'] = Variable<bool>(seen);
    map['user_id'] = Variable<int>(userId);
    return map;
  }

  StoriesCompanion toCompanion(bool nullToAbsent) {
    return StoriesCompanion(seen: Value(seen), userId: Value(userId));
  }

  factory Story.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Story(
      seen: serializer.fromJson<bool>(json['seen']),
      userId: serializer.fromJson<int>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'seen': serializer.toJson<bool>(seen),
      'userId': serializer.toJson<int>(userId),
    };
  }

  Story copyWith({bool? seen, int? userId}) =>
      Story(seen: seen ?? this.seen, userId: userId ?? this.userId);
  Story copyWithCompanion(StoriesCompanion data) {
    return Story(
      seen: data.seen.present ? data.seen.value : this.seen,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Story(')
          ..write('seen: $seen, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(seen, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Story &&
          other.seen == this.seen &&
          other.userId == this.userId);
}

class StoriesCompanion extends UpdateCompanion<Story> {
  final Value<bool> seen;
  final Value<int> userId;
  const StoriesCompanion({
    this.seen = const Value.absent(),
    this.userId = const Value.absent(),
  });
  StoriesCompanion.insert({
    this.seen = const Value.absent(),
    this.userId = const Value.absent(),
  });
  static Insertable<Story> custom({
    Expression<bool>? seen,
    Expression<int>? userId,
  }) {
    return RawValuesInsertable({
      if (seen != null) 'seen': seen,
      if (userId != null) 'user_id': userId,
    });
  }

  StoriesCompanion copyWith({Value<bool>? seen, Value<int>? userId}) {
    return StoriesCompanion(
      seen: seen ?? this.seen,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (seen.present) {
      map['seen'] = Variable<bool>(seen.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoriesCompanion(')
          ..write('seen: $seen, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $PostsTable extends Posts with TableInfo<$PostsTable, Post> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PostsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtitleMeta = const VerificationMeta(
    'subtitle',
  );
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
    'subtitle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _postImageMeta = const VerificationMeta(
    'postImage',
  );
  @override
  late final GeneratedColumn<String> postImage = GeneratedColumn<String>(
    'post_image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _likedByUserIdMeta = const VerificationMeta(
    'likedByUserId',
  );
  @override
  late final GeneratedColumn<int> likedByUserId = GeneratedColumn<int>(
    'liked_by_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalLikesMeta = const VerificationMeta(
    'totalLikes',
  );
  @override
  late final GeneratedColumn<int> totalLikes = GeneratedColumn<int>(
    'total_likes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalCommentsMeta = const VerificationMeta(
    'totalComments',
  );
  @override
  late final GeneratedColumn<int> totalComments = GeneratedColumn<int>(
    'total_comments',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    subtitle,
    postImage,
    caption,
    likedByUserId,
    totalLikes,
    totalComments,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'posts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Post> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('subtitle')) {
      context.handle(
        _subtitleMeta,
        subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta),
      );
    } else if (isInserting) {
      context.missing(_subtitleMeta);
    }
    if (data.containsKey('post_image')) {
      context.handle(
        _postImageMeta,
        postImage.isAcceptableOrUnknown(data['post_image']!, _postImageMeta),
      );
    } else if (isInserting) {
      context.missing(_postImageMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
      );
    } else if (isInserting) {
      context.missing(_captionMeta);
    }
    if (data.containsKey('liked_by_user_id')) {
      context.handle(
        _likedByUserIdMeta,
        likedByUserId.isAcceptableOrUnknown(
          data['liked_by_user_id']!,
          _likedByUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_likedByUserIdMeta);
    }
    if (data.containsKey('total_likes')) {
      context.handle(
        _totalLikesMeta,
        totalLikes.isAcceptableOrUnknown(data['total_likes']!, _totalLikesMeta),
      );
    }
    if (data.containsKey('total_comments')) {
      context.handle(
        _totalCommentsMeta,
        totalComments.isAcceptableOrUnknown(
          data['total_comments']!,
          _totalCommentsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  Post map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Post(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      subtitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtitle'],
      )!,
      postImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}post_image'],
      )!,
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      )!,
      likedByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}liked_by_user_id'],
      )!,
      totalLikes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_likes'],
      )!,
      totalComments: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_comments'],
      )!,
    );
  }

  @override
  $PostsTable createAlias(String alias) {
    return $PostsTable(attachedDatabase, alias);
  }
}

class Post extends DataClass implements Insertable<Post> {
  final int userId;
  final String subtitle;
  final String postImage;
  final String caption;
  final int likedByUserId;
  final int totalLikes;
  final int totalComments;
  const Post({
    required this.userId,
    required this.subtitle,
    required this.postImage,
    required this.caption,
    required this.likedByUserId,
    required this.totalLikes,
    required this.totalComments,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<int>(userId);
    map['subtitle'] = Variable<String>(subtitle);
    map['post_image'] = Variable<String>(postImage);
    map['caption'] = Variable<String>(caption);
    map['liked_by_user_id'] = Variable<int>(likedByUserId);
    map['total_likes'] = Variable<int>(totalLikes);
    map['total_comments'] = Variable<int>(totalComments);
    return map;
  }

  PostsCompanion toCompanion(bool nullToAbsent) {
    return PostsCompanion(
      userId: Value(userId),
      subtitle: Value(subtitle),
      postImage: Value(postImage),
      caption: Value(caption),
      likedByUserId: Value(likedByUserId),
      totalLikes: Value(totalLikes),
      totalComments: Value(totalComments),
    );
  }

  factory Post.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Post(
      userId: serializer.fromJson<int>(json['userId']),
      subtitle: serializer.fromJson<String>(json['subtitle']),
      postImage: serializer.fromJson<String>(json['postImage']),
      caption: serializer.fromJson<String>(json['caption']),
      likedByUserId: serializer.fromJson<int>(json['likedByUserId']),
      totalLikes: serializer.fromJson<int>(json['totalLikes']),
      totalComments: serializer.fromJson<int>(json['totalComments']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<int>(userId),
      'subtitle': serializer.toJson<String>(subtitle),
      'postImage': serializer.toJson<String>(postImage),
      'caption': serializer.toJson<String>(caption),
      'likedByUserId': serializer.toJson<int>(likedByUserId),
      'totalLikes': serializer.toJson<int>(totalLikes),
      'totalComments': serializer.toJson<int>(totalComments),
    };
  }

  Post copyWith({
    int? userId,
    String? subtitle,
    String? postImage,
    String? caption,
    int? likedByUserId,
    int? totalLikes,
    int? totalComments,
  }) => Post(
    userId: userId ?? this.userId,
    subtitle: subtitle ?? this.subtitle,
    postImage: postImage ?? this.postImage,
    caption: caption ?? this.caption,
    likedByUserId: likedByUserId ?? this.likedByUserId,
    totalLikes: totalLikes ?? this.totalLikes,
    totalComments: totalComments ?? this.totalComments,
  );
  Post copyWithCompanion(PostsCompanion data) {
    return Post(
      userId: data.userId.present ? data.userId.value : this.userId,
      subtitle: data.subtitle.present ? data.subtitle.value : this.subtitle,
      postImage: data.postImage.present ? data.postImage.value : this.postImage,
      caption: data.caption.present ? data.caption.value : this.caption,
      likedByUserId: data.likedByUserId.present
          ? data.likedByUserId.value
          : this.likedByUserId,
      totalLikes: data.totalLikes.present
          ? data.totalLikes.value
          : this.totalLikes,
      totalComments: data.totalComments.present
          ? data.totalComments.value
          : this.totalComments,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Post(')
          ..write('userId: $userId, ')
          ..write('subtitle: $subtitle, ')
          ..write('postImage: $postImage, ')
          ..write('caption: $caption, ')
          ..write('likedByUserId: $likedByUserId, ')
          ..write('totalLikes: $totalLikes, ')
          ..write('totalComments: $totalComments')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    subtitle,
    postImage,
    caption,
    likedByUserId,
    totalLikes,
    totalComments,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Post &&
          other.userId == this.userId &&
          other.subtitle == this.subtitle &&
          other.postImage == this.postImage &&
          other.caption == this.caption &&
          other.likedByUserId == this.likedByUserId &&
          other.totalLikes == this.totalLikes &&
          other.totalComments == this.totalComments);
}

class PostsCompanion extends UpdateCompanion<Post> {
  final Value<int> userId;
  final Value<String> subtitle;
  final Value<String> postImage;
  final Value<String> caption;
  final Value<int> likedByUserId;
  final Value<int> totalLikes;
  final Value<int> totalComments;
  const PostsCompanion({
    this.userId = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.postImage = const Value.absent(),
    this.caption = const Value.absent(),
    this.likedByUserId = const Value.absent(),
    this.totalLikes = const Value.absent(),
    this.totalComments = const Value.absent(),
  });
  PostsCompanion.insert({
    this.userId = const Value.absent(),
    required String subtitle,
    required String postImage,
    required String caption,
    required int likedByUserId,
    this.totalLikes = const Value.absent(),
    this.totalComments = const Value.absent(),
  }) : subtitle = Value(subtitle),
       postImage = Value(postImage),
       caption = Value(caption),
       likedByUserId = Value(likedByUserId);
  static Insertable<Post> custom({
    Expression<int>? userId,
    Expression<String>? subtitle,
    Expression<String>? postImage,
    Expression<String>? caption,
    Expression<int>? likedByUserId,
    Expression<int>? totalLikes,
    Expression<int>? totalComments,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (subtitle != null) 'subtitle': subtitle,
      if (postImage != null) 'post_image': postImage,
      if (caption != null) 'caption': caption,
      if (likedByUserId != null) 'liked_by_user_id': likedByUserId,
      if (totalLikes != null) 'total_likes': totalLikes,
      if (totalComments != null) 'total_comments': totalComments,
    });
  }

  PostsCompanion copyWith({
    Value<int>? userId,
    Value<String>? subtitle,
    Value<String>? postImage,
    Value<String>? caption,
    Value<int>? likedByUserId,
    Value<int>? totalLikes,
    Value<int>? totalComments,
  }) {
    return PostsCompanion(
      userId: userId ?? this.userId,
      subtitle: subtitle ?? this.subtitle,
      postImage: postImage ?? this.postImage,
      caption: caption ?? this.caption,
      likedByUserId: likedByUserId ?? this.likedByUserId,
      totalLikes: totalLikes ?? this.totalLikes,
      totalComments: totalComments ?? this.totalComments,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (postImage.present) {
      map['post_image'] = Variable<String>(postImage.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (likedByUserId.present) {
      map['liked_by_user_id'] = Variable<int>(likedByUserId.value);
    }
    if (totalLikes.present) {
      map['total_likes'] = Variable<int>(totalLikes.value);
    }
    if (totalComments.present) {
      map['total_comments'] = Variable<int>(totalComments.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostsCompanion(')
          ..write('userId: $userId, ')
          ..write('subtitle: $subtitle, ')
          ..write('postImage: $postImage, ')
          ..write('caption: $caption, ')
          ..write('likedByUserId: $likedByUserId, ')
          ..write('totalLikes: $totalLikes, ')
          ..write('totalComments: $totalComments')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastMessageMeta = const VerificationMeta(
    'lastMessage',
  );
  @override
  late final GeneratedColumn<String> lastMessage = GeneratedColumn<String>(
    'last_message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [userId, lastMessage, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Message> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('last_message')) {
      context.handle(
        _lastMessageMeta,
        lastMessage.isAcceptableOrUnknown(
          data['last_message']!,
          _lastMessageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastMessageMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      lastMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final int userId;
  final String lastMessage;
  final DateTime date;
  const Message({
    required this.userId,
    required this.lastMessage,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<int>(userId);
    map['last_message'] = Variable<String>(lastMessage);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      userId: Value(userId),
      lastMessage: Value(lastMessage),
      date: Value(date),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      userId: serializer.fromJson<int>(json['userId']),
      lastMessage: serializer.fromJson<String>(json['lastMessage']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<int>(userId),
      'lastMessage': serializer.toJson<String>(lastMessage),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Message copyWith({int? userId, String? lastMessage, DateTime? date}) =>
      Message(
        userId: userId ?? this.userId,
        lastMessage: lastMessage ?? this.lastMessage,
        date: date ?? this.date,
      );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      userId: data.userId.present ? data.userId.value : this.userId,
      lastMessage: data.lastMessage.present
          ? data.lastMessage.value
          : this.lastMessage,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('userId: $userId, ')
          ..write('lastMessage: $lastMessage, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, lastMessage, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.userId == this.userId &&
          other.lastMessage == this.lastMessage &&
          other.date == this.date);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> userId;
  final Value<String> lastMessage;
  final Value<DateTime> date;
  final Value<int> rowid;
  const MessagesCompanion({
    this.userId = const Value.absent(),
    this.lastMessage = const Value.absent(),
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required int userId,
    required String lastMessage,
    required DateTime date,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       lastMessage = Value(lastMessage),
       date = Value(date);
  static Insertable<Message> custom({
    Expression<int>? userId,
    Expression<String>? lastMessage,
    Expression<DateTime>? date,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (lastMessage != null) 'last_message': lastMessage,
      if (date != null) 'date': date,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith({
    Value<int>? userId,
    Value<String>? lastMessage,
    Value<DateTime>? date,
    Value<int>? rowid,
  }) {
    return MessagesCompanion(
      userId: userId ?? this.userId,
      lastMessage: lastMessage ?? this.lastMessage,
      date: date ?? this.date,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (lastMessage.present) {
      map['last_message'] = Variable<String>(lastMessage.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('userId: $userId, ')
          ..write('lastMessage: $lastMessage, ')
          ..write('date: $date, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $StoriesTable stories = $StoriesTable(this);
  late final $PostsTable posts = $PostsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    stories,
    posts,
    messages,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String name,
      required String username,
      required String avatar,
      Value<int> totalPosts,
      Value<int> totalFollowers,
      Value<int> totalFollowings,
      required String bio,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> username,
      Value<String> avatar,
      Value<int> totalPosts,
      Value<int> totalFollowers,
      Value<int> totalFollowings,
      Value<String> bio,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
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

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPosts => $composableBuilder(
    column: $table.totalPosts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalFollowers => $composableBuilder(
    column: $table.totalFollowers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalFollowings => $composableBuilder(
    column: $table.totalFollowings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
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

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPosts => $composableBuilder(
    column: $table.totalPosts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalFollowers => $composableBuilder(
    column: $table.totalFollowers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalFollowings => $composableBuilder(
    column: $table.totalFollowings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
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

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<int> get totalPosts => $composableBuilder(
    column: $table.totalPosts,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalFollowers => $composableBuilder(
    column: $table.totalFollowers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalFollowings => $composableBuilder(
    column: $table.totalFollowings,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> avatar = const Value.absent(),
                Value<int> totalPosts = const Value.absent(),
                Value<int> totalFollowers = const Value.absent(),
                Value<int> totalFollowings = const Value.absent(),
                Value<String> bio = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                username: username,
                avatar: avatar,
                totalPosts: totalPosts,
                totalFollowers: totalFollowers,
                totalFollowings: totalFollowings,
                bio: bio,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String username,
                required String avatar,
                Value<int> totalPosts = const Value.absent(),
                Value<int> totalFollowers = const Value.absent(),
                Value<int> totalFollowings = const Value.absent(),
                required String bio,
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                username: username,
                avatar: avatar,
                totalPosts: totalPosts,
                totalFollowers: totalFollowers,
                totalFollowings: totalFollowings,
                bio: bio,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$StoriesTableCreateCompanionBuilder =
    StoriesCompanion Function({Value<bool> seen, Value<int> userId});
typedef $$StoriesTableUpdateCompanionBuilder =
    StoriesCompanion Function({Value<bool> seen, Value<int> userId});

class $$StoriesTableFilterComposer
    extends Composer<_$AppDatabase, $StoriesTable> {
  $$StoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get seen => $composableBuilder(
    column: $table.seen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $StoriesTable> {
  $$StoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get seen => $composableBuilder(
    column: $table.seen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoriesTable> {
  $$StoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get seen =>
      $composableBuilder(column: $table.seen, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);
}

class $$StoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoriesTable,
          Story,
          $$StoriesTableFilterComposer,
          $$StoriesTableOrderingComposer,
          $$StoriesTableAnnotationComposer,
          $$StoriesTableCreateCompanionBuilder,
          $$StoriesTableUpdateCompanionBuilder,
          (Story, BaseReferences<_$AppDatabase, $StoriesTable, Story>),
          Story,
          PrefetchHooks Function()
        > {
  $$StoriesTableTableManager(_$AppDatabase db, $StoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<bool> seen = const Value.absent(),
                Value<int> userId = const Value.absent(),
              }) => StoriesCompanion(seen: seen, userId: userId),
          createCompanionCallback:
              ({
                Value<bool> seen = const Value.absent(),
                Value<int> userId = const Value.absent(),
              }) => StoriesCompanion.insert(seen: seen, userId: userId),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoriesTable,
      Story,
      $$StoriesTableFilterComposer,
      $$StoriesTableOrderingComposer,
      $$StoriesTableAnnotationComposer,
      $$StoriesTableCreateCompanionBuilder,
      $$StoriesTableUpdateCompanionBuilder,
      (Story, BaseReferences<_$AppDatabase, $StoriesTable, Story>),
      Story,
      PrefetchHooks Function()
    >;
typedef $$PostsTableCreateCompanionBuilder =
    PostsCompanion Function({
      Value<int> userId,
      required String subtitle,
      required String postImage,
      required String caption,
      required int likedByUserId,
      Value<int> totalLikes,
      Value<int> totalComments,
    });
typedef $$PostsTableUpdateCompanionBuilder =
    PostsCompanion Function({
      Value<int> userId,
      Value<String> subtitle,
      Value<String> postImage,
      Value<String> caption,
      Value<int> likedByUserId,
      Value<int> totalLikes,
      Value<int> totalComments,
    });

class $$PostsTableFilterComposer extends Composer<_$AppDatabase, $PostsTable> {
  $$PostsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postImage => $composableBuilder(
    column: $table.postImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get likedByUserId => $composableBuilder(
    column: $table.likedByUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalLikes => $composableBuilder(
    column: $table.totalLikes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalComments => $composableBuilder(
    column: $table.totalComments,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PostsTableOrderingComposer
    extends Composer<_$AppDatabase, $PostsTable> {
  $$PostsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postImage => $composableBuilder(
    column: $table.postImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get likedByUserId => $composableBuilder(
    column: $table.likedByUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalLikes => $composableBuilder(
    column: $table.totalLikes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalComments => $composableBuilder(
    column: $table.totalComments,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PostsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PostsTable> {
  $$PostsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get subtitle =>
      $composableBuilder(column: $table.subtitle, builder: (column) => column);

  GeneratedColumn<String> get postImage =>
      $composableBuilder(column: $table.postImage, builder: (column) => column);

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  GeneratedColumn<int> get likedByUserId => $composableBuilder(
    column: $table.likedByUserId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalLikes => $composableBuilder(
    column: $table.totalLikes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalComments => $composableBuilder(
    column: $table.totalComments,
    builder: (column) => column,
  );
}

class $$PostsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PostsTable,
          Post,
          $$PostsTableFilterComposer,
          $$PostsTableOrderingComposer,
          $$PostsTableAnnotationComposer,
          $$PostsTableCreateCompanionBuilder,
          $$PostsTableUpdateCompanionBuilder,
          (Post, BaseReferences<_$AppDatabase, $PostsTable, Post>),
          Post,
          PrefetchHooks Function()
        > {
  $$PostsTableTableManager(_$AppDatabase db, $PostsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PostsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PostsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PostsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> userId = const Value.absent(),
                Value<String> subtitle = const Value.absent(),
                Value<String> postImage = const Value.absent(),
                Value<String> caption = const Value.absent(),
                Value<int> likedByUserId = const Value.absent(),
                Value<int> totalLikes = const Value.absent(),
                Value<int> totalComments = const Value.absent(),
              }) => PostsCompanion(
                userId: userId,
                subtitle: subtitle,
                postImage: postImage,
                caption: caption,
                likedByUserId: likedByUserId,
                totalLikes: totalLikes,
                totalComments: totalComments,
              ),
          createCompanionCallback:
              ({
                Value<int> userId = const Value.absent(),
                required String subtitle,
                required String postImage,
                required String caption,
                required int likedByUserId,
                Value<int> totalLikes = const Value.absent(),
                Value<int> totalComments = const Value.absent(),
              }) => PostsCompanion.insert(
                userId: userId,
                subtitle: subtitle,
                postImage: postImage,
                caption: caption,
                likedByUserId: likedByUserId,
                totalLikes: totalLikes,
                totalComments: totalComments,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PostsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PostsTable,
      Post,
      $$PostsTableFilterComposer,
      $$PostsTableOrderingComposer,
      $$PostsTableAnnotationComposer,
      $$PostsTableCreateCompanionBuilder,
      $$PostsTableUpdateCompanionBuilder,
      (Post, BaseReferences<_$AppDatabase, $PostsTable, Post>),
      Post,
      PrefetchHooks Function()
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      required int userId,
      required String lastMessage,
      required DateTime date,
      Value<int> rowid,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> userId,
      Value<String> lastMessage,
      Value<DateTime> date,
      Value<int> rowid,
    });

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          Message,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
          Message,
          PrefetchHooks Function()
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> userId = const Value.absent(),
                Value<String> lastMessage = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion(
                userId: userId,
                lastMessage: lastMessage,
                date: date,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int userId,
                required String lastMessage,
                required DateTime date,
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion.insert(
                userId: userId,
                lastMessage: lastMessage,
                date: date,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessagesTable,
      Message,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
      Message,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$StoriesTableTableManager get stories =>
      $$StoriesTableTableManager(_db, _db.stories);
  $$PostsTableTableManager get posts =>
      $$PostsTableTableManager(_db, _db.posts);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
}

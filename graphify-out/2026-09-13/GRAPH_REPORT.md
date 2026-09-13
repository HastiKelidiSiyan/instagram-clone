# Graph Report - instagram_clone  (2026-09-13)

## Corpus Check
- 72 files · ~90,871 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 682 nodes · 849 edges · 61 communities (31 shown, 26 thin omitted)
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 18 edges (avg confidence: 0.85)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `233c0b4d`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- database.dart
- Win32Window
- GeneratedPluginRegistrant.swift
- user_repository.dart
- post_model.dart
- local_data_source.dart
- main.dart
- signup_screen.dart
- my_application.cc
- home_screen.dart
- remote_data_source.dart
- profile_screen.dart
- directs_screen.dart
- loading_screen.dart
- wWinMain
- Message
- manifest.json
- app_failure.dart
- login_screen.dart
- What You Must Do When Invoked
- package:flutter/material.dart
- instagram.dart
- Table
- app_feedback.dart
- MainActivity.kt
- avatar
- bio
- caption
- date
- lastMessage
- likedByJson
- name
- postImage
- seen
- subtitle
- totalComments
- totalFollowers
- totalFollowings
- totalLikes
- totalPosts
- userId
- userJson
- username
- String?
- State
- graphify reference: extra exports and benchmark
- app_icon.dart
- graphify reference: query, path, explain
- graphify reference: add a URL and watch a folder
- graphify reference: commit hook and native CLAUDE.md integration
- graphify reference: incremental update and cluster-only
- graphify reference: GitHub clone and cross-repo merge
- graphify reference: transcribe video and audio
- instagram_clone
- AGENTS.md
- extraction-spec.md
- LaunchImage.imageset/README.md

## God Nodes (most connected - your core abstractions)
1. `Win32Window` - 24 edges
2. `MessageHandler` - 12 edges
3. `What You Must Do When Invoked` - 12 edges
4. `FlutterWindow` - 10 edges
5. `Create` - 10 edges
6. `WndProc` - 10 edges
7. `/graphify` - 10 edges
8. `UserModel` - 9 edges
9. `MessageHandler` - 9 edges
10. `AppFailure` - 8 edges

## Surprising Connections (you probably didn't know these)
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  windows/runner/main.cpp → windows/runner/utils.cpp
- `Win32Window::Win32Window()` --calls--> `Destroy`  [INFERRED]
  windows/runner/win32_window.cpp → windows/runner/win32_window.h
- `my_application_activate()` --calls--> `fl_register_plugins()`  [INFERRED]
  linux/runner/my_application.cc → linux/flutter/generated_plugin_registrant.cc
- `main()` --calls--> `my_application_new()`  [INFERRED]
  linux/runner/main.cc → linux/runner/my_application.cc
- `OnCreate` --calls--> `RegisterPlugins()`  [INFERRED]
  windows/runner/flutter_window.h → windows/flutter/generated_plugin_registrant.cc

## Import Cycles
- None detected.

## Communities (61 total, 26 thin omitted)

### Community 0 - "database.dart"
Cohesion: 0.03
Nodes (78): BoolColumn get, _, actualTableName, _alias, aliasedName, allSchemaEntities, allTables, attachedDatabase (+70 more)

### Community 1 - "Win32Window"
Cohesion: 0.05
Nodes (57): PluginRegistry, RECT, unique_ptr, RegisterPlugins(), DartProject, HWND, LPARAM, LRESULT (+49 more)

### Community 2 - "GeneratedPluginRegistrant.swift"
Cohesion: 0.06
Nodes (29): Any, Cocoa, connectivity_plus, Flutter, FlutterAppDelegate, FlutterImplicitEngineBridge, FlutterImplicitEngineDelegate, FlutterMacOS (+21 more)

### Community 3 - "user_repository.dart"
Cohesion: 0.07
Nodes (36): LocalDataSource, RemoteDataSource, connectivityResult, getMessages, localDataSource, MessageRepository, remoteDataSource, connectivityResult (+28 more)

### Community 4 - "post_model.dart"
Cohesion: 0.06
Nodes (34): DateTime, date, fromJson, lastMessage, MessageModel, toJson, user, caption (+26 more)

### Community 5 - "local_data_source.dart"
Cohesion: 0.10
Nodes (19): _, @DriftDatabase, dart:convert, cacheMe, cacheMessages, cachePosts, cacheStories, database (+11 more)

### Community 6 - "main.dart"
Cohesion: 0.20
Nodes (9): build, checkLoginStatus, createState, initState, main, package:get/get.dart, package:instagram_clone/ui/loading_screen.dart, package:instagram_clone/ui/login_screen.dart (+1 more)

### Community 7 - "signup_screen.dart"
Cohesion: 0.06
Nodes (30): int?, build, _checkboxValue, countries, _countryError, createState, dispose, _emailController (+22 more)

### Community 8 - "my_application.cc"
Cohesion: 0.09
Nodes (22): FlPluginRegistry, FlView, GApplication, gboolean, gchar, GObject, GtkApplication, fl_register_plugins() (+14 more)

### Community 9 - "home_screen.dart"
Cohesion: 0.10
Nodes (20): build, createState, _homeAppBar, _homeBody, HomeProfile, HomeScreen, _HomeScreenState, imageUrl (+12 more)

### Community 10 - "remote_data_source.dart"
Cohesion: 0.06
Nodes (34): Dio, addUser, currentUserBaseUrl, _dio, getMessages, getPosts, getStories, getUserById (+26 more)

### Community 11 - "profile_screen.dart"
Cohesion: 0.09
Nodes (24): build, content, _editProfileButton, highlightImages, HighlightProfiles, _highlights, imageUrl, label (+16 more)

### Community 12 - "directs_screen.dart"
Cohesion: 0.13
Nodes (15): Future, build, createState, _dierctsAppBar, _directsList, DirectsScreen, _DirectsScreenState, _footer (+7 more)

### Community 14 - "loading_screen.dart"
Cohesion: 0.17
Nodes (12): build, content, createState, initState, LoadingScreen, _LoadingScreenState, _loadUser, user (+4 more)

### Community 15 - "wWinMain"
Cohesion: 0.24
Nodes (9): _In_, _In_opt_, vector, wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments() (+1 more)

### Community 16 - "Message"
Cohesion: 0.29
Nodes (11): Message, MessagesCompanion, Post, PostsCompanion, StoriesCompanion, Story, User, UsersCompanion (+3 more)

### Community 17 - "manifest.json"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 18 - "app_failure.dart"
Cohesion: 0.33
Nodes (9): Exception, AppFailure, BadCertificateFailure, failureMessage, NetworkFailure, RequestCancelledFailure, ServerFailure, TimeoutFailure (+1 more)

### Community 19 - "login_screen.dart"
Cohesion: 0.09
Nodes (21): Color, _bottomSection, build, _checkboxValue, createState, _customeDivider, dispose, _isUserValid (+13 more)

### Community 20 - "What You Must Do When Invoked"
Cohesion: 0.08
Nodes (24): For /graphify add and --watch, For /graphify query, For the commit hook and native CLAUDE.md integration, For --update and --cluster-only, /graphify, Honesty Rules, Interpreter guard for subcommands, Part A - Structural extraction for code files (+16 more)

### Community 21 - "package:flutter/material.dart"
Cohesion: 0.40
Nodes (4): package:flutter/material.dart, package:flutter_test/flutter_test.dart, package:instagram_clone/main.dart, main

### Community 22 - "instagram.dart"
Cohesion: 0.09
Nodes (22): build, createState, handleProfileTap, index, Instagram, _InstagramState, me, build (+14 more)

### Community 23 - "Table"
Cohesion: 0.40
Nodes (5): Messages, Posts, Stories, Users, Table

### Community 24 - "app_feedback.dart"
Cohesion: 0.40
Nodes (4): AppFeedback, showException, showFailure, package:instagram_clone/models/app_failure.dart

### Community 49 - "State"
Cohesion: 0.32
Nodes (8): SplashScreen, _SplashScreenState, LoginScreen, _LoginScreenState, SignupFormWithButtons, _SignupFormWithButtonsState, State, StatefulWidget

### Community 50 - "graphify reference: extra exports and benchmark"
Cohesion: 0.22
Nodes (8): graphify reference: extra exports and benchmark, Step 6b - Wiki (only if --wiki flag), Step 7 - Neo4j export (only if --neo4j or --neo4j-push flag), Step 7a - FalkorDB export (only if --falkordb or --falkordb-push flag), Step 7b - SVG export (only if --svg flag), Step 7c - GraphML export (only if --graphml flag), Step 7d - MCP server (only if --mcp flag), Step 8 - Token reduction benchmark (only if total_words > 5000)

### Community 51 - "app_icon.dart"
Cohesion: 0.29
Nodes (6): double?, AppIcon, asset, build, height, width

### Community 52 - "graphify reference: query, path, explain"
Cohesion: 0.33
Nodes (5): For /graphify explain, For /graphify path, graphify reference: query, path, explain, Step 0 — Constrained query expansion (REQUIRED before traversal), Step 1 — Traversal

### Community 53 - "graphify reference: add a URL and watch a folder"
Cohesion: 0.50
Nodes (3): For /graphify add, For --watch, graphify reference: add a URL and watch a folder

### Community 54 - "graphify reference: commit hook and native CLAUDE.md integration"
Cohesion: 0.50
Nodes (3): For git commit hook, For native CLAUDE.md integration, graphify reference: commit hook and native CLAUDE.md integration

### Community 55 - "graphify reference: incremental update and cluster-only"
Cohesion: 0.50
Nodes (3): For --cluster-only, For --update (incremental re-extraction), graphify reference: incremental update and cluster-only

## Knowledge Gaps
- **357 isolated node(s):** `database`, `cacheMe`, `getMe`, `getPosts`, `cachePosts` (+352 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 457 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **26 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `UserModel` connect `post_model.dart` to `home_screen.dart`, `profile_screen.dart`, `directs_screen.dart`, `loading_screen.dart`, `instagram.dart`?**
  _High betweenness centrality (0.056) - this node is a cross-community bridge._
- **Why does `AppDatabase` connect `local_data_source.dart` to `database.dart`?**
  _High betweenness centrality (0.025) - this node is a cross-community bridge._
- **Why does `LocalDataSource` connect `user_repository.dart` to `local_data_source.dart`?**
  _High betweenness centrality (0.020) - this node is a cross-community bridge._
- **Are the 4 inferred relationships involving `MessageHandler` (e.g. with `Destroy` and `GetClientArea`) actually correct?**
  _`MessageHandler` has 4 INFERRED edges - model-reasoned connections that need verification._
- **What connects `database`, `cacheMe`, `getMe` to the rest of the system?**
  _357 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `database.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.02531645569620253 - nodes in this community are weakly interconnected._
- **Should `Win32Window` be split into smaller, more focused modules?**
  _Cohesion score 0.05311676909569798 - nodes in this community are weakly interconnected._
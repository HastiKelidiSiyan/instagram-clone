import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/domain/home_post.dart';
import 'package:instagram_clone/models/domain/home_story.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/ui/app_icon.dart';
import 'package:instagram_clone/ui/app_feedback.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/ui/directs_screen.dart';
import 'package:instagram_clone/models/app_failure.dart';
import 'package:instagram_clone/widgets/story_item.dart';
import 'package:instagram_clone/widgets/post_list_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:instagram_clone/repositories/post_repository.dart';
import 'package:instagram_clone/repositories/story_repository.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.onProfileTap,
  });

  final Function(int) onProfileTap;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<HomePostModel>> posts = Future.value([]);
  Future<List<StoryGroupModel>> stories = Future.value([]);
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentUserId = context.watch<UserProvider>().currentUser?.id;
    if (currentUserId == null || currentUserId == _currentUserId) return;
    _currentUserId = currentUserId;
    _loadScreenData(currentUserId);
  }

  void _loadScreenData(String currentUserId) {
    posts = PostRepository().getHomePosts(currentUserId);
    stories = StoryRepository().getStoryGroups(currentUserId);
  }

  Future<void> _refreshFeed() async {
    final userId = _currentUserId;
    if (userId == null) return;
    setState(() {
      posts = PostRepository().getHomePosts(userId);
    });
  }

  Future<void> _refreshStories() async {
    final userId = _currentUserId;
    if (userId == null) return;
    setState(() {
      stories = StoryRepository().getStoryGroups(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<UserProvider>().currentUser;
    if (currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: _homeAppBar(currentUser),
      body: _homeBody(
        currentUser,
        widget.onProfileTap,
        posts,
        stories,
        _refreshFeed,
        _refreshStories,
      ),
    );
  }

  PreferredSizeWidget _homeAppBar(UserModel me) {
    return AppBar(
      toolbarHeight: 44,
      titleSpacing: 0,
      leadingWidth: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        child: Row(
          children: [
            AppIcon(
              asset: "assets/images/InstagramLogo.png",
              height: 36,
              width: 100,
            ),
            Spacer(),
            Row(
              children: [
                AppIcon(
                  asset: "assets/images/AddIcon.png",
                  height: 17,
                  width: 17,
                ),
                SizedBox(width: 16),
                AppIcon(
                  asset: "assets/images/HeartIcon.png",
                  height: 17,
                  width: 17,
                ),
                SizedBox(width: 16),
                InkWell(
                  child: AppIcon(
                    asset: "assets/images/DirectIcon.png",
                    height: 17,
                    width: 17,
                  ),
                  onTap: () {
                    Get.to(() => DirectsScreen());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeBody(
    UserModel me,
    Function(int) onProfileTap,
    Future<List<HomePostModel>>? postsFuture,
    Future<List<StoryGroupModel>>? storiesFuture,
    Future<void> Function() refreshPosts,
    Future<void> Function() refreshStories,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _storiesSection(me, onProfileTap, storiesFuture, refreshStories),
        Container(height: 1, color: Color(0xffcecece)),
        Expanded(
          child: _postsSection(me, onProfileTap, postsFuture, refreshPosts),
        ),
      ],
    );
  }

  Widget _postsSection(
    UserModel me,
    Function(int) onProfileTap,
    Future<List<HomePostModel>>? postsFuture,
    Future<void> Function() refreshPosts,
  ) {
    return RefreshIndicator(
      onRefresh: refreshPosts,
      child: FutureBuilder(
        future: postsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return PostListItem(
                  feedItem: snapshot.data![index],
                  onProfileTap: onProfileTap,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 0, width: 0);
              },
              itemCount: snapshot.data!.length,
            );
          } else if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (snapshot.error is AppFailure) {
                AppFeedback.showFailure(context, snapshot.error as AppFailure);
              } else {
                AppFeedback.showException(context, snapshot.error.toString());
              }
            });
            return Center(
              child: IconButton(
                onPressed: refreshPosts,
                icon: Icon(Icons.refresh),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _storiesSection(
    UserModel currentUser,
    Function(int) onProfileTap,
    Future<List<StoryGroupModel>>? storiesFuture,
    Future<void> Function() refreshStories,
  ) {
    return SizedBox(
      height: 97,
      child: RefreshIndicator(
        onRefresh: refreshStories,
        child: FutureBuilder(
          future: storiesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return HomeProfile(
                      imageUrl: currentUser.avatarUrl,
                      label: "Your Story",
                    );
                  } else {
                    final item = snapshot.data![index - 1];
                    return StoryItem(
                      storyItem: item,
                      onTap: () => onProfileTap(index - 1),
                      radius: 25,
                      isDirect: false,
                    );
                  }
                },
              );
            } else if (snapshot.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (snapshot.error is AppFailure) {
                  AppFeedback.showFailure(
                    context,
                    snapshot.error as AppFailure,
                  );
                } else {
                  AppFeedback.showException(context, snapshot.error.toString());
                }
              });
              return Center(
                child: IconButton(
                  onPressed: refreshStories,
                  icon: Icon(Icons.refresh),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class HomeProfile extends StatelessWidget {
  final String? imageUrl;
  final String label;

  const HomeProfile({super.key, required this.imageUrl, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentGeometry.center,
            children: [
              SizedBox(width: 58, height: 58),
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl ?? '',
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

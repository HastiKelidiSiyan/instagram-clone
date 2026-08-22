import 'package:flutter/material.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/repositories/post_repository.dart';
import 'package:instagram_clone/repositories/story_repository.dart';
import '../models/post_model.dart';

class HomeBody extends StatelessWidget {
  final Function(int) onProfileTap;
  final dynamic me;

  const HomeBody({super.key, required this.me, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        HomeStories(me: me, onProfileTap: onProfileTap),
        Container(height: 1, color: Color(0xffcecece)),
        Expanded(child: PostBody(onProfileTap: onProfileTap)),
      ],
    );
  }
}

class PostBody extends StatelessWidget {
  final Function(int) onProfileTap;

  const PostBody({super.key, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PostRepository().getPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return HomePost(
                post: snapshot.data![index],
                onProfileTap: onProfileTap,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 0, width: 0);
            },
            itemCount: snapshot.data!.length,
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class HomePost extends StatelessWidget {
  final PostModel post;
  final Function(int) onProfileTap;

  const HomePost({super.key, required this.post, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostInfo(post: post, onProfileTap: onProfileTap),
        SizedBox(height: 4),
        PostContents(post: post),
        SizedBox(height: 4),
        PostBottom(post: post, onProfileTap: onProfileTap),
      ],
    );
  }
}

class NavigationBar extends StatelessWidget {
  final dynamic me;

  const NavigationBar(this.me, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Column(
        children: [
          Container(height: 1, color: Color(0xffcecece)),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/HomeIcon.png",
                  height: 20,
                  width: 20,
                ),
                SizedBox(width: 58),
                Image.asset(
                  "assets/images/SearchIcon.png",
                  height: 20,
                  width: 20,
                ),
                SizedBox(width: 58),
                Image.asset(
                  "assets/images/ReelsIcon.png",
                  height: 20,
                  width: 20,
                ),
                SizedBox(width: 58),
                Image.asset(
                  "assets/images/ShopIcon.png",
                  height: 20,
                  width: 20,
                ),
                SizedBox(width: 58),
                CircleAvatar(
                  radius: 9,
                  backgroundImage: NetworkImage(me.avatar),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostBottom extends StatelessWidget {
  final PostModel post;
  final Function(int) onProfileTap;

  const PostBottom({super.key, required this.post, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostButtons(),
          SizedBox(height: 4),
          PostExtraInfo(post: post, onProfileTap: onProfileTap),
          PostDescription(post: post, onProfileTap: onProfileTap),
          PostCommentsText(post: post),
        ],
      ),
    );
  }
}

class PostCommentsText extends StatelessWidget {
  final PostModel post;

  const PostCommentsText({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 6),
        Text(
          "View the ${post.totalComments} comments",
          style: TextStyle(fontSize: 11, color: Colors.black.withOpacity(0.4)),
        ),
      ],
    );
  }
}

class PostDescription extends StatelessWidget {
  final PostModel post;
  final Function(int) onProfileTap;

  const PostDescription({
    super.key,
    required this.post,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Text(
            post.user.username,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            onProfileTap(post.user.userId);
          },
        ),
        SizedBox(width: 2),
        Text(post.caption, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

class PostExtraInfo extends StatelessWidget {
  final PostModel post;
  final Function(int) onProfileTap;

  const PostExtraInfo({
    super.key,
    required this.post,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          InkWell(
            child: CircleAvatar(
              radius: 8.5,
              backgroundImage: NetworkImage(post.likedBy!.avatar),
            ),
            onTap: () {
              onProfileTap(post.likedBy!.userId);
            },
          ),
          SizedBox(width: 7),
          Row(
            children: [
              Text("Liked by", style: TextStyle(fontSize: 12)),
              SizedBox(width: 2),
              InkWell(
                child: Text(
                  post.likedBy!.username,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  onProfileTap(post.likedBy!.userId);
                },
              ),
              SizedBox(width: 2),
              Text("and", style: TextStyle(fontSize: 12)),
              SizedBox(width: 2),
              Text(
                "${post.totalLikes - 1} others",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PostButtons extends StatelessWidget {
  const PostButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/images/HeartIcon.png", height: 24, width: 24),
        SizedBox(width: 12),
        Image.asset("assets/images/CommentIcon.png", height: 24, width: 24),
        SizedBox(width: 12),
        Image.asset("assets/images/DirectIcon.png", height: 24, width: 24),
        Spacer(),
        Image.asset("assets/images/BookmarkIcon.png", height: 24, width: 24),
      ],
    );
  }
}

class PostContents extends StatelessWidget {
  final PostModel post;

  const PostContents({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      child: Image.network(post.postImage, height: 320),
    );
  }
}

class PostInfo extends StatelessWidget {
  final PostModel post;
  final Function(int) onProfileTap;

  const PostInfo({super.key, required this.post, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          InkWell(
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(post.user.avatar),
            ),
            onTap: () {
              onProfileTap(post.user.userId);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Text(
                    post.user.username,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    onProfileTap(post.user.userId);
                  },
                ),
                Text(post.subtitle, style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          Spacer(),
          Image.asset("assets/images/ThreeDotsIcon.png", height: 3, width: 13),
        ],
      ),
    );
  }
}

class HomeStories extends StatelessWidget {
  final dynamic me;
  final Function(int) onProfileTap;

  const HomeStories({super.key, required this.me, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    List<Story> stories = StoryRepository().getStories();
    return SizedBox(
      height: 97,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                onProfileTap(me.userId);
              },
              child: HomeProfile(imageUrl: me.avatar, label: "Your Story"),
            );
          } else {
            return homeStory(stories[index - 1]);
          }
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 0, width: 0);
        },
        itemCount: stories.length,
      ),
    );
  }

  Padding homeStory(Story story) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: story.seen
                      ? LinearGradient(
                          colors: [Colors.grey, Colors.grey],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        )
                      : LinearGradient(
                          colors: [Color(0xFA9E2692), Color(0xFAFAA958)],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                ),
              ),
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(story.user.avatar),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(story.user.username, style: TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

class HomeProfile extends StatelessWidget {
  final String imageUrl;
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
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(imageUrl),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/models/app_failure.dart';
import 'package:instagram_clone/models/conversation_model.dart';
import 'package:instagram_clone/models/domain/direct_conversation_item.dart';
import 'package:instagram_clone/models/story_model.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/repositories/conversation_repository.dart';
import 'package:instagram_clone/repositories/story_repository.dart';
import 'package:instagram_clone/ui/app_icon.dart';
import 'package:instagram_clone/ui/app_feedback.dart';
import 'package:instagram_clone/widgets/direct_list_item.dart';

class DirectsScreen extends StatelessWidget {
  const DirectsScreen({super.key, required this.currentUser});

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    final conversationsFuture = ConversationRepository().getUserConversations(
      currentUser.id,
    );
    final storiesFuture = StoryRepository().getUserStories(currentUser.id);

    return SafeArea(
      child: Scaffold(
        appBar: _directsAppBar(currentUser),
        body: _directsList(conversationsFuture, storiesFuture, currentUser),
        bottomNavigationBar: _footer(),
      ),
    );
  }
}

PreferredSizeWidget _directsAppBar(UserModel me) {
  return AppBar(
    toolbarHeight: 44,
    titleSpacing: 0,
    leadingWidth: 0,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 15),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: AppIcon(
            asset: "assets/images/backIcon.png",
            height: 17,
            width: 9,
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            me.username,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Spacer(),
        AppIcon(asset: "assets/images/AddIcon.png", height: 19, width: 19),
        SizedBox(width: 18),
      ],
    ),
  );
}

Widget _directsList(
  Future<List<ConversationModel>> conversationsFuture,
  Future<List<StoryModel>> storiesFuture,
  UserModel currentUser,
) {
  Future<void> refresh() async {}

  return RefreshIndicator(
    onRefresh: refresh,
    child: FutureBuilder(
      future: conversationsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder<List<StoryModel>>(
            future: storiesFuture,
            builder: (context, storiesSnapshot) {
              if (storiesSnapshot.hasData) {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) =>
                      Divider(height: 1, color: Color(0xffC7C7CC)),
                  itemBuilder: (context, index) {
                    final conv = snapshot.data![index];

                    return DirectListItem(
                      conversation: conv,
                      onTap: () {},
                    );
                  },
                );
              } else if (storiesSnapshot.hasError) {
                return Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.refresh),
                  ),
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          );
        } else if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppFeedback.showFailure(
              context,
              snapshot.error as AppFailure,
            );
          });
          return Center(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.refresh),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    ),
  );
}

Widget _footer() {
  return SizedBox(
    height: 45,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/BlueCameraIcon.png",
          height: 19,
          width: 20,
        ),
        SizedBox(width: 8),
        Text(
          "Camera",
          style: TextStyle(fontSize: 13, color: Color(0xffa3897f)),
        ),
      ],
    ),
  );
}

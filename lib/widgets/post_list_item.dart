// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_clone/models/post_model.dart';
// import 'package:instagram_clone/ui/app_icon.dart';

// class PostListItem extends StatelessWidget {
//   final PostModel post;
//   final Function(int) onProfileTap;

//   const PostListItem({
//     super.key,
//     required this.post,
//     required this.onProfileTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Column(
//         children: [
//           _postHeader(post, onProfileTap),
//           SizedBox(height: 4),
//           _postImage(post),
//           SizedBox(height: 4),
//           _postFooter(post, onProfileTap),
//         ],
//       ),
//     );
//   }
// }

// Widget _postHeader(PostModel post, Function(int) onProfileTap) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//     child: Row(
//       children: [
//         InkWell(
//           child: CircleAvatar(
//             radius: 16,
//             child: ClipOval(
//               child: CachedNetworkImage(
//                 imageUrl: post.user.avatar,
//                 placeholder: (context, url) =>
//                     Center(child: CircularProgressIndicator()),
//                 errorWidget: (context, url, error) =>
//                     Center(child: Icon(Icons.error)),
//               ),
//             ),
//           ),
//           onTap: () {
//             onProfileTap(post.user.userId);
//           },
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 6.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               InkWell(
//                 child: Text(
//                   post.user.username,
//                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                 ),
//                 onTap: () {
//                   onProfileTap(post.user.userId);
//                 },
//               ),
//               Text(post.subtitle, style: TextStyle(fontSize: 10)),
//             ],
//           ),
//         ),
//         Spacer(),
//         AppIcon(asset: "assets/images/ThreeDotsIcon.png", height: 3, width: 13),
//       ],
//     ),
//   );
// }

// Widget _postImage(PostModel post) {
//   return SizedBox(
//     width: double.infinity,
//     child: CachedNetworkImage(
//       height: 320,
//       fit: BoxFit.fitHeight,
//       imageUrl: post.postImage,
//       placeholder: (context, url) => Center(child: CircularProgressIndicator()),
//       errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
//     ),
//   );
// }

// Widget _postFooter(PostModel post, Function(int) onProfileTap) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _postActions(),
//         SizedBox(height: 4),
//         _postLikes(post, onProfileTap),
//         _postCaption(post, onProfileTap),
//         _postTopComment(post),
//       ],
//     ),
//   );
// }

// Widget _postActions() {
//   return Row(
//     children: [
//       AppIcon(asset: "assets/images/HeartIcon.png", height: 24, width: 24),
//       SizedBox(width: 12),
//       AppIcon(asset: "assets/images/CommentIcon.png", height: 24, width: 24),
//       SizedBox(width: 12),
//       AppIcon(asset: "assets/images/DirectIcon.png", height: 24, width: 24),
//       Spacer(),
//       AppIcon(asset: "assets/images/BookmarkIcon.png", height: 24, width: 24),
//     ],
//   );
// }

// Widget _postLikes(PostModel post, Function(int) onProfileTap) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 6.0),
//     child: Row(
//       children: [
//         InkWell(
//           child: CircleAvatar(
//             radius: 8.5,
//             child: ClipOval(
//               child: CachedNetworkImage(
//                 imageUrl: post.likedBy!.avatar,
//                 placeholder: (context, url) =>
//                     Center(child: CircularProgressIndicator()),
//                 errorWidget: (context, url, error) =>
//                     Center(child: Icon(Icons.error)),
//               ),
//             ),
//           ),
//           onTap: () {
//             onProfileTap(post.likedBy!.userId);
//           },
//         ),
//         SizedBox(width: 7),
//         Row(
//           children: [
//             Text("Liked by", style: TextStyle(fontSize: 12)),
//             SizedBox(width: 2),
//             InkWell(
//               child: Text(
//                 post.likedBy!.username,
//                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//               ),
//               onTap: () {
//                 onProfileTap(post.likedBy!.userId);
//               },
//             ),
//             SizedBox(width: 2),
//             Text("and", style: TextStyle(fontSize: 12)),
//             SizedBox(width: 2),
//             Text(
//               "${post.totalLikes - 1} others",
//               style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

// Widget _postCaption(PostModel post, Function(int) onProfileTap) {
//   return Row(
//     children: [
//       InkWell(
//         child: Text(
//           post.user.username,
//           style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//         ),
//         onTap: () {
//           onProfileTap(post.user.userId);
//         },
//       ),
//       SizedBox(width: 2),
//       Text(post.caption, style: TextStyle(fontSize: 14)),
//     ],
//   );
// }


// Widget _postTopComment(PostModel post) {
//   return Column(
//     children: [
//       SizedBox(height: 6),
//       Text(
//         "View the ${post.totalComments} comments",
//         style: TextStyle(fontSize: 11, color: Colors.black.withOpacity(0.4)),
//       ),
//     ],
//   );
// }


// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_clone/models/story_model.dart';

// class StoryItem extends StatelessWidget {
//   const StoryItem({super.key, required this.story, required this.onTap, required this.radius, required this.isDirect});

//   final StoryModel story;
//   final VoidCallback onTap;
//   final double radius;
//   final bool isDirect;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Stack(
//             alignment: AlignmentGeometry.center,
//             children: [
//               Container(
//                 width: (radius * 2) + 4,
//                 height: (radius * 2) + 4,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: story.seen
//                       ? LinearGradient(
//                           colors: [Colors.grey, Colors.grey],
//                           begin: Alignment.topRight,
//                           end: Alignment.bottomLeft,
//                         )
//                       : LinearGradient(
//                           colors: [Color(0xFA9E2692), Color(0xFAFAA958)],
//                           begin: Alignment.topRight,
//                           end: Alignment.bottomLeft,
//                         ),
//                 ),
//               ),
//               Container(
//                 height: (radius * 2) + 4,
//                 width: (radius * 2) + 4,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Theme.of(context).colorScheme.surface,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(3.0),
//                 child: CircleAvatar(
//                   radius: radius,
//                   child: ClipOval(
//                     child: CachedNetworkImage(
//                       imageUrl: story.user.avatar,
//                       placeholder: (context, url) =>
//                           Center(child: CircularProgressIndicator()),
//                       errorWidget: (context, url, error) =>
//                           Center(child: Icon(Icons.error)),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           if (!isDirect)
//             Text(story.user.username, style: TextStyle(fontSize: 11)),
//         ],
//       ),
//     );
//   }
// }
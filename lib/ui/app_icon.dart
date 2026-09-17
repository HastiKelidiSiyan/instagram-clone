// import 'package:flutter/material.dart';

// class AppIcon extends StatelessWidget {
//   final String asset;
//   final double? width;
//   final double? height;

//   const AppIcon({
//     super.key,
//     required this.asset,
//     this.width,
//     this.height,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ColorFiltered(
//       colorFilter: ColorFilter.mode(
//         Theme.of(context).iconTheme.color!,
//         BlendMode.srcIn,
//       ),
//       child: Image.asset(
//         asset,
//         width: width,
//         height: height,
//       ),
//     );
//   }
// }
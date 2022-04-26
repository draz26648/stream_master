// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// ///The buttons on the right side of the shooting page
// class ShootRightWidget extends StatefulWidget {
//   ShootRightWidget({Key? key}) : super(key: key);
//
//   @override
//   _ShootRightWidgetState createState() {
//     return _ShootRightWidgetState();
//   }
// }
//
// class _ShootRightWidgetState extends State<ShootRightWidget> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.topRight,
//       margin: EdgeInsets.only(
//           top: MediaQueryData.fromWindow(window).padding.top + 25, right: 16),
//       child: Column(
//         children: [
//           ShootRightButton(
//             imgUrl: 'assets/images/shoot_fanzhuan.webp',
//             title: 'flip',
//           ),
//           ShootRightButton(
//             imgUrl: 'assets/images/shoot_v_off.webp',
//             title: 'fast or slow',
//           ),
//           ShootRightButton(
//             imgUrl: 'assets/images/shoot_filter.webp',
//             title: 'filter',
//           ),
//           ShootRightButton(
//             imgUrl: 'assets/images/shoot_meihua.webp',
//             title: 'beautify',
//           ),
//           ShootRightButton(
//             imgUrl: 'assets/images/shoot_daojishi.webp',
//             title: 'countdown',
//           ),
//           ShootRightButton(
//             imgUrl: 'assets/images/shoot_flash.webp',
//             title: 'flash',
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ShootRightButton extends StatelessWidget {
//   String? imgUrl;
//   String? title;
//
//   ShootRightButton({this.imgUrl, this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             imgUrl!,
//             width: 32,
//             height: 32,
//           ),
//           Text(
//             title!,
//             style: TextStyle(
//                 color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }

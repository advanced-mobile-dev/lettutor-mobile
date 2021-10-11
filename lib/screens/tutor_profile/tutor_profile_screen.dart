// import 'package:flutter/material.dart';
// import 'package:lettutor_app/config/theme.dart';
// import 'package:lettutor_app/widgets/app_bar.dart';

// class TutorProfileScreen extends StatefulWidget {
//   @override
//   _TutorProfileScreenState createState() => _TutorProfileScreenState();
// }

// class _TutorProfileScreenState extends State<TutorProfileScreen> {
//   final int _tabIndexSelected = 0;
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//             backgroundColor: AppTheme.backgroundColor,
//             appBar: AppBar(
//               leading: IconButton(
//                   icon: Icon(
//                     Icons.arrow_back_ios,
//                     color: AppTheme.mainColor,
//                   ),
//                   onPressed: () {
//                     // Utility.hideKeyboard(context);
//                     Navigator.pop(context);
//                   }),
//               backgroundColor: AppTheme.mainColor2,
//               elevation: 0,
//               centerTitle: true,
//               title: Text(
//                 'Tutor profile',
//                 style: TextStyle(color: AppTheme.mainColor, fontSize: 28),
//               ),
//               bottom: TabBar(
//                 unselectedLabelColor: Colors.grey,
//                 labelColor: AppTheme.mainColor,
//                 indicatorColor: AppTheme.mainColor,
//                 indicatorWeight: 3,
//                 tabs: <Widget>[
//                   Tab(
//                     icon: Icon(
//                       Icons.description,
//                     ),
//                     text: 'Profile',
//                   ),
//                   Tab(
//                     icon: Icon(
//                       Icons.calendar_today,
//                     ),
//                     text: 'Schedule',
//                   ),
//                 ],
//               ),
//             ),
//             body: TabBarView(children: <Widget>[
//               Center(
//                 child: Text("It's cloudy here"),
//               ),
//               Center(
//                 child: Text("It's rainy here"),
//               ),
//             ])));
//   }
// }

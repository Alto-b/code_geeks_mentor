import 'package:code_geeks_mentor/presentation/dashboard/widget/ongoing_subs.dart';
import 'package:code_geeks_mentor/presentation/dashboard/widget/upcoming_subs.dart';
import 'package:flutter/material.dart';

class MentorDashboard extends StatelessWidget {
  const MentorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Mentor Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              UpcomingList(screenHeight: screenHeight, screenWidth: screenWidth),
              // SizedBox(height: 20,),
              OngoingList(screenHeight: screenHeight, screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:code_geeks_mentor/application/bookings_bloc/bookings_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingList extends StatelessWidget {
  const UpcomingList({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    context.read<BookingsBloc>().add(BookingsLoadEvent());
    return Container(
      height: screenHeight/2.5,
      width: screenWidth,
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const Text("Upcoming subscriptions",style: TextStyle(
            fontSize: 15,fontWeight: FontWeight.w600
          ),),
          BlocBuilder<BookingsBloc, BookingsState>(
            builder: (context, state) {
              print(state.runtimeType);
              if(state is BookingsLoadedState){
                return Container(
                      height: (screenHeight/3)-20,
                       width: (screenWidth)-20,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.upcomingList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:  const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              height: screenHeight/4,
                              width: screenWidth/6,
                              // color: Colors.blue,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.2
                                ),
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child:  Column(
                                children: [
                                   Text("${state.upcomingList[index].sub_title}  /  ${state.upcomingList[index].sub_lang}"),
                                  const SizedBox(height: 10,),
                                  Spacer(),
                                   Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.calendar_month,size: 20,color: Colors.grey,),
                                          Row(
                                            children: [
                                              Text("${state.upcomingList[index].date}"),
                                              Text("  -  "),
                                              Text("${state.upcomingList[index].expiry}"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    width: (screenWidth/6)-50,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:MaterialStatePropertyAll(const Color.fromARGB(255, 17, 160, 22))
                                      ),
                                      onPressed: (){
                                        //continue here
                                        // context.read<BookingsBloc>().add(AcceptBookingEvent(bookingId: state.upcomingList[index].booking_id, data: data));
                                        Map<String,dynamic> data = {
                                          "status" : "ongoing",
                                          "guide_id" : FirebaseAuth.instance.currentUser!.uid,
                                          "guide_name" : FirebaseAuth.instance.currentUser!.displayName,
                                          "guide_photo" : FirebaseAuth.instance.currentUser!.photoURL ?? "https://media.istockphoto.com/id/522855255/vector/male-profile-flat-blue-simple-icon-with-long-shadow.jpg?s=612x612&w=0&k=20&c=EQa9pV1fZEGfGCW_aEK5X_Gyob8YuRcOYCYZeuBzztM="
                                        };
                                        context.read<BookingsBloc>().add(AcceptBookingEvent(bookingId: state.upcomingList[index].booking_id, data: data));
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Processing request"),duration: Duration(seconds: 3),backgroundColor: Colors.green,));
                                        Future.delayed(Duration(seconds: 2));
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Request accepted"),duration: Duration(seconds: 2),backgroundColor: Colors.green,));
                                        context.read<BookingsBloc>().add(BookingsLoadEvent());
                                      }, child: const Text("Accept",style: TextStyle(
                                        color: Colors.white
                                      ),)))
                                ],
                              ),
                            ),
                          );
                      },),
                    );
              }
              return Text("No upcomings");
            },
          )
        ],
      ),
    );
  }
}
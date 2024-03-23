
import 'package:code_geeks_mentor/application/bookings_bloc/bookings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OngoingList extends StatelessWidget {
  const OngoingList({
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
           const Text("Ongoing subscriptions",style: TextStyle(
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
                        itemCount: state.onGoingList.length,
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
                                   Text("${state.onGoingList[index].sub_title}  /  ${state.onGoingList[index].sub_lang}"),
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
                                              Text("${state.onGoingList[index].date}"),
                                              Text("  -  "),
                                              Text("${state.onGoingList[index].expiry}"),
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
                                        backgroundColor:MaterialStatePropertyAll(Color.fromARGB(255, 0, 0, 0))
                                      ),
                                      onPressed: (){
                                        //continue here
                                        // context.read<BookingsBloc>().add(AcceptBookingEvent(bookingId: state.upcomingList[index].booking_id, data: data));
                                        // Map<String,dynamic> data = {
                                        //   "status" : "ongoing",
                                        //   "guide_id" : FirebaseAuth.instance.currentUser!.uid
                                        // };
                                        // context.read<BookingsBloc>().add(AcceptBookingEvent(bookingId: state.upcomingList[index].booking_id, data: data));
                                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Processing request"),duration: Duration(seconds: 3),backgroundColor: Colors.green,));
                                        // Future.delayed(Duration(seconds: 2));
                                      }, child: const Text("Message",style: TextStyle(
                                        color: Colors.white
                                      ),)))
                                ],
                              ),
                            ),
                          );
                      },),
                    );
              }
              return Text("no ongoings");
              // return Container(
              //         height: (screenHeight/3)-20,
              //          width: (screenWidth)-20,
              //         child: ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           itemCount: 3,
              //           itemBuilder: (context, index) {
              //             return Padding(
              //               padding:  const EdgeInsets.all(8.0),
              //               child: Container(
              //                 padding: const EdgeInsets.all(20),
              //                 height: screenHeight/4,
              //                 width: screenWidth/6,
              //                 // color: Colors.blue,
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     width: 0.2
              //                   ),
              //                   // color: Colors.white12,
              //                   borderRadius: BorderRadius.circular(20)
              //                 ),
              //                 child:  Column(
              //                   children: [
              //                     const Text("asdddddddaaaaaaaaaaaaaaaaaadddddddddddddddddddaaaaaaaddddddd"),
              //                     const SizedBox(height: 10,),
              //                     Spacer(),
              //                     const Row(
              //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                       children: [
              //                         Row(
              //                           children: [
              //                             Icon(Icons.timer,size: 20,color: Colors.grey,),
              //                             Text("time"),
              //                           ],
              //                         ),
              //                         Row(
              //                           children: [
              //                             Icon(Icons.calendar_month,size: 20,color: Colors.grey,),
              //                             Text("date"),
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                     SizedBox(height: 10,),
              //                     Container(
              //                       width: (screenWidth/6)-50,
              //                       child: ElevatedButton(
              //                         style: ButtonStyle(
              //                           backgroundColor:MaterialStatePropertyAll(Color.fromARGB(255, 97, 137, 206))
              //                         ),
              //                         onPressed: (){}, child: const Text("Message",style: TextStyle(
              //                           color: Colors.white
              //                         ),)))
              //                   ],
              //                 ),
              //               ),
              //             );
              //         },),
              //       );
            },
          )
        ],
      ),
    );
  }
}

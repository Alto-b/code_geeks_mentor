
import 'package:flutter/material.dart';

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
          Container(
            height: (screenHeight/3)-20,
             width: (screenWidth)-20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
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
                        const Text("asdddddddaaaaaaaaaaaaaaaaaadddddddddddddddddddaaaaaaaddddddd"),
                        const SizedBox(height: 10,),
                        Spacer(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.timer,size: 20,color: Colors.grey,),
                                Text("time"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_month,size: 20,color: Colors.grey,),
                                Text("date"),
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
                            onPressed: (){}, child: const Text("Accept",style: TextStyle(
                              color: Colors.white
                            ),)))
                      ],
                    ),
                  ),
                );
            },),
          )
        ],
      ),
    );
  }
}
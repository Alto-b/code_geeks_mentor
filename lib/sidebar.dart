import 'package:code_geeks_mentor/presentation/dashboard/dashboard.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';

class SideBarPage extends StatelessWidget {
   SideBarPage({super.key});

  int index=0;

  final screens = [
    MentorDashboard()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CollapsibleSidebar(
        isCollapsed: true,
        items: [ 
          CollapsibleItem(text: 'Dashboard', onPressed: (){})
        ],
        body: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(200, 80), 
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: MentorAppbar(),
            )),
          body: screens[0],
        ),
        backgroundColor: Colors.transparent,
        selectedTextColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedTextColor: Colors.grey,
        textStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        sidebarBoxShadow: const [],
        collapseOnBodyTap: true,
        fitItemsToBottom: true,
        itemPadding: 10,
        selectedIconBox: Colors.deepOrange,
        selectedIconColor: Colors.pink,
        showTitle: true,
        avatarBackgroundColor: Colors.red,
        ),
    );
  }
}

class MentorAppbar extends StatelessWidget {
  const MentorAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey,
      title: const Text("Welcome baack !",style: TextStyle(color: Colors.white),),
                 actions:  [
                  CircleAvatar(backgroundColor: Colors.grey,),
                  SizedBox(width: 10,),
                  IconButton(onPressed: (){logOutBox(context);}, icon: Icon(Icons.logout)),
                  SizedBox(width: 10,),
                 ],
                 clipBehavior: Clip.antiAliasWithSaveLayer,
                 elevation: 5,
                 toolbarHeight: 70,
    );
  }

    // alert box start n 

    void logOutBox(BuildContext context){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title:Text("Logout"),
          content: Text("Do you want to leave ?"),
          actions: [
            ElevatedButton(onPressed: (){
              // signout(context);
            }, child: Text("Yes")),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("No")),
          ],
        );
      });
    }



  // alert box end




  // signout(BuildContext ctx) async{

  //   final _sharedPrefs= await SharedPreferences.getInstance();
  // await _sharedPrefs.clear();

  //   Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>LoginPage()), (route) => false);
  //   _sharedPrefs.setBool(SAVE_KEY_NAME, false);
  // }

}
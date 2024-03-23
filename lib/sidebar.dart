import 'package:code_geeks_mentor/application/sidebar_bloc/sidebar_bloc.dart';
import 'package:code_geeks_mentor/presentation/chats/chatpage.dart';
import 'package:code_geeks_mentor/presentation/codes/add_codes.dart';
import 'package:code_geeks_mentor/presentation/dashboard/dashboard.dart';
import 'package:code_geeks_mentor/presentation/login/login.dart';
import 'package:code_geeks_mentor/presentation/profile/profile_page.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideBarPage extends StatelessWidget {
   SideBarPage({super.key});

  int index=0;

  final screens = [
    MentorDashboard(),
    AddCodesPage(),
    MentorChatPage(),
    MentorProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CollapsibleSidebar(
        isCollapsed: true,
        items: [ 
          CollapsibleItem(
          text: 'Dashboard',
          icon: Icons.dashboard,
          onPressed: (){
            BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index));
      },
      isSelected: true,
    ),
          CollapsibleItem(icon: Icons.post_add,text: 'Post', onPressed: (){
            BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+1));
          }),
          CollapsibleItem(icon: Icons.message,text: 'Chat', onPressed: (){
            BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+2));
          }),
          CollapsibleItem(icon: Icons.settings,text: 'Profile', onPressed: (){
            BlocProvider.of<SidebarBloc>(context).add(IndexChangeEvent(index: index+3));
          })
        ],
        // avatarImg: Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
        title: 'Mentor Panel',
        body: BlocBuilder<SidebarBloc, SidebarState>(
          builder: (context, state) {
            print(state.runtimeType);
            if(state is SidebarInitial){
              print('State index: ${state.index}');
              return Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size(200, 80), 
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: MentorAppbar(),
                    )),
                  body: screens[state.index],
                );
            }
            return screens[index];
          },
        ),
        backgroundColor: Colors.grey.shade600,
        selectedTextColor: Color.fromARGB(255, 0, 0, 0),
        unselectedTextColor: Colors.white,
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
        selectedIconBox: Colors.white,
        selectedIconColor: Color.fromARGB(255, 13, 79, 223),
        unselectedIconColor: Colors.white,
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
      title:  Text(
              "Welcome back ${FirebaseAuth.instance.currentUser?.displayName?? 'Mentor'}",
              style: TextStyle(color: Colors.white),
),

                 actions:  [
                  // CircleAvatar(backgroundColor: Colors.grey,),
                  SizedBox(width: 10,),
                  IconButton(onPressed: (){logOutBox(context);}, icon: Icon(Icons.logout)),
                  SizedBox(width: 10,),
                 ],
                 clipBehavior: Clip.antiAliasWithSaveLayer,
                 elevation: 5,
                 toolbarHeight: 70,
    );
  }

    // log out alert box 

    void logOutBox(BuildContext context){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title:Text("Logout"),
          content: Text("Do you want to leave ?"),
          actions: [
            ElevatedButton(onPressed: (){
              showLogOutDialog(context);
            }, child: Text("Yes")),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("No")),
          ],
        );
      });
    }

  // signout(BuildContext ctx) async{

  //   final _sharedPrefs= await SharedPreferences.getInstance();
  // await _sharedPrefs.clear();

  //   Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>LoginPage()), (route) => false);
  //   _sharedPrefs.setBool(SAVE_KEY_NAME, false);
  // }
  
  showLogOutDialog(BuildContext context) {
  //cancel/continue button
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed:  () {
      FirebaseAuth.instance.signOut();
      // FirebaseAuth.instance.s/
      // FirebaseFirestore.instance.clearPersistence();
      // context.read<BnbBloc>().add(TabChangeEvent(tabIndex: 0));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
    },
  );
  //AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Warning!"),
    content: const Text("Would you like to logout ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
}
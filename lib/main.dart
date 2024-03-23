import 'package:code_geeks_mentor/application/bookings_bloc/bookings_bloc.dart';
import 'package:code_geeks_mentor/application/chat_bloc/chat_bloc.dart';
import 'package:code_geeks_mentor/application/image_picker_bloc/image_bloc.dart';
import 'package:code_geeks_mentor/application/mentor_bloc/mentor_bloc.dart';
import 'package:code_geeks_mentor/application/post_bloc/post_bloc.dart';
import 'package:code_geeks_mentor/application/sidebar_bloc/sidebar_bloc.dart';
import 'package:code_geeks_mentor/infrastructure/bookings_repo.dart';
import 'package:code_geeks_mentor/infrastructure/chat_repo.dart';
import 'package:code_geeks_mentor/infrastructure/mentor_repo.dart';
import 'package:code_geeks_mentor/presentation/splash%20screen/splash.dart';
import 'package:code_geeks_mentor/sidebar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const SAVE_KEY_NAME ="UserLoggedIn";
void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:const FirebaseOptions(
      apiKey: "AIzaSyC6lX-_LJBYd8u_iDGm4auwfgIyqWL2vao",
  authDomain: "code-geeks-ff98c.firebaseapp.com",
  databaseURL: "https://code-geeks-ff98c-default-rtdb.firebaseio.com",
  projectId: "code-geeks-ff98c",
  storageBucket: "code-geeks-ff98c.appspot.com",
  messagingSenderId: "688360665265",
  appId: "1:688360665265:web:7b2ad53c9fdd793f51f290",
  measurementId: "G-RH237LC5SQ"
      )
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
            BlocProvider(
          create: (context) => BookingsBloc(BookingsRepo()),
    
        ),
            BlocProvider(
                create: (context) => SidebarBloc(),
            ),
            BlocProvider(
                create: (context) => PostBloc(),
            ),
            BlocProvider(
                create: (context) => ChatBloc(ChatRepo()),
            ),
            BlocProvider(
                create: (context) => MentorBloc(MentorRepo()),
            ),
            BlocProvider(
                create: (context) => ImageBloc(),
            ),
        ],
              child: MaterialApp(
              title: 'Code_Geeks_Mentor',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: SplashScreen(),
            ),
    );
  }
}

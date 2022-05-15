import 'package:flutter/material.dart';
import 'package:ticketbookingflutter/booking_tickets/choose_seat_screen.dart';
import 'package:ticketbookingflutter/booking_tickets/review_screen.dart';
import 'package:ticketbookingflutter/booking_tickets/theater_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket Booking',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(49, 156, 156, 1.0),
        canvasColor: Color.fromRGBO(38, 47, 52, 1.0),
        textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white)
        ),
      ),

      home: const TheaterScreen(),
      routes: {
        TheaterScreen.routeName: (ctx) => const TheaterScreen(),
        ChooseSeatScreen.routeName: (ctx) => const ChooseSeatScreen(),
        ReviewScreen.routeName:(ctx) => const ReviewScreen(),
      },
    );
  }
}

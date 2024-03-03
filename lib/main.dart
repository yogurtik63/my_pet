import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_pet/screens/calendar.dart';
import 'package:my_pet/screens/finance_page.dart';
import 'package:my_pet/screens/pet_main.dart';
import 'package:my_pet/screens/test/notif_page.dart';
import 'package:my_pet/screens/user.dart';
import 'package:my_pet/services/notifi_service.dart';

import 'package:timezone/data/latest.dart' as tz;

import 'global.dart';


void main() {
  for (var event in gEvents) {
    event.refPet.addEvent(event);
  }

  for (var pet in gPets) {
    pet.setImage();
  }

  NotificationService().initNotification();
  // tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Pet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, background: const Color.fromRGBO(241, 241, 241, 1)),
        useMaterial3: true,
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'My Pet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 1;
  List widgets = [
    // UserWidget(),
    PetMainPage(),
    CalendarPage(),
    FinancePageWidget()
  ];

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: index,
        onDestinationSelected: (index) => setState(() => this.index = index),
        destinations: const [
          // NavigationDestination(
          //     icon: Icon(Icons.person_outlined),
          //     selectedIcon: Icon(Icons.person),
          //     label: 'Профиль'
          // ),
          NavigationDestination(
              icon: Icon(Icons.pets_outlined),
              selectedIcon: Icon(Icons.pets),
              label: 'Питомцы'
          ),
          NavigationDestination(
              icon: Icon(Icons.date_range_outlined),
              selectedIcon: Icon(Icons.date_range),
              label: 'Календарь'
          ),
          NavigationDestination(
              icon: Icon(Icons.attach_money_outlined),
              selectedIcon: Icon(Icons.attach_money),
              label: 'Финансы'
          )
        ],
      ),
      body: widgets[index]
    );
  }
}


// initialRoute: '/',
// routes: {
//   // When navigating to the "/" route, build the FirstScreen widget.
//   '/': (context) => const MyHomePage(title: "home",),
//   // When navigating to the "/second" route, build the SecondScreen widget.
//   '/second': (context) => const SecondScreen(),
// }


import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticketbookingflutter/booking_tickets/consts/const.dart';
import 'package:ticketbookingflutter/booking_tickets/models/dateModel.dart';
import 'package:ticketbookingflutter/booking_tickets/seat_selection_controller.dart';
import 'choose_seat_screen.dart';
import 'models/ticketModel.dart';
import 'no_of_seats.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TheaterScreen extends StatefulWidget {
  static const routeName = "/theater-screen";

  const TheaterScreen({Key? key}) : super(key: key);

  @override
  _TheaterScreenState createState() => _TheaterScreenState();
}

class _TheaterScreenState extends State<TheaterScreen> {
  List<DateModel> dateModels = [];
  Map<String, Map<String, Color>> theaters = {};

  var isInit = true;

  @override
  void initState() {
    Get.put(SeatSelectionController());
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      TicketModel.movieName = "Bad Boy";
      FirebaseDatabase database = FirebaseDatabase.instance;
      DataSnapshot dataSnapshot = await database
          .ref('Movies/' + TicketModel.movieName + "/Theaters")
          .get();

      var startDate =
          DateTime.parse(dataSnapshot.child("startDate").value.toString());
      var endDate =
          DateTime.parse(dataSnapshot.child("endDate").value.toString());
      var currentDate =
          DateTime.now().isBefore(startDate) ? startDate : DateTime.now();
      while (!currentDate.isAfter(endDate)) {
        dateModels.add(DateModel(currentDate,
            DateFormat("EEEE").format(currentDate).substring(0, 3), false));
        currentDate =
            DateTime(currentDate.year, currentDate.month, currentDate.day + 1);
      }

      var ignoreKeys = ["startDate", "endDate"];
      Map<String, Color> colorMap = {
        "green": Colors.green,
        "orange": Colors.orange,
        "red": Colors.red,
      };
      for (var data in dataSnapshot.children) {
        if (!ignoreKeys.contains(data.key.toString())) {
          theaters[data.key.toString()] = {};
          for (var time in data.children) {
            theaters[data.key.toString()]![time.key.toString().substring(0, 2) +
                    ":" +
                    time.key.toString().substring(2)] =
                colorMap[time.value.toString()] as Color;
          }
        }
      }

      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isInit
            ? const CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      TicketModel.movieName,
                      style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dateModels.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            for (int i = 0; i < dateModels.length; i++) {
                              dateModels[i].isSelected = false;
                            }
                            setState(() {
                              TicketModel.date = dateModels[index].date;
                              dateModels[index].isSelected = true;
                            });
                          },
                          child: NeuDate(
                            dateModels[index].date.day.toString(),
                            dateModels[index].day,
                            dateModels[index].isSelected,
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ListView.builder(
                        itemCount: theaters.keys.length,
                        itemBuilder: (ctx, index) {
                          return NeuTheater(theaters.keys.elementAt(index),
                              theaters[theaters.keys.elementAt(index)]!);
                        },
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class NeuTheater extends StatelessWidget {
  final Map<String, Color> times;
  final String theaterName;

  NeuTheater(this.theaterName, this.times);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 5, right: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: AppConst.shadow,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      width: double.infinity,
      height: max((times.length / (size.width / 100).floor()).ceil() * 65, 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            theaterName,
            style: const TextStyle(color: Colors.white, fontSize: 22),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: 3,
                    crossAxisCount: (size.width / 100).floor()),
                itemCount: times.keys.length,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      if (TicketModel.date.isBefore(DateTime.now())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please select a valid date")));
                      } else {
                        TicketModel.theaterName = theaterName;
                        TicketModel.time = times.keys.elementAt(index);
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            context: context,
                            builder: (ctx1) {
                              return Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      "How Many Seats?",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                  Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 20),
                                      child: SvgPicture.asset(
                                        "assets/icons/${SeatSelectionController.instance.getAsset()}",
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  NoOfSeats(
                                      onTap: SeatSelectionController
                                          .instance.noOfSeats),
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          TicketModel.theaterName,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          DateFormat("MMMMd").format(TicketModel.date) +
                                              ", " +
                                              TicketModel.time,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        SizedBox(height: 50),
                                        TextButton(
                                          onPressed: () {
                                            TicketModel.tickets =
                                                SeatSelectionController
                                                    .instance.noOfSeats.value;
                                            Navigator.pushNamed(
                                              context,
                                              ChooseSeatScreen.routeName,
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            child: const Text(
                                              "Next",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: times[times.keys.elementAt(index)],
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        times.keys.elementAt(index),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class NeuDate extends StatelessWidget {
  final String date;

  final String day;

  final bool isElevated;

  NeuDate(this.date, this.day, this.isElevated);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: 70,
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: isElevated ? AppConst.shadow : null),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                day,
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8)
      ],
    );
  }
}

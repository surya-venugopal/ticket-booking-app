import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticketbookingflutter/booking_tickets/models/ticketModel.dart';
import 'package:ticketbookingflutter/booking_tickets/review_screen.dart';
import 'package:ticketbookingflutter/booking_tickets/seat_type.dart';

import 'seat_selection_controller.dart';
import 'package:get/get.dart';

class ChooseSeatScreen extends StatefulWidget {
  const ChooseSeatScreen({Key? key}) : super(key: key);

  static const routeName = "/choose-seat";

  @override
  _ChooseSeatScreenState createState() => _ChooseSeatScreenState();
}

class _ChooseSeatScreenState extends State<ChooseSeatScreen> {
  noOfSeatSelection() {
    return Expanded(
      child: Container(
        // color: Colors.white,
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SeatType(
                onTap: SeatSelectionController.instance.seatType,
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  TicketModel.ticketType =
                      SeatSelectionController.instance.seatType.value.toString();
                  print(TicketModel.ticketType);
                  if (TicketModel.ticketType == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select a type")));
                  } else {
                    Navigator.pushNamed(
                      context,
                      ReviewScreen.routeName,
                    );
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).primaryColor),
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                    ),
                    splashRadius: 25,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              TicketModel.movieName,
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              TicketModel.theaterName,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat("MMMMd").format(TicketModel.date) +
                                  ", " +
                                  TicketModel.time,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              TicketModel.tickets.toString() + " tickets",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            noOfSeatSelection()
          ],
        ),
      ),
    );
  }
}

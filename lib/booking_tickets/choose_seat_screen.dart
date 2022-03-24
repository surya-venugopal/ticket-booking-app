import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticketbookingflutter/booking_tickets/models/ticketModel.dart';

class ChooseSeatScreen extends StatefulWidget {
  const ChooseSeatScreen({Key? key}) : super(key: key);

  static const routeName = "/choose-seat";

  @override
  _ChooseSeatScreenState createState() => _ChooseSeatScreenState();
}

class _ChooseSeatScreenState extends State<ChooseSeatScreen> {
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
                              DateFormat("MMMMd").format(TicketModel.date)+", "+TicketModel.time,
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
            Container(
              color: Colors.white10,
              width: double.infinity,
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}

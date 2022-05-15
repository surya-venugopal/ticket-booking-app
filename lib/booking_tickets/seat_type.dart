import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketbookingflutter/booking_tickets/seat_selection_controller.dart';

import 'dummy_data.dart';

class SeatType extends StatelessWidget {
  final Function(int) onTap;

  const SeatType({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Obx(
          () => Column(
            // alignment: WrapAlignment.spaceAround,
            children: List.generate(
              seatLayout.seatTypes.length,
              (index) => Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: GestureDetector(
                  onTap: () {
                    onTap(index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: index ==
                              SeatSelectionController.instance.seatType.value
                          ? Colors.green
                          : const Color(0xfffcfcfc),
                      border: Border.all(
                          width: 0.5,
                          color: index ==
                                  SeatSelectionController
                                      .instance.seatType.value
                              ? Colors.green
                              : const Color(0xffe5e5e5)),
                    ),
                    child: Container(
                      width: size.width*2/3,
                      child: Column(
                        children: [
                          Text(
                            seatLayout.seatTypes[index]['title'],
                            style: TextStyle(
                              color: index ==
                                      SeatSelectionController
                                          .instance.seatType.value
                                  ? Colors.white
                                  : const Color(0xff999999),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\u20B9 ${seatLayout.seatTypes[index]['price']}",
                            style: TextStyle(
                              color: index ==
                                      SeatSelectionController
                                          .instance.seatType.value
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            seatLayout.seatTypes[index]['status'],
                            style: TextStyle(
                              color: index ==
                                      SeatSelectionController
                                          .instance.seatType.value
                                  ? Colors.white
                                  : Color(0xff999999),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 100),
        Container(width: size.width * 4 / 5, height: 5, color: Colors.blueGrey),
        const Text("Screen",style: TextStyle(color: Colors.white),)
      ],
    );
  }
}

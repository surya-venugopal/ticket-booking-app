import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketbookingflutter/booking_tickets/seat_selection_controller.dart';

import 'dummy_data.dart';

class NoOfSeats extends StatelessWidget {
  final Function(int) onTap;
  const NoOfSeats({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          s.length,
          (index) => GestureDetector(
            onTap: () {
              onTap(index + 1);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color:
                    index + 1 == SeatSelectionController.instance.noOfSeats.value ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    color: index + 1 == SeatSelectionController.instance.noOfSeats.value ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


import 'models/seat_layout_model.dart';

final seatLayout = SeatLayoutModel(
    rows: 10,
    cols: 11,
    seatTypes: [
      {"title": "King", "price": 120, "status": "Filling Fast"},
      {"title": "Queen", "price": 100, "status": "Available"},
      {"title": "Jack", "price": 80, "status": "Available"},
    ],
    theatreId: 123,
    gap: 2,
    gapColIndex: 5,
    isLastFilled: true,
    rowBreaks: [5, 3, 2]);

final List<int> s = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

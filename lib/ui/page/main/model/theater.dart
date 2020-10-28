part of '../../../../models/models.dart';

class Theater extends Equatable {
  final String name;
  final int price;
  Theater(this.name, {this.price});
  @override
  List<Object> get props => [name];
}

List<Theater> dummyTheater = [
  Theater("CGV Transmart", price: 40000),
  Theater("Gajah Mada Tegal", price: 30000),
  Theater("XXI Paris Van Java", price: 35000),
  Theater("XXI Bandung Trade Center", price: 45000)
];

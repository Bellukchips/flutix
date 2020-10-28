part of '../../../../models/models.dart';

class FlutixTransaction extends Equatable {
  final String userID;
  final String title;
  final String subtitle;
  final int amount;
  final DateTime time;
  final String picture;
  final int id;
  FlutixTransaction(
      {@required this.userID,
      @required this.title,
      @required this.subtitle,
      this.amount,
      @required this.time,
      this.id,
      this.picture});
  @override
  List<Object> get props => [userID, title, subtitle, amount, time, picture];
}

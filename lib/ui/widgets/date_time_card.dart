part of 'widgets.dart';

class DateTimeCard extends StatelessWidget {
  final bool isSelected;
  final double width;
  final double heigth;
  final DateTime date;
  final Function onTap;
  DateTimeCard(this.date,
      {this.isSelected = false, this.width, this.heigth, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: heigth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: isSelected ? Colors.transparent : Color(0xffe4e4e4)),
            color: isSelected ? accentColor2 : Colors.transparent),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(date.shortDayName,
                style: blackTextFont.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(
              height: 6,
            ),
            Text(
              date.day.toString(),
              style: whiteNumberFont.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}

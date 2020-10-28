part of 'widgets.dart';

class Button extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPressed;
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final TextStyle textStyle;
  Button(
      {this.title,
      this.color,
      this.onPressed,
      this.height,
      this.width,
      this.margin,
      this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Text(
            title,
            style: textStyle,
          ),
          color: color,
          onPressed: onPressed),
    );
  }
}

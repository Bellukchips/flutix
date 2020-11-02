part of '../pages.dart';

class BlankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var duration = const Duration(milliseconds: 1000);
    Timer(duration, () {
      context.bloc<PageBloc>().add(GoToSplashPage());
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}

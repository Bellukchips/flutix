part of '../pages.dart';

class NetworkSensitive extends StatelessWidget {
  final Function refresh;
  NetworkSensitive(this.refresh);
  @override
  Widget build(BuildContext context) {
    /// Get our connection status from providers
    ///
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.asset("assets/connection_off.png"))),
            Center(
              child: FloatingActionButton(
                  onPressed: () {
                    if (refresh != null) {
                      refresh();
                    }
                  },
                  elevation: 0,
                  backgroundColor: mainColor,
                  child: Icon(Icons.refresh_outlined)),
            )
          ],
        ),
      ),
    ));
  }
}

part of '../../pages.dart';

class ProsesTransactions extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;
  ProsesTransactions(this.ticket, this.transaction);
  @override
  Widget build(BuildContext context) {
    Future<void> prossesingTicketOrder(BuildContext context) async {
      context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
      context.bloc<SaveticketBloc>().add(BuyTicket(ticket, transaction.userID));
      await FlutixTransactionServices.saveTransaction(transaction);
    }

    //prosess TopUp
    Future<void> prosessingTopUp(BuildContext context) async {
      context.bloc<UserBloc>().add(TopUp(transaction.amount));
      await FlutixTransactionServices.saveTransaction(transaction);
    }

    if (ticket != null) {
      prossesingTicketOrder(context);
      context.bloc<PageBloc>().add(GoToSuccessPage(ticket, transaction));
    } else {
      prosessingTopUp(context);
      context.bloc<PageBloc>().add(GoToSuccessPage(ticket, transaction));
    }
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SpinKitWave(
            color: mainColor,
            size: 60,
          ),
        ),
      ),
    );
  }
}

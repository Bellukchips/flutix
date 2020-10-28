part of './../../pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent pageEvent;
  TopUpPage(this.pageEvent);
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  //textfield controller
  TextEditingController amountController = TextEditingController();
  int selectedAmount = 0;
  bool isSelectAmount = true;
  @override
  Widget build(BuildContext context) {
    double widthCard =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 40) / 3;

    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                context.bloc<PageBloc>().add(widget.pageEvent);
              }),
          centerTitle: true,
          title: Text(AppLocalizations.of(context).translate('topUp'),
              style: blackTextFont.copyWith(
                fontSize: 20,
              )),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    enabled: isSelectAmount,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      CurrencyPtBrInputFormatter()
                    ],
                    keyboardType: TextInputType.number,
                    cursorColor: accentColor2,
                    style: blackNumberFont,
                    autofocus: true,
                    controller: amountController,
                    decoration: InputDecoration(
                        prefixText: "IDR ",
                        prefixStyle: blackNumberFont.copyWith(fontSize: 20),
                        labelStyle: blackNumberFont,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText:
                            AppLocalizations.of(context).translate('amount'),
                        hintText: "20.000"),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('chooseByTemplate'),
                        style: blackTextFont,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    spacing: 20,
                    runSpacing: 14,
                    children: [
                      makeMoneyCard(amount: 50000, width: widthCard),
                      makeMoneyCard(amount: 100000, width: widthCard),
                      makeMoneyCard(amount: 150000, width: widthCard),
                      makeMoneyCard(
                        amount: 200000,
                        width: widthCard,
                      ),
                      makeMoneyCard(
                        amount: 250000,
                        width: widthCard,
                      ),
                      makeMoneyCard(
                        amount: 300000,
                        width: widthCard,
                      ),
                      makeMoneyCard(
                        amount: 350000,
                        width: widthCard,
                      ),
                      makeMoneyCard(
                        amount: 400000,
                        width: widthCard,
                      ),
                      makeMoneyCard(
                        amount: 450000,
                        width: widthCard,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  //button
                  BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) => Button(
                      color: Color(0xff3e9d9d),
                      height: 45,
                      width: 250,
                      textStyle: whiteTextFont.copyWith(fontSize: 16),
                      title:
                          AppLocalizations.of(context).translate('topUpWallet'),
                      onPressed: () async {
                        String temp = "";
                        for (int i = 0; i < amountController.text.length; i++) {
                          temp += amountController.text.isDigit(i)
                              ? amountController.text[i]
                              : '';
                        }
                        setState(() {
                          selectedAmount = int.tryParse(temp) ?? 0;
                        });
                        if (amountController.text == "0" ||
                            amountController.text == "") {
                          Flushbar(
                            duration: Duration(milliseconds: 2000),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: AppLocalizations.of(context)
                                .translate('fillTopUpAmount'),
                          )..show(context);
                        } else if (selectedAmount < 10000 &&
                            selectedAmount > 0) {
                          Flushbar(
                            duration: Duration(milliseconds: 2000),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: AppLocalizations.of(context)
                                .translate('minimumTopUp'),
                          )..show(context);
                        } else {
                          //random int
                          var random = Random();

                          context.bloc<PageBloc>().add(GoToProsessTransactionsPage(
                              null,
                              FlutixTransaction(
                                  id: random.nextInt(100000),
                                  userID: (userState as UserLoaded).user.id,
                                  title: AppLocalizations.of(context)
                                      .translate('topUpWallet'),
                                  subtitle:
                                      "${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}",
                                  amount: selectedAmount,
                                  time: DateTime.now())));
                        }

                        print(selectedAmount);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //money Card

  MoneyCard makeMoneyCard({int amount, double width}) {
    return MoneyCard(
      amount: amount,
      width: width,
      isSelected: amount == selectedAmount,
      onTap: () {
        setState(() {
          if (selectedAmount == amount) {
            isSelectAmount = true;
            selectedAmount = 0;
          } else {
            selectedAmount = amount;
            isSelectAmount = false;
          }

          amountController.text = NumberFormat.currency(
                  locale: 'id_ID', decimalDigits: 0, symbol: '')
              .format(selectedAmount);
          amountController.selection = TextSelection.fromPosition(
              TextPosition(offset: amountController.text.length));
        });
      },
    );
  }
}

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    int value = int.parse(newValue.text);
    final formatter = new NumberFormat.currency(
        locale: "id_ID", symbol: "", decimalDigits: 0);
    String newText = "" + formatter.format(value / 1);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

// TextField(
//                         onChanged: (text) {
//                           String temp = '';

//                           for (int i = 0; i < text.length; i++) {
//                             temp += text.isDigit(i) ? text[i] : '';
//                           }

//                           setState(() {
//                             selectedAmount = int.tryParse(temp) ?? 0;
//                           });

//                           amountController.text = NumberFormat.currency(
//                                   locale: 'id_ID',
//                                   symbol: 'IDR ',
//                                   decimalDigits: 0)
//                               .format(selectedAmount);

//                           amountController.selection =
//                               TextSelection.fromPosition(TextPosition(
//                                   offset: amountController.text.length));
//                         },
//                         controller: amountController,
//                         decoration: InputDecoration(
//                           labelStyle: greyTextFont,
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           labelText: "Amount",
//                         ),
//                       ),

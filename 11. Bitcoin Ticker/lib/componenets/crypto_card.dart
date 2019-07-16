import 'package:flutter/material.dart';

class CryptoCard extends StatefulWidget {
  CryptoCard({
    Key key,
    @required this.cryptoPrice,
    @required this.cryptoType,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String cryptoType;
  final double cryptoPrice;
  final String selectedCurrency;

  _CryptoCardState createState() => _CryptoCardState();
}

class _CryptoCardState extends State<CryptoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 ${widget.cryptoType} = ${widget.cryptoPrice} ${widget.selectedCurrency}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

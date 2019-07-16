import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'bitcoin.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  BitcoinModel bitcoin = BitcoinModel();
  double btcPrice = 0.0;
  double ethPrice = 0.0;
  double ltcPrice = 0.0;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItemsList = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItemsList.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItemsList,
      onChanged: (value) async {
        selectedCurrency = value;
        var bitcoinData = await bitcoin.getLastPrice(
          currency: selectedCurrency,
          cryptoCurrency: 'BTC',
        );
        var etheriumData = await bitcoin.getLastPrice(
          currency: selectedCurrency,
          cryptoCurrency: 'ETH',
        );
        var litecoinData = await bitcoin.getLastPrice(
          currency: selectedCurrency,
          cryptoCurrency: 'LTC',
        );

        updateUI(
          bitcoinData: bitcoinData,
          etheriumData: etheriumData,
          litecoinData: litecoinData,
        );
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> pickerItemList = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItemList.add(newItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        selectedCurrency = currenciesList[selectedIndex];
        var bitcoinData = await bitcoin.getLastPrice(
          currency: selectedCurrency,
          cryptoCurrency: 'BTC',
        );
        var etheriumData = await bitcoin.getLastPrice(
          currency: selectedCurrency,
          cryptoCurrency: 'ETH',
        );
        var litecoinData = await bitcoin.getLastPrice(
          currency: selectedCurrency,
          cryptoCurrency: 'LTC',
        );

        updateUI(
          bitcoinData: bitcoinData,
          etheriumData: etheriumData,
          litecoinData: litecoinData,
        );
      },
      children: pickerItemList,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void updateUI({
    dynamic bitcoinData,
    dynamic etheriumData,
    dynamic litecoinData,
  }) {
    setState(() {
      btcPrice = bitcoinData['last'];
      ethPrice = etheriumData['last'];
      ltcPrice = litecoinData['last'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: CryptoCard(
                  cryptoType: 'BTC',
                  selectedCurrency: selectedCurrency,
                  cryptoPrice: btcPrice,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: CryptoCard(
                  cryptoType: 'ETH',
                  selectedCurrency: selectedCurrency,
                  cryptoPrice: ethPrice,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: CryptoCard(
                  cryptoType: 'LTC',
                  selectedCurrency: selectedCurrency,
                  cryptoPrice: ltcPrice,
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

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

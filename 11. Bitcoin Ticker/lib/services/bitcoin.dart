import 'package:bitcoin_ticker/utilities/constants.dart';
import 'networking.dart';

class BitcoinModel {
  Future<dynamic> getLastPrice({
    String currency = 'USD',
    String cryptoCurrency = 'BTC',
  }) {
    NetworkHelper networkHelper = NetworkHelper(url: '$apiURL$cryptoCurrency$currency');

    var bitcoinData = networkHelper.getData();
    return bitcoinData;
  }
}

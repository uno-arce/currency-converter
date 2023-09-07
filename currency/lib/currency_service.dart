import 'package:currency/currency_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  Future<CurrencyConversionResponse> apiCall(
      String oldCurrency, String newCurrency, String oldAmount) async {
    var url = Uri.https('api.api-ninjas.com', '/v1/convertcurrency',
        {'have': oldCurrency, 'want': newCurrency, 'amount': oldAmount});
    var response = await http.get(
      url,
      headers: {
        'X-Api-Key': 'E8FT86/9TbhMgAhWe/pPUA==1nVI2cw3CpfscNvf',
      },
    );
    print(response.body);
    final json = jsonDecode(response.body);
    return CurrencyConversionResponse.fromJson(json);
  }
}

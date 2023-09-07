import 'package:currency/currency_model.dart';
import 'package:currency/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  TextStyle appTitle =
      GoogleFonts.dmSans(color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle appFont = GoogleFonts.dmSans(fontSize: 14);
  final _oldCurrency = TextEditingController(text: 'PHP');
  final _newCurrency = TextEditingController(text: 'USD');
  final _amount = TextEditingController(text: '100');
  final _currencyService = CurrencyService();

  CurrencyConversionResponse? _currencyConversionResponse;

  _search() async {
    if (_oldCurrency.text.isNotEmpty &&
        _newCurrency.text.isNotEmpty &&
        _amount.text.isNotEmpty) {
      final response = await _currencyService.apiCall(
          _oldCurrency.text, _newCurrency.text, _amount.text);
      setState(() => _currencyConversionResponse = response);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in empty fields',
              style: GoogleFonts.dmSans(fontSize: 14, color: Colors.black)),
          backgroundColor: Color(0xFFFFCEC2),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFDED6),
      appBar: AppBar(
        title: Text('Currency Converter', style: appTitle),
        backgroundColor: const Color(0xFFFFCEC2),
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _currencyConversionResponse != null
                  ? Container(
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '${_currencyConversionResponse!.newAmount.toString()} ${_newCurrency.text}',
                                style: appFont),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Currency Conversion', style: appFont),
                          ],
                        ),
                      ),
                    ),
              SizedBox(height: 24),
              Text('Currency to be converted', style: appFont),
              SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: _oldCurrency,
                  style: appFont,
                  decoration: InputDecoration(
                      hintText: 'USD',
                      hintStyle: appFont,
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none,
                      isDense: true),
                  cursorColor: Colors.orange,
                  maxLength: 3,
                  textCapitalization: TextCapitalization.characters,
                ),
              ),
              SizedBox(height: 12),
              Text('Convert selected currency to', style: appFont),
              SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: _newCurrency,
                  style: appFont,
                  decoration: InputDecoration(
                      hintText: 'PHP',
                      hintStyle: appFont,
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none,
                      isDense: true),
                  cursorColor: Colors.orange,
                  maxLength: 3,
                ),
              ),
              SizedBox(height: 12),
              Text('Amount', style: appFont),
              SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: _amount,
                  style: appFont,
                  decoration: InputDecoration(
                    hintText: '99.9',
                    hintStyle: appFont,
                    labelStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.orange,
                ),
              ),
              SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => _search(),
                icon: Icon(PhosphorIcons.repeat, size: 16, color: Colors.black),
                label: Text('Convert',
                    style:
                        GoogleFonts.dmSans(fontSize: 14, color: Colors.black)),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  side: MaterialStateProperty.all(BorderSide()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencyConversionResponse {
  final double oldAmount;
  final String oldCurrency;
  final String newCurrency;
  final double newAmount;

  CurrencyConversionResponse({
    required this.oldAmount,
    required this.oldCurrency,
    required this.newCurrency,
    required this.newAmount,
  });

  factory CurrencyConversionResponse.fromJson(Map<String, dynamic> json) {
    final double oldAmount = json['old_amount'];
    final String oldCurrency = json['old_currency'];
    final String newCurrency = json['new_currency'];
    final double newAmount = json['new_amount'];

    return CurrencyConversionResponse(
      oldAmount: oldAmount,
      oldCurrency: oldCurrency,
      newCurrency: newCurrency,
      newAmount: newAmount,
    );
  }
}

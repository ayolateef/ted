class CurrentFxModel {
  String? sourceDestinationPair;
  bool? isActive;
  double? rate;
  String? sourceCurrencyCode;
  String? destinationCurrencyCode;
   int? cardUsdFee;

  CurrentFxModel(
      {this.sourceDestinationPair,
        this.isActive,
        this.rate,
        this.sourceCurrencyCode,
        this.destinationCurrencyCode,
         this.cardUsdFee


      });


  CurrentFxModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    if (data != null) {
      final responseData = data['data']['responseData'];
      if (responseData != null) {
        sourceDestinationPair = responseData['sourceDestinationPair'];
        isActive = responseData['isActive'];
        rate = responseData['rate'];
        sourceCurrencyCode = responseData['sourceCurrencyCode'];
        destinationCurrencyCode = responseData['destinationCurrencyCode'];
      }
      cardUsdFee = data['cardUsdFee'];
    }
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sourceDestinationPair'] = sourceDestinationPair;
    data['isActive'] = isActive;
    data['rate'] = rate;
    data['sourceCurrencyCode'] = sourceCurrencyCode;
    data['destinationCurrencyCode'] = destinationCurrencyCode;
    data['cardUsdFee'] = cardUsdFee;
    return data;
  }
}


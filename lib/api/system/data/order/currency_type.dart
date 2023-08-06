enum CurrencyType {
  CNY,
  USD,
  EUR,
  JPY,
  GBP,
  HKD,
  RUB,
}

final Map<CurrencyType, Map<String, String>> currencyData = {
  CurrencyType.CNY: {"code": "CNY", "name": "人民币"},
  CurrencyType.USD: {"code": "USD", "name": "美元"},
  CurrencyType.EUR: {"code": "EUR", "name": "欧元"},
  CurrencyType.JPY: {"code": "JPY", "name": "日元"},
  CurrencyType.GBP: {"code": "GBP", "name": "英镑"},
  CurrencyType.HKD: {"code": "HKD", "name": "港币"},
  CurrencyType.RUB: {"code": "RUB", "name": "俄罗斯卢布"},
};

CurrencyType getCurrencyTypeByCode(String code) {
  for (var entry in currencyData.entries) {
    if (entry.value['code'] == code) {
      return entry.key;
    }
  }
  throw Exception('Invalid currency code');
}

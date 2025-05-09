class DynamicNumberFormat {
  static String? twoDecimalPointers;
  static String? twoDecimalPointersUsd;
  static String? fourDecimalPointerOneZero;
  static String? fourDecimalPointerTwoZero;
  static String? threeDecimalPointerNoZero;
  static String? usdTCasUSDCNumberFormat;
  static String? fiatNumberFormat;
  static String? convertFeeFormat;
  static String? cielToTwoDecimal;
  static String? exchangeRateNumberFormat;
  static String? fourDecimalWithOneZero;

  DynamicNumberFormat._();
  static void init(Map<String, dynamic> numberFormats) {
    twoDecimalPointers = numberFormats["two_decimal_pointers"];
    twoDecimalPointersUsd = numberFormats["two_decimal_pointers_usd"];
    fourDecimalPointerOneZero = numberFormats["four_decimal_pointer_one_zero"];
    fourDecimalPointerTwoZero = numberFormats["four_decimal_pointer_two_zero"];
    threeDecimalPointerNoZero = numberFormats["three_decimal_pointer_no_zero"];
    usdTCasUSDCNumberFormat = numberFormats["usdt_cas_usdc_number_format"];
    fiatNumberFormat = numberFormats["fiat_currency_format"];
    convertFeeFormat = numberFormats["decimal_pointer_convert_fee"];
    cielToTwoDecimal = numberFormats["ciel_to_two_decimal"];
    exchangeRateNumberFormat = numberFormats["exchange_rate_number_format"];
    fourDecimalWithOneZero = numberFormats["four_decimal_with_one_zero"];
  }
}

import 'package:decimal/decimal.dart';

/// Extension BigInt
extension BigIntExt on BigInt {
  /// Format bigint to string with [decimals]
  String tokenString(int decimals) {
    Decimal value = Decimal.fromBigInt(this);
    Decimal decimalValue =
        (value / Decimal.fromInt(10).pow(decimals).toDecimal()).toDecimal();
    return decimalValue.toString();
  }
}

class FormatterBalance {
  /// Calculate gas price to send transaction
  static String configFeeValue({
    required String? beanValue,
    required String? offsetValue,
  }) {
    beanValue = beanValue?.replaceAll("null", "0");
    offsetValue = offsetValue?.replaceAll("null", "0");
    Decimal gasValue = Decimal.parse(beanValue ?? "0") *
        Decimal.fromInt(10).pow(9).toDecimal();
    gasValue = gasValue * Decimal.parse(offsetValue ?? "0");
    var feeValue =
        (gasValue / Decimal.fromInt(10).pow(18).toDecimal()).toDecimal();
    return feeValue.toStringAsFixed(6);
  }
}

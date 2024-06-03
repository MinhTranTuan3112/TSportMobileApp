// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
class PriceUtils {
  static String formatPrice(double price) {
    final formatter = NumberFormat('#,###', 'de_DE');
    return formatter.format(price);
  }
}

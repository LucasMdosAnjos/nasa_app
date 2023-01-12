import 'package:intl/intl.dart';

class Utils {
  static DateTime dateTimeFromString(String value,
      {String format = 'yyyy-MM-dd'}) {
    final DateFormat formatter = DateFormat(format, 'pt-br');

    return formatter.parse(value);
  }

  static String formattedDate(DateTime? value, {String format = 'dd/MM/yyyy'}) {
    final DateFormat formatter = DateFormat(format, 'pt-br');
    final String formatted = formatter.format(value!);
    return formatted;
  }
}

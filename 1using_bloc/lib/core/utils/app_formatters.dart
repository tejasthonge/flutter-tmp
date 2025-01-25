
import 'package:intl/intl.dart';

class AppFormatters {
  static toInt(text) {
    return int.parse(text);
  }

  static toDouble(text) {
    return double.parse(text);
  }

  static formatAmount(amount) {
    return '\u{20B9}${AppFormatters.getNumberFormter().format(amount)}';
  }

  static parseAmount(String? text) {
    return text != null ? text.replaceAll(RegExp(r'[^0-9]'), '') : '';
  }

  static parseAmountToInt(String? text) {
    return AppFormatters.toInt(AppFormatters.parseAmount(text));
  }

  static parseAmountToDouble(String? text) {
    return AppFormatters.toDouble(AppFormatters.parseAmount(text));
  }

  static getNumberFormter() {
    return NumberFormat("#,##,###");
  }

  static formatDate({required DateTime selectedDate}) {
    var suffix = "th";
    var date = selectedDate.day % 10;
    if ((date > 0 && date < 4) && (selectedDate.day < 11 || selectedDate.day > 13)) {
      suffix = ["st", "nd", "rd"][date - 1];
    }
    return DateFormat("d'$suffix' MMMM yyyy").format(selectedDate);
  }

  static formatDateDMY({required DateTime selectedDate}) {
    return DateFormat("dd/MM/yyyy").format(selectedDate);
  }

  static formatAccountNumber(String? accountNumber) {
    return accountNumber!.replaceAll(RegExp(r'\d(?=.{4})'), 'X');
  }

  static dateFormatter(String? normalDate) {
    return normalDate!.replaceAll("-", '/');
  }

  static cleanPDFBase64(text) {
    var rmSpaces = text.replaceAll(' ', '');
    var rmSlash = rmSpaces.replaceAll('\\', '');
    var removeDoubleQuote = rmSlash.replaceAll("\"", '');
    return removeDoubleQuote;
  }
}

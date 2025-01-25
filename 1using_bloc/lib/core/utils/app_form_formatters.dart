import 'package:flutter/services.dart';

import 'index.dart';



class FormAppFormatters {
  static digitOnly({required maxLength}) {
    return [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(maxLength)];
  }

  static alphaOnly({required maxLength, bool upperCase = false}) {
    var arr = [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')), LengthLimitingTextInputFormatter(maxLength)];
    if (upperCase) {
      arr.add(UpperCaseTextFormatter());
    }
    return arr;
  }

  static alphaNumericWithSpacesOnly({required maxLength}) {
    return [FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z\s]')), LengthLimitingTextInputFormatter(maxLength)];
  }

  static alphaWithSpacesOnly({required maxLength, bool upperCase = false}) {
    var arr = [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')), LengthLimitingTextInputFormatter(maxLength)];
    if (upperCase) {
      arr.add(UpperCaseTextFormatter());
    }
    return arr;
  }

  static alphaNumericOnly({required maxLength, bool upperCase = false}) {
    var arr = [FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z]')), LengthLimitingTextInputFormatter(maxLength)];

    if (upperCase) {
      arr.add(UpperCaseTextFormatter());
    }
    return arr;
  }

  static alphaNumericWithSpecialsAndSpaceOnly({required maxLength}) {
    return [FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z.\,;:&@\_\[\](){}\/\-\s]')), LengthLimitingTextInputFormatter(maxLength)];
  }

  static currenyFormatter({required maxLength, fraction = 0}) {
    return [DecimalTextInputFormatter(beforeDecimalRange: maxLength, decimalRange: fraction, format: true)];
  }

  static floatFormatter({required maxLength, fraction = 0}) {
    return [DecimalTextInputFormatter(beforeDecimalRange: maxLength, decimalRange: fraction, format: false)];
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.beforeDecimalRange = 2, this.decimalRange = 0, this.format = false})
      : assert(decimalRange > 0 || beforeDecimalRange > 0);

  final int decimalRange;
  final int beforeDecimalRange;
  final bool format;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text.replaceAll(RegExp(r'[^0-9,.]'), '');
    String numberOnly = truncated.replaceAll(RegExp(r'[^0-9.]'), '');

    String value;

    if (beforeDecimalRange > 0) {
      value = numberOnly;

      if (value.contains(".")) {
        if (value.split(".")[0].length > beforeDecimalRange) {
          truncated = oldValue.text;
          newSelection = oldValue.selection;
        }
      } else {
        if (value.length > beforeDecimalRange) {
          truncated = oldValue.text;
          newSelection = oldValue.selection;
        }
      }
    }

    if (decimalRange > 0) {
      value = numberOnly;

      if (value.contains(".") && value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: truncated.length,
          extentOffset: truncated.length,
        );
      }
    }

    if (format) {
      truncated = truncated.replaceAll(RegExp(r'[^0-9.]'), '');

      String basenum = truncated;
      String decimal = '';
      String newString = '';

      if (truncated.contains(".")) {
        basenum = truncated.split(".")[0];
        decimal = truncated.split(".")[1];
      }

      //Formatting logic separate than decimal and number logic
      if (newValue.text.isEmpty) {
        return newValue.copyWith(text: '');
      } else if (newValue.text.compareTo(oldValue.text) != 0) {
        if (basenum.isNotEmpty) {
          final f = AppFormatters.getNumberFormter();
          final number = int.parse(basenum.replaceAll(f.symbols.GROUP_SEP, ''));
          newString = f.format(number);
        }

        final int selectionIndexFromTheRight = newString.length - basenum.length;

        if (truncated.contains(".")) {
          return TextEditingValue(
            text: newString + "." + decimal,
            selection: TextSelection.collapsed(offset: newSelection.base.offset + selectionIndexFromTheRight),
          );
        } else {
          return TextEditingValue(
            text: newString,
            selection: TextSelection.collapsed(offset: newSelection.base.offset + selectionIndexFromTheRight),
          );
        }
      } else {
        return newValue;
      }
    }
    return TextEditingValue(
      text: truncated,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}

class DecimalWithSpaceInputFormatter extends TextInputFormatter {
  final String format;
  final String separator;

  DecimalWithSpaceInputFormatter({
    required this.format,
    required this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > format.length) return oldValue;
        if (newValue.text.length < format.length && format[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}

//currency textinput formatter
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String amount = AppFormatters.parseAmount(newValue.text);
    double defaultAmount = 0;

    if (amount.isNotEmpty) {
      defaultAmount = double.parse(amount);
    }
    var newAmount = AppFormatters.formatAmount(defaultAmount);
    return newValue.copyWith(text: newAmount, selection: TextSelection.collapsed(offset: newAmount.length));
  }
}

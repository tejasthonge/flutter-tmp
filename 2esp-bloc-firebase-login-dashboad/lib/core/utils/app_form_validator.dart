
extension Validator on String {
  bool isInValidEmail() {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9]([a-zA-Z0-9_-]|(\.(?!\.)))+[a-zA-Z0-9]\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,})+$");
    return emailRegExp.hasMatch(this) ? false : true;
  }

  bool isInValidName() {
    final nameRegExp = RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this) ? false : true;
  }

  bool isNullOrEmpty() {
    return this == '' ? true : false;
  }

  bool isInValidPAN() {
    RegExp panRegExp = RegExp(r"^[A-Z]{3}[P][A-Z][0-9]{4}[A-Z]$");
    return panRegExp.hasMatch(this) ? false : true;
  }

  bool isInValidMobile() {
    final phoneRegExp = RegExp(r"^[6-9]{1}[0-9]{9}$");
    return phoneRegExp.hasMatch(this) ? false : true;
  }

  bool isInValidAadhaar() {
    final phoneRegExp = RegExp(r"^[0-9]{12}$");
    return phoneRegExp.hasMatch(this) ? false : true;
  }

  bool isLessThan(minLimit) {
    final String str = replaceAll(',', '');
    return int.parse(str) < minLimit;
  }

  bool isMoreThan(maxLimit) {
    final String str = replaceAll(',', '');
    return int.parse(str) > maxLimit;
  }
}

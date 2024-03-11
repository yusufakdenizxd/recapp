import 'package:intl/intl.dart';

extension DesignNum on num {
  String get n2 => _FormatHelper.n2(this);

  String get numeric => _FormatHelper.numbericFormat(this);
}

extension DesignDateTim on DateTime {
  String get tarih => _FormatHelper.trTarihAl(this);

  String get tarihAy => _FormatHelper.trTarihAy(this);

  String get tarihAysaat => _FormatHelper.trTarihAySaat(this);

  String get tarihSaat => _FormatHelper.trTarihSaat(this);
}

extension DesingString on String {
  String get phoneTextEdit {
    try {
      return '(${substring(0, 3)}) ${substring(3, 6)} ${substring(6, 8)} ${substring(8)}';
    } catch (e, _) {
      return '';
    }
  }

  String get phoneString {
    return '+90 (${substring(0, 3)}) ${substring(3, 6)} ${substring(6, 8)} ${substring(8)}';
  }
}

class _FormatHelper {
  static final DateFormat _trTarihFormat = DateFormat("dd.MM.yyyy");
  static final DateFormat _trTarihSaatFormat = DateFormat("hh.mm dd.MM.yyyy");
  static final NumberFormat _numericFormat = NumberFormat("#,###");

  static String trTarihAl(final DateTime tarih) => _trTarihFormat.format(tarih);
  static String trTarihSaat(final DateTime tarih) => _trTarihSaatFormat.format(tarih);
  static String trTarihAy(final DateTime tarih) {
    final List<String> _ = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return "${tarih.day} ${_[tarih.month - 1]} ${tarih.year}";
  }

  static String trTarihAySaat(final DateTime tarih) {
    final List<String> _ = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return "${tarih.hour}.${tarih.minute.toString().padLeft(2, '0')} ${tarih.day} ${_[tarih.month - 1]} ${tarih.year}";
  }

  static final NumberFormat n2Format = NumberFormat.decimalPattern('TR')..maximumFractionDigits = 2;

  static String n2(final num? val) {
    if (val == null || val == 0) {
      return '0';
    } else if (val != 0) {
      return n2Format.format(val);
    } else if (val < 0) {
      return '- ${n2Format.format(-val)}';
    } else {
      return '0';
    }
  }

  static String numbericFormat(final num? val) {
    if (val == null || val == 0) {
      return '0';
    } else if (val != 0) {
      return _numericFormat.format(val);
    } else if (val < 0) {
      num xd = -val;
      return '- ${_numericFormat.format(xd)}';
    } else {
      return '0';
    }
  }
}

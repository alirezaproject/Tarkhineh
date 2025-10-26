import 'package:intl/intl.dart';

extension PriceFormat on num {
  String get toPersianTomans {
    final formatter = NumberFormat('#,###', 'fa_IR');
    return '${formatter.format(this)} تومان';
  }

  String get toPersianFormat {
    final formatter = NumberFormat('#,###', 'fa_IR');
    return formatter.format(this);
  }
}

import 'package:intl/intl.dart';

String dateFormatter(DateTime time) {
  if (time == null) return null;

  final String value = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(time);
  num timezone = time.timeZoneOffset.inHours;

  if (timezone < 0) {
    return '$value${prepareNum(timezone)}:00';
  } else {
    return '$value+${prepareNum(timezone)}:00';
  }
}

DateTime parseDate(String date){
  if (date == null) return null;
  return DateTime.tryParse(date);
}

String prepareNum(num) {
  String str = num.toString();

  if (num < 0) {
    if (str.length == 2) {
      return '-0${-num}';
    } else {
      return num.toString();
    }
  } else {
    if (str != '0' && str.length == 1) {
      return '0$num';
    } else {
      return num.toString();
    }
  }
}

DateTime parseWithoutTimeZone(String value) {
  DateTime dateTime = DateTime.tryParse(value);
  return dateTime.add(DateTime.now().timeZoneOffset);
}

String formatDateToDDMMYYYY(
  DateTime dateToFormat, [
  String format = "dd.MM.y",
]) {
  if (dateToFormat == null) throw Exception('Can\'t get time!');

  String dateStr = DateFormat(format).format(dateToFormat);

  return dateStr;
}
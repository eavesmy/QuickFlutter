import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

String formatUTCTime(String time) => time == null
    ? ''
    : DateFormat('MM-dd HH:mm').format(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(time, true).toLocal());

String formatLogTime(DateTime time) {
  return DateFormat("HH:mm:ss.SSS").format(time);
}

logI(dynamic message, {Level lever, String name}) {
  // Logger(name ?? "MYCI").info(message);
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(message?.toString() ?? '').forEach((element) => log(
        element.group(0),
        time: DateTime.now(),
        level: lever?.value ?? Level.FINE.value,
        name: name ?? "MYCI",
      ));
}

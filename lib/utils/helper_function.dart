import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
String getFormattedDate(dt) => DateFormat('dd/MM/yyyy').format(dt!);
String getFormattedTime(t) => DateFormat('hh:mm a')
    .format(DateTime(0, 0, 0, t!.hour, t!.minute));


String calculateTimeDifference(DateTime dueDate) {
  DateTime now = DateTime.now();
  Duration difference = dueDate.difference(now);

  if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'}';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'}';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'}';
  } else {
    return 'Due now';
  }
}
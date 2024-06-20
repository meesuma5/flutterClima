String capitalizeFirstLetterOfEachWord(String text) {
  return text.split(' ').map((word) {
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}

String convert24To12Hour(String time24) {
  // Split hours and minutes
  List<String> parts = time24.split(':');
  int hour = int.parse(parts[0]);
  String minute = parts[1];

  // Determine AM/PM
  String period = hour >= 12 ? 'PM' : 'AM';

  // Convert hour to 12-hour format
  if (hour == 0) {
    hour = 12; // Midnight case
  } else if (hour > 12) {
    hour -= 12; // After noon case
  }

  // Construct and return formatted time
  return '$hour:$minute $period';
}

String getMonth(int month) {
  if (month == 1) {
    return 'January';
  } else if (month == 2) {
    return 'February';
  } else if (month == 3) {
    return 'March';
  } else if (month == 4) {
    return 'April';
  } else if (month == 5) {
    return 'May';
  } else if (month == 6) {
    return 'June';
  } else if (month == 7) {
    return 'July';
  } else if (month == 8) {
    return 'August';
  } else if (month == 9) {
    return 'September';
  } else if (month == 10) {
    return 'October';
  } else if (month == 11) {
    return 'November';
  } else if (month == 12) {
    return 'December';
  } else {
    return 'Unknown';
  }
}

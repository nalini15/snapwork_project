import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snapwork/models/events.dart';

class Handler with ChangeNotifier {
  List<EventsDates> events = [];
  List<EventsDates> get getEvents {
    return [...events];
  }

  String year = null;
  String month = null;
  final f = new DateFormat('yyyy-MM-dd');
  DateTime now = DateTime.now();
  List<String> getYears() {
    return [
      "2016",
      "2017",
      "2018",
      "2019",
      "2020",
      "2021",
      "2022",
      "2023",
      "2024",
      "2025",
    ]; // 2016 to 2025
  }

  void clearForm() {
    formData = {"time": null, "date": "", "title": "", "descp": ""};
    notifyListeners();
  }

  void setYearOrMonth(String data, bool isyear) {
    if (isyear) {
      year = data;
    } else {
      month = data;
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> getMonth() {
    return [
      {"month": "Jan", "mon": "01"},
      {"month": "Feb", "mon": "02"},
      {"month": "Mar", "mon": "03"},
      {"month": "Apr", "mon": "04"},
      {"month": "May", "mon": "05"},
      {"month": "Jun", "mon": "06"},
      {"month": "Jul", "mon": "07"},
      {"month": "Aug", "mon": "08"},
      {"month": "Sep", "mon": "09"},
      {"month": "Oct", "mon": "10"},
      {"month": "Nov", "mon": "11"},
      {"month": "Dec", "mon": "12"},
    ];
  }

  void getDatesForMonth(DateTime yearMonth) {
    var totalDays = daysInMonth(yearMonth);
    var listOfDates = new List<int>.generate(totalDays, (i) => i + 1);
    events.clear();

    listOfDates.forEach((element) {
      events.add(EventsDates(
          date: f.format(yearMonth),
          dateOfEvent: "",
          timeOfEvent: "",
          eventDesp: "",
          title: ""));
    });
    print(listOfDates.length);
    notifyListeners();
  }

  int daysInMonth(DateTime date) {
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  void setFormData(Map<String, String> data) {
    formData = data;
    notifyListeners();
  }

  void updateEvents(int index) {
    events[index].dateOfEvent = formData["date"];
    events[index].title = formData["title"];
    events[index].eventDesp = formData["descp"];
    events[index].timeOfEvent = formData["time"];
    notifyListeners();
  }

  Map<String, String> formData = {
    "time": null,
    "date": "",
    "title": "",
    "descp": ""
  };
}

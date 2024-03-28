import 'dart:io';

extension DateTimeExtension on DateTime {
  String parseDateTimeToString() {
    return toString().split(" ").first;
  }
}

extension FileExtension on File {
  bool isPdfFile() {
    return path.split(".").last == "pdf";
  }

  bool isAppGeneratedFile() {
    return path.contains("311_");
  }
}

extension StringExtension on String {
  String getFileExtension() {
    return split(".").last;
  }

  String get getFileName {
    return split("/").last;
  }

  String capatilizeEveryFirstWord() {
    var wordList = split(" ");
    var capatilize =
        wordList.map((e) => "${e[0].toUpperCase()}${e.substring(1)}").toList();
    return capatilize.join(" ");
  }

  String getFirstName() {
    var name = trim();
    var list = name.split(" ");
    list.removeLast();
    return list.join(" ");
  }

  String getFamilyName() {
    var name = trim();
    return name.split(" ").last;
  }

  bool isUrlLink() {
    return contains("https://");
  }
}

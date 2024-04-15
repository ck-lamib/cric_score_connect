import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/screens/match/enums/extra.dart';
import 'package:cric_score_connect/screens/match/enums/out.dart';
import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:get/get.dart';

class Delivery extends GetxController {
  int runs;
  User? batter;
  User? bowler;
  List<Extra> extras = [Extra.none];
  Out out;

  Delivery({
    this.runs = 0,
    this.batter,
    this.bowler,
    List<Extra>? extras,
    this.out = Out.none,
  }) : extras = extras ?? [Extra.none];

  Delivery copyWith({
    int? runs,
    User? batter,
    User? bowler,
    dynamic extras,
    Out? out,
  }) {
    return Delivery(
      runs: runs ?? this.runs,
      batter: batter ?? this.batter,
      bowler: bowler ?? this.bowler,
      extras: extras ?? this.extras,
      out: out ?? this.out,
    );
  }

  addBatter(User p) {
    batter = p;
  }

  // addBowler(User p) {
  //   bowler = p;
  // }

  bool isWide() {
    return extras.contains(Extra.wide);
  }

  bool isNoBall() {
    return extras.contains(Extra.noBall);
  }

  bool isLegBye() {
    return extras.contains(Extra.legBye);
  }

  bool isBye() {
    return extras.contains(Extra.bye);
  }

  addExtra(Extra e) {
    if (e == Extra.none) {
      return;
    }
    if (extras[0] == Extra.none) {
      CustomLogger.trace(extras);
      extras[0] = e;
      if (runs == 0 && e != Extra.wide && e != Extra.noBall) {
        runs = 1;
      }
    } else if (!e.allowedWith(extras)) {
      return;
    } else {
      extras.add(e);
      print(e);
      if (runs == 0 && e != Extra.wide && e != Extra.noBall) {
        runs = 1;
      }
    }
    update();
  }

  addRuns(int runs) {
    this.runs += runs;
    update();
  }

  addOut(Out out) {
    this.out = out;
  }

  finshAddOut() {
    update();
  }

  bool validate() {
    return true;
  }

  // String shortSummary() {
  //   var wicket = '';
  //   if (out != Out.none) {
  //     wicket = 'W';
  //   }
  //   var ext = '';
  //   if (extras[0] != Extra.none) {
  //     ext = extras.map((e) => e.shortCode()).join('+');
  //   }
  //   var tail = [wicket, ext].where((t) => t != '').join('+');
  //   if (tail != '' && runs == 0) {
  //     return tail;
  //   }
  //   return '$runs,$tail';
  // }

  //"run,extras,wicket"
  String shortSummary() {
    var wicket = '';
    if (out != Out.none) {
      wicket = 'W';
    }
    var ext = '';
    if (extras[0] != Extra.none) {
      ext = extras.map((e) => e.shortCode().toUpperCase()).join('-');
    }
    var tail = [ext].where((t) => t != '').join('-');
    var result = '';
    if (tail != '' && runs == 0) {
      result = "0,$tail,$wicket";
    }
    result = '$runs,$tail,$wicket';
    return result;
  }

  void reset() {
    runs = 0;
    batter = null;
    bowler = null;
    extras = [Extra.none];
    out = Out.none;
  }

  bool isPenalty() {
    return extras.contains(Extra.penalty);
  }

  bool isBonus() {
    return extras.contains(Extra.bonus);
  }

  @override
  String toString() {
    return '$out $runs $bowler,$batter,  $extras';
  }
}

class StarResultModel {
  int? deductCount;
  int? deductScore;
  int? fullMarksCount;
  int? getScore;
  int? qualifiedCount;
  int? totalScore;
  int? unCheckCount;
  int? unqualifiedCount;
  int? unusedCount;

  StarResultModel(
      {this.deductCount,
        this.deductScore,
        this.fullMarksCount,
        this.getScore,
        this.qualifiedCount,
        this.totalScore,
        this.unCheckCount,
        this.unqualifiedCount,
        this.unusedCount});

  StarResultModel.fromJson(Map<String, dynamic> json) {
    deductCount = json['deductCount'];
    deductScore = json['deductScore'];
    fullMarksCount = json['fullMarksCount'];
    getScore = json['getScore'];
    qualifiedCount = json['qualifiedCount'];
    totalScore = json['totalScore'];
    unCheckCount = json['unCheckCount'];
    unqualifiedCount = json['unqualifiedCount'];
    unusedCount = json['unusedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deductCount'] = deductCount;
    data['deductScore'] = deductScore;
    data['fullMarksCount'] = fullMarksCount;
    data['getScore'] = getScore;
    data['qualifiedCount'] = qualifiedCount;
    data['totalScore'] = totalScore;
    data['unCheckCount'] = unCheckCount;
    data['unqualifiedCount'] = unqualifiedCount;
    data['unusedCount'] = unusedCount;
    return data;
  }
}

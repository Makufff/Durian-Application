class ResultModel {
  final String image;
  final int categoryid;
  final List bbox;
  final double score;

  ResultModel(
      {required this.image,
      required this.categoryid,
      required this.bbox,
      required this.score});

  factory ResultModel.fromRTDB(Map<String, dynamic> data) {
    return ResultModel(
        image: data['image_id'] ?? 'Unknown',
        categoryid: data['category_id'] ?? 0,
        bbox: data['bbox'] ?? {0, 0, 0, 0},
        score: data['score'] ?? 0);
  }
}

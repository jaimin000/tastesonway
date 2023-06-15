class HearAboutModel {
  dynamic id;
  String text;

  HearAboutModel({this.id, required this.text});

  HearAboutModel.fromJson(json)
      : id = json['id'].toString(),
        text = json['text'].toString();
}

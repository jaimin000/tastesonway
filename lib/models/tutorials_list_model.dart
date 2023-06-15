class TutorialModel {
  String title="";
  String youtubeUrl="";
  List<TutorialFAQQuestionModel> questions;

  TutorialModel({required this.title, required this.youtubeUrl, required this.questions});
}

class TutorialFAQQuestionModel {
  String question="";
  String answer="";

  TutorialFAQQuestionModel({required this.question, required this.answer});
}

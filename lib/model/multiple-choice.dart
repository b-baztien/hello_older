class MultipleChoice {
  String question;
  List<String> listChoice = new List();
  int correctAnswer;

  MultipleChoice({this.question, this.listChoice, this.correctAnswer});

  factory MultipleChoice.fromJson(Map<String, dynamic> json) {
    return MultipleChoice(
      question: json['question'],
      listChoice: (json['listChoice']).map((data) => data).toList(),
      correctAnswer: json['correctAnswer'],
    );
  }

  void randomQuestion() {
    String correctChoice = listChoice[correctAnswer];
    listChoice.shuffle();
    correctAnswer = listChoice.indexOf(correctChoice);
  }

  bool checkAnswer(int ans) {
    return ans == correctAnswer;
  }
}

import 'package:hello_older/model/multiple-choice.dart';

class TakeExam {
  List<MultipleChoice> listQuestion = new List();
  String studentName;
  bool isRandomChoice = false;

  TakeExam({this.isRandomChoice}) {
    listQuestion = _readQuestionData();

    if (isRandomChoice) {
      for (var question in listQuestion) {
        question.randomQuestion();
      }
      listQuestion.shuffle();
    }
  }

  List<MultipleChoice> _readQuestionData() {
    List<MultipleChoice> listChoice = new List();

    listChoice.add(new MultipleChoice(
        question: "การจะเข้าสู่วัยชราด้วยความสุข ควรเริ่มต้นด้วยวิธีใดก่อน",
        listChoice: [
          "การปรับตัวให้มีจิตวิทยาเชิงบวก",
          "การเก็บเงินให้ได้มากที่สุด",
          "การปรับปรุงที่พักอาศัยให้พร้อมสำหรับวัยชรา",
          "การให้ลูกหลานมาพักอยู่ใกล้ๆ"
        ],
        correctAnswer: 0));

    listChoice.add(new MultipleChoice(
        question: "ข้อใดต่อไปนี้เป็นลักษณะของคนที่มี “<bold>ความหวัง</bold>”",
        listChoice: [
          "เชื่อว่าตนเองสามารถหาแนวทางให้บรรลุเป้าหมายได้",
          "ตั้งเป้าหมายให้ท้าทาย",
          "มีความตั้งใจที่จะทำเพื่อทุกคนในครอบครัว",
          "มีความเชื่อมั่นในศักยภาพของตนเอง"
        ],
        correctAnswer: 0));

    listChoice.add(new MultipleChoice(
        question:
            "ข้อใดต่อไปนี้<bold-underline>ไม่ใช่</bold-underline>นิยามของการมองโลกในแง่ดี",
        listChoice: [
          "มีความคิดบวกต่อคนอื่น",
          "มีความสามารถในการยอมรับความจริง",
          "เชื่อว่าเหตุการณ์ทางบวกจะเกิดขึ้นกับตนเอง",
          "ตั้งเป้าหมายให้สูงที่สุดเท่าที่จะทำได้"
        ],
        correctAnswer: 3));

    listChoice.add(new MultipleChoice(
        question:
            "ข้อใดต่อไปนี้<bold-underline>ไม่ใช่</bold-underline>ความสามารถในการฟื้นพลัง ",
        listChoice: [
          "สามารถปรับสภาพจิตใจได้ เมื่อเจอกับปัญหาในชีวิต",
          "สามารถทำกิจวัติประจำวันได้ด้วยตนเอง",
          "เมื่อสูญเสียคนในครอบครัว สามารถกลับมาใช้ชีวิตตามปกติได้",
          "สามารถปรับตัวได้เมื่ออยู่ในสถานการณ์ที่เป็นปัญหา"
        ],
        correctAnswer: 1));

    listChoice.add(new MultipleChoice(
        question:
            "ข้อใดต่อไปนี้เป็นตัวอย่างของ “<bold>การเป็นผู้สูงอายุที่ยังประโยชน์</bold>” ",
        listChoice: [
          "สามารถดูแลคนในครอบครัวได้",
          "การเดินทางไปต่างจังหวัดได้ด้วยตนเอง",
          "การถ่ายทอดความรู้และประสบการณ์ของตนเองให้แก่ลูกหลานและคนในชุมชน",
          "การหารายเงินได้จำนวนมากๆ แม้ว่าจะอายุเยอะแล้ว"
        ],
        correctAnswer: 2));

    listChoice.add(new MultipleChoice(
        question: "วัยกลางคนควรตรวจร่างกายประจำปี อย่างน้อยปีละกี่ครั้ง ",
        listChoice: [
          "ปีละ 1 ครั้ง",
          "ปีละ 2 ครั้ง",
          "ไปให้บ่อยที่สุดเท่าที่จะทำได้",
          "ไปพบแพทย์เมื่อมีอาการเจ็บป่วยเท่านั้น"
        ],
        correctAnswer: 0));

    listChoice.add(new MultipleChoice(
        question:
            "ข้อใด<bold-underline>ไม่ใช่</bold-underline>การเตรียมความพร้อมก่อนการเข้าวัยผู้สูงอายุ “<bold>ด้านจิตใจ</bold>”",
        listChoice: [
          "ทำจิตใจเตรียมรับมือกับความเสื่อมของร่างกาย",
          "ส่งเสริมให้ลูกได้ทำงานดีๆ เพื่อเราจะได้สบายใจ",
          "หมั่นทำจิตใจให้สดใสเบิกบาน",
          "ศึกษาธรรมะ หรือร่วมกิจกรรมทางศาสนา รู้จักปล่อยวาง"
        ],
        correctAnswer: 1));

    listChoice.add(new MultipleChoice(
        question:
            "ข้อใดต่อไปนี้<bold-underline>ไม่ใช่</bold-underline>ตัวอย่างของการเตรียมความพร้อมก่อนการเข้าวัยผู้สูงอายุ “<bold>ด้านสังคม</bold>”",
        listChoice: [
          "ประกอบอาชีพที่เหมาะสมตามวัยและสภาพร่างกาย ",
          "ทำงานให้น้อยที่สุด เพื่อให้มีเวลาพักผ่อน",
          "การเรียนรู้ที่จะพัฒนาตนเอง",
          "การทำความรู้จักเพื่อนต่างวัย"
        ],
        correctAnswer: 1));

    listChoice.add(new MultipleChoice(
        question:
            "ช่วงอายุก่อน 50-60 ปี เป็นช่วงที่เหลือเวลาทำงานไม่นาน ควรแบ่งเงินออมไม่ต่ำกว่ากี่เปอร์เซนต์ของรายได้",
        listChoice: [
          "ไม่ต่ำกว่า 25 % ของรายได้",
          "ไม่ต่ำกว่า 30 % ของรายได้",
          "ไม่ต่ำกว่า 35% ของรายได้",
          "ไม่ต่ำกว่า 70 % ของรายได้"
        ],
        correctAnswer: 3));

    listChoice.add(new MultipleChoice(
        question:
            "ข้อใดเป็นตัวขัดขวางการเตรียมความพร้อมก่อนการเข้าวัยผู้สูงอายุ “<bold>ด้านเศรษฐกิจ</bold>”",
        listChoice: [
          "การไม่ออมเงิน",
          "การออมเงินในจำนวนน้อยเกินไป",
          "หนี้สิน",
          "รายจ่ายต่อเดือน"
        ],
        correctAnswer: 2));

    return listChoice;
  }

  int calculateScore(List<String> listAnswer) {
    int score = 0;
    int indexAns;
    for (int i = 0; i < listQuestion.length; i++) {
      indexAns = listQuestion[i].listChoice.indexOf(listAnswer[i]);
      if (listQuestion[i].checkAnswer(indexAns)) {
        score++;
      }
    }
    return score;
  }
}

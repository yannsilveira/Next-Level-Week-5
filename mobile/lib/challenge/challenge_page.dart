import 'package:DevQuiz/challenge/challenge_controller.dart';
import 'package:DevQuiz/challenge/widget/next_button/next_button_widget.dart';
import 'package:DevQuiz/challenge/widget/question_indicator_widget/question_indicator_widget.dart';
import 'package:DevQuiz/challenge/widget/quiz/quiz_widget.dart';
import 'package:DevQuiz/result/result_page.dart';
import 'package:DevQuiz/shared/models/question_model.dart';
import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  ChallengePage({Key? key, required this.questions}) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();
  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });
    super.initState();
  }
  
  void nextPage() {
    pageController.nextPage(duration: Duration(milliseconds: 30), curve: Curves.linear);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(86),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            BackButton(),
            ValueListenableBuilder<int>(valueListenable: controller.currentPageNotifier, builder: (context, value, _) => QuestionIndicatorWidget(
              currentPage: value,
              length: widget.questions.length)),
          ],
          )),
      ),
      body: PageView(
        controller: pageController,
        children: widget.questions.map((e) => QuizWidget(question: e, onChange: nextPage)).toList(),
      ),
      bottomNavigationBar: SafeArea(
          bottom: true,    
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Expanded(child: NextButtonWidget.white(label: "Pular", onTap: nextPage)),
            SizedBox(width: 7,), 
            Expanded(child: NextButtonWidget.green(label: "Confirmar", onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultPage()));
            },)),
        ],),
          ),
      ),
    );
  }
}
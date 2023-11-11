import 'package:flutter/material.dart';
//Open AI API
import 'package:kisan_mitra_app/API/openai_services.dart';
import 'package:kisan_mitra_app/Widgets/feature_box.dart';
import 'package:kisan_mitra_app/pallete.dart';
// import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

//Speech to text
import 'package:speech_to_text/speech_to_text.dart';

class Consultant extends StatefulWidget {
  const Consultant({super.key});

  @override
  State<Consultant> createState() => _ConsultantState();
}

class _ConsultantState extends State<Consultant> {
  SpeechToText speechToText = SpeechToText();
  // String to store speech to text
  String lastWords = '';
  // OpenAI Custom Function
  OpenAIService openAIService = OpenAIService();

  //Text to Speech
  // final flutterTts = FlutterTts();

  String? generatedContent;
  String? generatedImageUrl;

  @override
  void initState() {
    super.initState();
    initspeechtotext();
    // initTextToSpeech();
  }

  // This has to happen only once per app session

  // Future<void> initTextToSpeech() async {
  //   await flutterTts.setSharedInstance(true);
  //   setState(() {});
  // }

  Future<void> initspeechtotext() async {
    await speechToText.initialize();
    setState(() {});
  }

  // Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  //Text to Speech Function
  // Future<void> systemSpeak(String content) async {
  //   await flutterTts.speak(content);
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Assistant Icon
          Stack(
            children: [
              //Background Circle
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  margin: const EdgeInsets.only(top: 30),
                  decoration: const BoxDecoration(
                    color: Pallete.assistantCircleColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              //Larger Image of Assistant
              Container(
                  height: 123,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/virtualAssistant.png'),
                      )))
            ],
          ),

          //Response Bubble
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin:
                const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
            decoration: BoxDecoration(
                border: Border.all(color: Pallete.borderColor),
                borderRadius: BorderRadius.circular(20)
                    .copyWith(topLeft: const Radius.circular(0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                generatedContent == null
                    ? "Good Morning, What task can i do for you?"
                    : generatedContent!,
                style: TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize: generatedContent == null ? 25 : 18,
                    fontFamily: 'Cera Pro'),
              ),
            ),
          ),

          //Suggestions
          Visibility(
            visible: generatedContent == null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.fromLTRB(22, 10, 0, 0),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Here are few Features",
                style: TextStyle(
                    fontFamily: 'Sera Pro',
                    fontSize: 20,
                    color: Pallete.mainFontColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          //Features List
          Visibility(
            visible: generatedImageUrl == null,
            child: Column(
              children: const [
                FeatureBox(
                    color: Pallete.firstSuggestionBoxColor,
                    headerText: "Farming Expert",
                    descText:
                        "A smarter way to stay organized and informed with AI powered farming Consultant"),
                FeatureBox(
                    color: Pallete.thirdSuggestionBoxColor,
                    headerText: "Finance Expert",
                    descText: "Get the best financial advice for farmers"),
                FeatureBox(
                    color: Pallete.secondSuggestionBoxColor,
                    headerText: "Smart Voice Assistant",
                    descText:
                        "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT"),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

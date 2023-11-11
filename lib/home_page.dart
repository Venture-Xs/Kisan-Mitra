import 'package:flutter/material.dart';

//A package for creating badges. Badges can be used for an additional marker for any widget,
import 'package:badges/badges.dart' as badges;

//Flutter package for using Iconly Icons.
import 'package:iconly/iconly.dart';
import 'package:kisan_mitra_app/API/openai_services.dart';

import 'package:kisan_mitra_app/Dashboard/dashboard.dart';
import 'package:kisan_mitra_app/DiseasePrediction/disease_prediction.dart';
import 'package:kisan_mitra_app/FarmerConsultant/consultant.dart';
import 'package:kisan_mitra_app/LoanApplication/loan_finder.dart';
import 'package:kisan_mitra_app/pallete.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //SpeechToText Object
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

  //initiliaze speechToText object
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

  //List of Widgets
  final pages = [
    const DashBoard(),
    const Consultant(),
    const DetectDisease(),
    const LoanFinder()
  ];
  int currentPageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi Anish 👋🏾",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text("Enjoy our services",
                style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: badges.Badge(
                badgeContent: const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                position: badges.BadgePosition.topEnd(top: -15, end: -12),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.green,
                ),
                child: const Icon(Icons.notifications_outlined),
              ),
            ),
          ),
        ],
      ),
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Home",
            activeIcon: Icon(Icons.dashboard),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Consultant",
            activeIcon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats),
            label: "Disease",
            activeIcon: Icon(Icons.query_stats),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance,
            ),
            label: "Loan",
            activeIcon: Icon(Icons.account_balance),
          ),
        ],
      ),

      //Mic
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
            print('Processing');
          } else if (speechToText.isListening) {
            //print(lastWords);
            final speech = await openAIService.isArtPromptApi(lastWords);
            print(speech);
            //if the speech contains https then it is an image
            if (speech.contains('https')) {
              generatedImageUrl = speech;
              generatedContent = null;
              setState(() {}); //used to store the value in the variable
            } else {
              generatedContent = speech;
              generatedImageUrl = null;
              setState(() {});
              // await systemSpeak(speech);
            }
            //
            await stopListening();
          } else {
            initspeechtotext();
          }
        },
        backgroundColor: Pallete.firstSuggestionBoxColor,
        child: Icon(
          speechToText.isListening ? Icons.stop : Icons.mic,
        ),
      ),
    );
  }
}

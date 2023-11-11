import 'package:flutter/material.dart';
import 'package:kisan_mitra_app/API/openai_services.dart';
import 'package:kisan_mitra_app/pallete.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatBot extends StatefulWidget {
  String inputString;
  ChatBot({
    Key? key,
    required this.inputString,
  }) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  SpeechToText speechToText = SpeechToText();
  // String to store speech to text
  String lastWords = '';
  // OpenAI Custom Function
  OpenAIService openAIService = OpenAIService();

  //Text to Speech
  // final flutterTts = FlutterTts();

  //Contents of the chatbot
  String? generatedContent;
  String? generatedImageUrl;

  @override
  void initState() {
    super.initState();
    initspeechtotext();
    if (widget.inputString.isNotEmpty) {
      _sendMessage({'role': 'user', 'content': widget.inputString});
      animateMsg(widget.inputString);
    } else {
      _sendMessage(null);
    }
  }

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

  //messages history list
  final List<Map<String, String>> _messages = [];

  //controller for text field
  final TextEditingController _controller = TextEditingController();

  // final String apiKey = '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';

  // Function to put the user and bot messages into _message[]
  void _sendMessage(Map<String, String>? message) {
    setState(() {
      // If there is no messages in the _messages list then add a default message
      if (message == null) {
        _messages.add({
          'role': 'bot',
          'content': 'Good Morning, What task can i do for you?',
        });
      } else if (message['role'] == 'bot') {
        _messages.add({
          'role': 'bot',
          'content': message['content']!,
        });
      } else {
        _messages.add({
          'role': 'user',
          'content': message['content']!,
        });
      }
    });
    _controller.clear();
  }

  Future<String> animateMsg(String text) async {
    // Add a loading message
    setState(() {
      _messages.add({
        'role': 'bot',
        'content': 'Loading...',
      });
    });

    try {
      // Wait for the Future to complete
      final speech = await openAIService.isArtPromptApi(text);

      // Once the Future is complete, remove the loading message and add new
      setState(() {
        _messages.removeLast();
        _messages.add({
          'role': 'bot',
          'content': speech,
        });
      });

      return speech;
    } catch (e) {
      // Handle any errors here
      print('Caught error: $e');
      throw 'An Error Occured';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: _messages[index]['role'] == 'bot'
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: _messages[index]['role'] == 'bot'
                          ? Colors.grey[300]
                          : Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: _messages[index]['role'] == 'bot'
                          ? const BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                    ),
                    child: Text(
                      _messages[index]['content']!,
                      style: TextStyle(color: Color.fromARGB(255, 77, 3, 89)),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Query',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Theme.of(context).colorScheme.primary,
                        ),

                        //Send Message Button On Click
                        onPressed: () async {
                          if (_controller.text.isEmpty) {
                            return;
                          } else {}
                          String text = _controller.text;
                          _sendMessage({'role': 'user', 'content': text});
                          final speech = await animateMsg(text);
                          print(speech);

                          //if the speech contains https then it is an image
                          if (speech.contains('https')) {
                            generatedImageUrl = speech;
                            generatedContent = null;
                            _sendMessage(
                                {'role': 'bot', 'content': generatedImageUrl!});
                          } else {
                            generatedContent = speech;
                            generatedImageUrl = null;

                            // _sendMessage(
                            //     {'role': 'bot', 'content': generatedContent!});
                          }
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 233, 241),
                            width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 224, 192, 230),
                            width: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                //Mic
                Container(
                  decoration: BoxDecoration(
                      color: Pallete.whiteColor,
                      borderRadius: BorderRadius.circular(40)),
                  child: IconButton(
                      icon: speechToText.isListening
                          ? const Icon(Icons.stop)
                          : const Icon(Icons.mic),
                      //Send Voice Message Button On Click
                      onPressed: () async {
                        if (await speechToText.hasPermission &&
                            speechToText.isNotListening) {
                          await startListening();
                          print('Processing');
                        } else if (speechToText.isListening) {
                          //print(lastWords);
                          final speech =
                              await openAIService.isArtPromptApi(lastWords);
                          print(speech);
                          //if the speech contains https then it is an image
                          if (speech.contains('https')) {
                            generatedImageUrl = speech;
                            generatedContent = null;

                            _sendMessage(
                                {'role': 'bot', 'content': generatedImageUrl!});
                          } else {
                            generatedContent = speech;
                            generatedImageUrl = null;

                            _sendMessage(
                                {'role': 'bot', 'content': generatedContent!});
                          }
                          //
                          await stopListening();
                        } else {
                          initspeechtotext();
                        }
                      },
                      color: Theme.of(context).colorScheme.primary),
                ),
              ],
            )),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final String apiKey = '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';

  void _sendMessage() {
    setState(() {
      _messages.add(_controller.text);
    });
    _controller.clear();
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
                mainAxisAlignment: _messages[index].startsWith('Bot: ')
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
                      color: _messages[index].startsWith('Bot: ')
                          ? Colors.grey[300]
                          : Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                    ),
                    child: Text(
                      _messages[index],
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
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _sendMessage(),
              decoration: InputDecoration(
                hintText: 'Enter message',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: _sendMessage,
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
                      color: Color.fromARGB(255, 240, 233, 241), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 224, 192, 230), width: 2),
                ),
              ),
            )),
      ],
    );
  }
}

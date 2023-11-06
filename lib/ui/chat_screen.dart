import 'package:esalerz/model/chat/chatmodel.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/bigtext.dart';
import 'package:esalerz/ui/widgets/text_edit_view.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final List<ChatMessage> initialMessages; // Add this property

  const ChatScreen({required this.initialMessages});
  @override
  _ChatScreenState createState() => _ChatScreenState(messages: initialMessages);
}

class _ChatScreenState extends State<ChatScreen> {
  String formattedTime = '';
  final List<ChatMessage> messages;
  _ChatScreenState({required this.messages});

  final TextEditingController _textController = TextEditingController();

  void _handleSubmittedMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        messages.add(
          ChatMessage(text: text, timestamp: DateTime.now(), isMe: true),
        );
      });
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTime = TimeOfDay.now();
    formattedTime = '${currentTime.hour}:${currentTime.minute}';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/man.jpg'),
              radius: 15,
            ),
            const SizedBox(width: 8),
            BigText(
              text: 'Dr. Marshal',
              size: 18,
            ),
          ],
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.arrow_back, color: AppColors.lightPrimary),
            ),
          ),
        ),
        actions: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/call.png',
                height: 25,
                color: AppColors.lightPrimary,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/video.png',
                height: 25,
                color: AppColors.lightPrimary,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppImages.bg,
                    ),
                    fit: BoxFit.cover)),
          ),
          Container(
            color: Colors.white70,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
          Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ListTile(
                      title: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: AppColors.lightPrimary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(3),
                              )),
                          child: Text(
                              message.text,
                              style: TextStyle(
                            color: Colors.white,

                              ),
                          ),
                        ),
                      ),
                      subtitle: Text(
                        message.isMe ? formattedTime : 'Other User',
                        textAlign:
                            message.isMe ? TextAlign.right : TextAlign.left,
                      ),
                      // Display timestamp here if needed
                    );
                  },
                ),
              ),
              const Divider(height: 1.0),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                child: _buildTextComposer(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(
        color: Theme.of(context).canvasColor,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
                //color: AppColors.lightPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: Image.asset(
                  'assets/images/gallery-add.png',
                  color: AppColors.lightPrimary,
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: TextEditView(
                borderWidth: 0.5,
                controller: _textController,
                hintText: 'Type something',
                onFieldSubmitted: _handleSubmittedMessage,
                filled: false,
                autofocus: false,
                isDense: true,
                borderColor: AppColors.lightPrimary,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmittedMessage(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

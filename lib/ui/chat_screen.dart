import 'package:esalerz/model/user_model/message_list.dart';
import 'package:esalerz/res/app_colors.dart';
import 'package:esalerz/res/app_images.dart';
import 'package:esalerz/ui/widgets/bigtext.dart';
import 'package:esalerz/ui/widgets/text_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../blocs/user/user.dart';
import '../handlers/secure_handler.dart';
import '../model/view_models/user_view_model.dart';
import '../requests/repositories/user_repo/user_repository_impl.dart';
import 'widgets/empty_widget.dart';
import 'widgets/loading_page.dart';
import 'widgets/modals.dart';

class ChatScreen extends StatelessWidget {
  final String receiverEmail;
  const ChatScreen({
    Key? key,
    required this.receiverEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: Chat(
        receiverEmail: receiverEmail,
      ),
    );
  }
}

class Chat extends StatefulWidget {
  final String receiverEmail;

  const Chat({super.key, required this.receiverEmail});

  @override
  _ChatState createState() => _ChatState(receiverEmail: receiverEmail);
}

class _ChatState extends State<Chat> {
  String formattedTime = '';

  final String receiverEmail;

  final TextEditingController _textController = TextEditingController();

  late UserCubit _userCubit;

  String token = '';

  _ChatState({required this.receiverEmail});

  List<ChatData> messages = [];
  MessageList? allMessageData;

  String username = '';

  String currentUser = '';

  initMessageCall() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';
    currentUser = await StorageHandler.getUserEmail() ?? '';

    _userCubit.getMessage(bkey: token, receiver: receiverEmail);
  }

  @override
  void initState() {
    initMessageCall();
    super.initState();
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
              text: username,
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
        actions: [],
      ),
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is SendMessageLoaded) {
          if (state.messageSent.status == 1) {
          } else {}
        } else if (state is GetMessageLoaded) {
          if (state.messageList.status == 1) {
            username = state.messageList.receiver ?? '';
            messages = state.messageList.data ?? [];
            _textController.clear();
            FocusScope.of(context).unfocus();
          } else {}
        }
      }, builder: (context, state) {
        if (state is UserNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            context: context,
            onRefresh: () =>
                _userCubit.getMessage(bkey: token, receiver: receiverEmail),
          );
        } else if (state is UserNetworkErrApiErr) {
          return EmptyWidget(
            title: 'Network error',
            context: context,
            description: state.message,
            onRefresh: () =>
                _userCubit.getMessage(bkey: token, receiver: receiverEmail),
          );
        }

        return (state is SendMessageLoading || state is GetMessageLoading)
            ? Scaffold(body: const LoadingPage())
            : Stack(
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
                                alignment:
                                    (currentUser == messages[index].sender)
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration:   BoxDecoration(
                                      color:  (currentUser == messages[index].sender)
                                        ? AppColors.lightSecondary.withOpacity(0.3) :AppColors.lightPrimary,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(3),
                                      )),
                                  child: Text(
                                    messages[index].message ?? "",
                                    style: TextStyle(
                                      color: (currentUser == messages[index].sender)
                                        ? AppColors.lightPrimary  : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              subtitle: GestureDetector(
                                onTap: () {
                                  Modals.showToast(
                                      message.sender?[index].toString() ?? '');
                                },
                                child: Text(
                                  (currentUser == messages[index].sender)
                                      ? formattedTime
                                      : formattedTime,
                                  textAlign:
                                      (currentUser == messages[index].sender)
                                          ? TextAlign.right
                                          : TextAlign.left,
                                ),
                              ),
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
              );
      }),
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
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: TextEditView(
                borderWidth: 0.5,
                controller: _textController,
                hintText: 'Type something',
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
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    sendMessage();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendMessage() async {
    await _userCubit.sendMessage(
        bkey: token, receiver: receiverEmail, message: _textController.text);

    _userCubit.getMessage(bkey: token, receiver: receiverEmail);
  }
}

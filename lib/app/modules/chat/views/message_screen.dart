
import 'dart:ui';
import 'package:blume/app/data/models/chat_list_model.dart';
import 'package:blume/app/data/models/message_model.dart';
import 'package:blume/app/modules/chat/controller/chat_controller.dart';
import 'package:blume/app/modules/chat/widgets/media/media_preview_widget.dart';
import 'package:blume/app/modules/chat/widgets/receiver_card.dart';
import 'package:blume/app/modules/chat/widgets/sender_card.dart';
import 'package:blume/app/modules/chat/widgets/textfield/chat_input_field_widget.dart';
import 'package:blume/app/resources/colors.dart';
// import 'package:blume/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MessageScreen extends StatefulWidget {
  final ChatListModel chatHead;
  const MessageScreen({super.key, required this.chatHead});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final List giftList = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png",
    "assets/images/5.png",
    "assets/images/6.png",
    "assets/images/7.png",
    "assets/images/8.png",
  ];

  late final ChatController _chatController;

  @override
  void initState() {
    super.initState();
    _chatController = Get.put(ChatController(), tag: widget.chatHead.userId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatController.initialize(widget.chatHead);
    });
  }

  @override
  void dispose() {
    Get.delete<ChatController>(tag: widget.chatHead.userId);
    _chatController.closeScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [_buildMessageList(), _buildScrollDownButton()],
              ),
            ),
            Obx(() {
              if (_chatController.mediaController.showMediaPreview.value) {
                return MediaPreviewWidget(
                  controller: _chatController.mediaController,
                );
              }
              return const SizedBox();
            }),
            SizedBox(height: 5),
            NewChatInputFields(
              controller: _chatController,
              chatHead: widget.chatHead,
            ),
            // buildTextField(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollDownButton() {
    return Obx(() {
      final shouldShow =
          _chatController.showScrollToBottomButton.value &&
          _chatController.isVisible.value;

      return AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        bottom: shouldShow ? 20 : -100,
        right: 20,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          opacity: shouldShow ? 1.0 : 0.0,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            scale: shouldShow ? 1.0 : 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        HapticFeedback.selectionClick();
                        _chatController.scrollToBottom();
                      },
                      child: const Icon(
                        Icons.expand_more_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/frm.png"),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chatHead.fullName?.split(" ").first ?? "",
                    style: GoogleFonts.figtree(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  Text(
                    widget.chatHead.online == true ? "Active now" : "Offline",
                    style: GoogleFonts.figtree(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: widget.chatHead.online == true
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        // IconButton(
        //   onPressed: () => Get.toNamed(AppRoutes.videoCall),
        //   icon: Icon(Icons.video_call),
        // ),
        // IconButton(
        //   onPressed: () => Get.toNamed(AppRoutes.audioCall),
        //   icon: Icon(Icons.call),
        // ),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      ],
    );
  }

  Widget _buildMessageList() {
    return Obx(() {
      final messageController = _chatController.messageController;
      final savedChatToAvoidLoading = messageController.savedChatToAvoidLoading;
      List<MessageModel> oldChats =
          savedChatToAvoidLoading[widget.chatHead.userId] ?? [];
      final chatHistoryAndLiveMessage =
          messageController.chatHistoryAndLiveMessage;
      if (oldChats.isEmpty && messageController.isloading.value) {
        return const Center(
          child: CupertinoActivityIndicator(color: AppColors.primaryColor),
        );
        // return const ChatShimmerEffect(
        //   itemCount: 20,
        //   showSenderCards: true,
        //   showReceiverCards: true,
        //   // showImageCards: true,
        //   // showAudioCards: true,
        // );
      }

      if (oldChats.isNotEmpty && messageController.isloading.value) {
        return _buildMessageListView(oldChats);
      }

      if (chatHistoryAndLiveMessage.isEmpty && oldChats.isEmpty) {
        return Center(
          child: Text(
            "No Message",
            style: GoogleFonts.figtree(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        );
      }

      return _buildMessageListView(chatHistoryAndLiveMessage);
    });
  }

  Widget _buildMessageListView(List<MessageModel> messages) {
    return ScrollablePositionedList.builder(
      key: PageStorageKey<String>('chat_list_${widget.chatHead.userId}'),
      itemScrollController: _chatController.scrollController,
      itemPositionsListener: _chatController.itemPositionsListener,
      itemCount: messages.length,
      reverse: true,
      // cacheExtent: 1000,
      physics: const AlwaysScrollableScrollPhysics(),
      addRepaintBoundaries: true,
      addAutomaticKeepAlives: true,
      itemBuilder: (context, index) {
        final reversedIndex = messages.length - 1 - index;
        final message = messages[reversedIndex];
        final isSender =
            message.senderId == _chatController.userController.user.value!.id;
        final bubble = isSender
            ? RepaintBoundary(
                child: SenderCard(
                  messageModel: message,
                  chatHead: widget.chatHead,
                ),
              )
            : RepaintBoundary(
                child: ReceiverCard(
                  messageModel: message,
                  chatController: _chatController,
                  chatHead: widget.chatHead,
                ),
              );
        if (index == 0) {
          return TweenAnimationBuilder<Offset>(
            key: ValueKey(
              message.id ?? message.createdAt?.toIso8601String() ?? index,
            ),
            tween: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            builder: (context, offset, child) {
              return Transform.translate(
                offset: Offset(0, offset.dy * 50),
                child: child,
              );
            },
            child: bubble,
          );
        } else {
          return bubble;
        }
      },
    );
  }
}

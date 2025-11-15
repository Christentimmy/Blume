import 'package:blume/app/data/models/chat_list_model.dart';
import 'package:blume/app/modules/chat/controller/chat_controller.dart';
import 'package:blume/app/modules/chat/widgets/media/media_picker_bottom_sheet.dart';
import 'package:blume/app/modules/chat/widgets/shared/reply_to_content_widget.dart';
import 'package:blume/app/modules/chat/widgets/textfield/audio_input_widget.dart';
import 'package:blume/app/modules/chat/widgets/textfield/input_decoration.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NewChatInputFields extends StatelessWidget {
  final ChatController controller;
  final ChatListModel chatHead;

  NewChatInputFields({
    super.key,
    required this.controller,
    required this.chatHead,
  });

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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isRecording = controller.audioController.isRecording.value;
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isRecording
            ? AudioInputPreview(controller: controller)
            // : buildTextField(),
            : buildInputFieldRow(context),
      );
    });
  }

  Widget buildInputFieldRow(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(2.5),
                decoration: chatInputFieldDecoration(),
                child: Column(
                  children: [
                    ReplyToContent(
                      controller: controller,
                      chatHead: chatHead,
                      isSender: false,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 13),
                        Expanded(
                          child: TextField(
                            minLines: 1,
                            maxLines: 3,
                            onTap: () {
                              controller.showEmojiPicker.value = false;
                              FocusManager.instance.primaryFocus?.requestFocus();
                            },
                            cursorColor: AppColors.primaryColor,
                            controller: controller.textMessageController,
                            onChanged: controller.handleTyping,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: "Type a message...",
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.attach_file_rounded,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () => _showMediaPickerBottomSheet(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              final hasTextOrMedia =
                  controller.wordsTyped.value.isNotEmpty ||
                  controller.mediaController.selectedFile.value != null ||
                  controller.audioController.selectedFile.value != null ||
                  controller.mediaController.multipleMediaSelected.isNotEmpty;

              return Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primaryColor,
                  child: IconButton(
                    icon: Icon(
                      hasTextOrMedia ? Icons.send : Icons.mic,
                      color: Colors.white,
                      size: hasTextOrMedia ? 18 : null,
                    ),
                    onPressed: hasTextOrMedia
                        ? controller.sendMessage
                        : controller.audioController.startRecording,
                  ),
                ),
              );
            }),
          ],
        ),
        // SizedBox(height: 5),
        // Emoji picker
        // _buildEmojiPicker(),
      ],
    );
  }


  void _showMediaPickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (context) => MediaPickerBottomSheet(controller: controller),
    );
  }
}

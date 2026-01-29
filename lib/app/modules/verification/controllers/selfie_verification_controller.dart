import 'dart:async';
import 'dart:io';
import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/modules/verification/widgets/video_preview_widget.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';

class SelfieVerificationController extends GetxController {
  CameraController? cameraController;
  final RxBool isCameraInitialized = false.obs;
  final RxBool isRecording = false.obs;
  final RxInt recordingSeconds = 0.obs;
  final RxString videoPath = ''.obs;
  final RxBool isProcessing = false.obs;
  
  Timer? _recordingTimer;
  static const int maxRecordingSeconds = 5;

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await cameraController!.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      Get.snackbar(
        'Camera Error',
        'Failed to initialize camera: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> startRecording() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }

    if (isRecording.value) return;

    try {
      // final directory = await getTemporaryDirectory();
      // final path = '${directory.path}/selfie_verification_${DateTime.now().millisecondsSinceEpoch}.mp4';

      await cameraController!.startVideoRecording();
      isRecording.value = true;
      recordingSeconds.value = 0;

      // Start timer
      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        recordingSeconds.value++;
        if (recordingSeconds.value >= maxRecordingSeconds) {
          stopRecording();
        }
      });
    } catch (e) {
      Get.snackbar(
        'Recording Error',
        'Failed to start recording: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> stopRecording() async {
    if (!isRecording.value) return;

    try {
      _recordingTimer?.cancel();
      final video = await cameraController!.stopVideoRecording();
      isRecording.value = false;
      videoPath.value = video.path;
      print("Video path: ${videoPath.value}");
      
      // Show preview or process the video
      _showVideoPreview();
    } catch (e) {
      Get.snackbar(
        'Recording Error',
        'Failed to stop recording: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _showVideoPreview() {
    Get.dialog(
      VideoPreviewDialog(videoPath: videoPath.value, controller: this),
      barrierDismissible: false,
    );
  }

  Future<void> submitVideo() async {
    isProcessing.value = true;
    final userController = Get.find<UserController>();
    await userController.applyVerification(videoPath: File(videoPath.value));
    
    await Future.delayed(const Duration(seconds: 2)); // Simulate upload
    
    isProcessing.value = false;
    Get.back(); // Close preview dialog
    Get.back(result: videoPath.value); // Return to previous screen with result
  }

  void retakeVideo() {
    if (videoPath.value.isNotEmpty) {
      File(videoPath.value).deleteSync();
      videoPath.value = '';
    }
    recordingSeconds.value = 0;
    Get.back(); // Close preview dialog
  }

  @override
  void onClose() {
    _recordingTimer?.cancel();
    cameraController?.dispose();
    if (videoPath.value.isNotEmpty) {
      File(videoPath.value).deleteSync();
    }
    super.onClose();
  }
}
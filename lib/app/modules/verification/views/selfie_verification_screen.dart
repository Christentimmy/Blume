import 'package:blume/app/modules/verification/controllers/selfie_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:blume/app/resources/colors.dart';

class SelfieVerificationScreen extends StatelessWidget {
  const SelfieVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelfieVerificationController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context, isDark),

            // Instructions
            _buildInstructions(context, isDark),

            // Camera Preview
            Expanded(
              child: Obx(() {
                if (!controller.isCameraInitialized.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }
                return _buildCameraPreview(controller, isDark);
              }),
            ),

            // Recording Controls
            _buildControls(controller, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Selfie Verification',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkButtonColor : AppColors.lightButtonColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(Icons.info_outline, color: AppColors.primaryColor, size: 32),
          const SizedBox(height: 12),
          Text(
            'Record a 5-second video',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Position your face in the frame and press the record button. The video will automatically stop after 5 seconds.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCameraPreview(
    SelfieVerificationController controller,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white24 : Colors.black12,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Camera Preview
            // AspectRatio(
            //   aspectRatio: controller.cameraController!.value.aspectRatio,
            //   child: CameraPreview(controller.cameraController!),
            // ),
            CameraPreview(controller.cameraController!),

            // Face Outline Guide
            Obx(() {
              if (controller.isRecording.value) {
                return const SizedBox.shrink();
              }
              return CustomPaint(
                size: Size.infinite,
                painter: FaceOutlinePainter(
                  color: AppColors.primaryColor.withValues(alpha: 0.5),
                ),
              );
            }),

            // Recording Timer
            Obx(() {
              if (!controller.isRecording.value) {
                return const SizedBox.shrink();
              }
              return Positioned(
                top: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${controller.recordingSeconds.value}s / 5s',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildControls(SelfieVerificationController controller, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Obx(() {
        return GestureDetector(
          onTap: controller.isRecording.value
              ? null
              : () => controller.startRecording(),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.isRecording.value
                  ? AppColors.primaryColor
                  : Colors.transparent,
              border: Border.all(color: AppColors.primaryColor, width: 4),
            ),
            child: controller.isRecording.value
                ? const Icon(Icons.stop, color: Colors.white, size: 36)
                : const Icon(
                    Icons.fiber_manual_record,
                    color: AppColors.primaryColor,
                    size: 48,
                  ),
          ),
        );
      }),
    );
  }
}

// Face outline guide painter
class FaceOutlinePainter extends CustomPainter {
  final Color color;

  FaceOutlinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height / 2);
    final ovalRect = Rect.fromCenter(
      center: center,
      width: size.width * 0.6,
      height: size.height * 0.75,
    );

    canvas.drawOval(ovalRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

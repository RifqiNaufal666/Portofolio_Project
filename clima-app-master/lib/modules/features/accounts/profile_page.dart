import 'package:clima_app/configs/constant/app_radius.dart';
import 'package:clima_app/configs/themes/app_colors.dart';
import 'package:clima_app/modules/features/accounts/controllers/profile_controller.dart';
import 'package:clima_app/shared/extension/spacing_widget.dart';
import 'package:clima_app/shared/widgets/buttons/app_button.dart';
import 'package:clima_app/shared/widgets/fields/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends GetWidget<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profil',
          style: GoogleFonts.inter(
            fontSize: 16.0.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: controller.onLogout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      bottomSheet: Obx(() {
        if (controller.name.isNotEmpty ||
            controller.fileImage.value.path.isNotEmpty) {
          return Padding(
            padding: 12.0.allEdge,
            child: AppButton(
              label: 'Simpan',
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              onPressed: controller.updateProfile,
            ),
          );
        }

        return const SizedBox.shrink();
      }),
      body: Padding(
        padding: 16.0.horizontalEdge,
        child: Column(
          children: [
            24.0.verticalSpace,
            Stack(
              children: [
                GetBuilder<ProfileController>(builder: (controller) {
                  if (controller.fileImage.value.path.isNotEmpty) {
                    return ClipRRect(
                      borderRadius: AppRadius.r100,
                      child: Image.file(
                        controller.fileImage.value,
                        height: 190.h,
                        width: 190.h,
                        fit: BoxFit.cover,
                      ),
                    );
                  }

                  if (controller.user?.photoURL?.isNotEmpty ?? false) {
                    return ClipRRect(
                      borderRadius: AppRadius.r100,
                      child: Image.network(
                        controller.user!.photoURL!,
                        height: 190.h,
                        width: 190.h,
                        fit: BoxFit.cover,
                      ),
                    );
                  }

                  return CircleAvatar(
                    radius: 70,
                    child: Icon(
                      Icons.person_2,
                      size: 90.0.sp,
                    ),
                  );
                }),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: AppRadius.r100,
                      color: AppColors.primary,
                    ),
                    child: IconButton(
                      onPressed: controller.selectImage,
                      icon: const Icon(Icons.edit),
                      visualDensity: VisualDensity.comfortable,
                      iconSize: 24.0.sp,
                      color: AppColors.white,
                    ),
                  ),
                )
              ],
            ),
            12.0.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: Text(
                'Nama',
                style: GoogleFonts.inter(
                  fontSize: 12.0.sp,
                ),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.person_outline),
                6.0.horizontalSpace,
                Expanded(
                  child: AppTextField(
                    label: null,
                    suffix: Transform.translate(
                      offset: const Offset(0, 6),
                      child: const Icon(
                        Icons.edit_outlined,
                      ),
                    ),
                    hit: 'Masukan nama',
                    outline: false,
                    transparent: true,
                    controller: TextEditingController(
                      text: controller.user?.displayName,
                    ),
                    contentPadding: 8.horizontalEdge,
                    borderRadius: BorderRadius.zero,
                    onChanged: (p0) => controller.name.value = p0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

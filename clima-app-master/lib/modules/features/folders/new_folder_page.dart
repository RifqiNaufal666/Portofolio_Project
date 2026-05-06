import 'package:clima_app/configs/constant/app_radius.dart';
import 'package:clima_app/configs/themes/app_colors.dart';
import 'package:clima_app/modules/features/folders/controllers/new_folder_controller.dart';
import 'package:clima_app/shared/extension/spacing_widget.dart';
import 'package:clima_app/shared/widgets/buttons/app_button.dart';
import 'package:clima_app/shared/widgets/fields/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NewFolderPage extends GetWidget<NewFolderController> {
  const NewFolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: AppColors.bgBlue,
        backgroundColor: AppColors.bgBlue,
        shadowColor: AppColors.bgBlue,
        title: Text(
          controller.args.mode.isCreate
              ? 'Buat Folder Baru'
              : 'Edit ${controller.args.data?.name}',
          style: GoogleFonts.inter(
            fontSize: 16.0.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 1.0.h,
            thickness: 1.0.h,
            color: AppColors.primary,
          ),
          8.0.verticalSpace,
          Padding(
            padding: 8.0.horizontalEdge,
            child: Text(
              'Nama Folder :',
              style: GoogleFonts.inter(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          AppTextField(
            label: null,
            outline: false,
            transparent: true,
            hit: 'Masukan folder file',
            contentPadding: 8.0.allEdge,
            borderRadius: BorderRadius.zero,
            onChanged: (p0) => controller.name.value = p0,
            controller: TextEditingController(
              text: controller.args.data?.name ?? '',
            ),
          ),
          24.0.verticalSpace,
          Padding(
            padding: 8.0.horizontalEdge,
            child: Obx(() {
              return AppButton(
                label: 'Simpan',
                enable: controller.name.isNotEmpty,
                borderRadius: AppRadius.r20,
                backgroundColor: AppColors.secondary,
                foregroundColor: AppColors.white,
                onPressed: controller.args.mode.isCreate
                    ? controller.createFolder
                    : controller.editFolder,
              );
            }),
          )
        ],
      ),
    );
  }
}

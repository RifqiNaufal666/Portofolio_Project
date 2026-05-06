import 'package:clima_app/configs/constant/app_radius.dart';
import 'package:clima_app/configs/constant/asset_const.dart';
import 'package:clima_app/configs/pages/app_routes.dart';
import 'package:clima_app/configs/themes/app_colors.dart';
import 'package:clima_app/modules/features/dashboard/models/folders_res/folders_res.dart';
import 'package:clima_app/modules/features/folders/args/args_create.dart';
import 'package:clima_app/modules/features/folders/controllers/folders_controller.dart';
import 'package:clima_app/shared/extension/spacing_widget.dart';
import 'package:clima_app/shared/widgets/fields/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FoldersPage extends GetWidget<FoldersController> {
  const FoldersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            20.0.verticalSpace,
            Padding(
              padding: 40.0.horizontalEdge,
              child: AppTextField(
                label: null,
                hit: 'Search...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primary,
                ),
                contentPadding: 8.allEdge,
              ),
            ),
            10.0.verticalSpace,
            const Expanded(child: GirdFolderWidget()),
          ],
        ),
      ),
    );
  }
}

class GirdFolderWidget extends GetWidget<FoldersController> {
  const GirdFolderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getFolders();
      },
      child: Obx(() {
        return GridView.builder(
          padding: 14.allEdge,
          itemCount: controller.dataFolders.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 16.0.h,
            crossAxisSpacing: 16.0.h,
          ),
          itemBuilder: (BuildContext context, int index) {
            return ItemFolderWidget(
              key: Key('${controller.dataFolders[index].hashCode}'),
              data: controller.dataFolders[index],
            );
          },
        );
      }),
    );
  }
}

class ItemFolderWidget extends GetWidget<FoldersController> {
  final DataFolder data;
  const ItemFolderWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool deleteMode = controller.dashController.deleteMode.value;
      bool editMode = controller.dashController.editMode.value;

      // ignore: invalid_use_of_protected_member
      List<DataFolder> deleteFolders = controller.deleteFolders.value;

      return TextButton(
        onPressed: () async {
          if (deleteMode) {
            controller.onSelectDeleteItem(data);
            return;
          }

          if (editMode) {
            controller.dashController.editMode.value = false;
            controller.dashController.moreEnable.value = false;
            controller.dashController.folderSelected.value = data;

            await Get.toNamed(
              AppRoutes.newFolder,
              arguments: ArgsCreateFolder.edit(data: data),
            );

            controller.getFolders();
            return;
          }

          controller.onSelectItemMenu(2, data);
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: deleteMode || editMode
                ? deleteFolders.contains(data)
                    ? const BorderSide(width: 1, color: AppColors.secondary)
                    : const BorderSide(width: 0.5, color: AppColors.primary2)
                : BorderSide.none,
            borderRadius: AppRadius.r10,
          ),
          backgroundColor: deleteMode || editMode
              ? deleteFolders.contains(data)
                  ? AppColors.primary
                  : null
              : null,
          foregroundColor: deleteMode || editMode
              ? deleteFolders.contains(data)
                  ? AppColors.white
                  : null
              : null,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              ImgAssets.icFolder,
              height: 55.0.h,
              width: 55.0.h,
            ),
            6.0.verticalSpace,
            Text(
              data.name ?? '-',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 12.0.sp,
              ),
            ),
          ],
        ),
      );
    });
  }
}

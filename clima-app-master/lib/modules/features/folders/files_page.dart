import 'package:clima_app/configs/pages/app_routes.dart';
import 'package:clima_app/configs/themes/app_colors.dart';
import 'package:clima_app/modules/features/dashboard/models/files_res/files_res.dart';
import 'package:clima_app/modules/features/dashboard/models/folders_res/folders_res.dart';
import 'package:clima_app/modules/features/folders/args/args_create.dart';
import 'package:clima_app/modules/features/folders/controllers/files_controller.dart';
import 'package:clima_app/modules/features/folders/pdf_viewer.dart';
import 'package:clima_app/shared/extension/spacing_widget.dart';
import 'package:clima_app/shared/helpers/dialog_helpers.dart';
import 'package:clima_app/shared/widgets/fields/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FilesPage extends GetWidget<FilesController> {
  final DataFolder data;

  const FilesPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (controller.searchEnable.value) {
          controller.searchEnable.value = false;
          return;
        }

        controller.onSelectItemMenu(0);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          surfaceTintColor: AppColors.bgBlue,
          backgroundColor: AppColors.bgBlue,
          shadowColor: AppColors.bgBlue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              if (controller.searchEnable.value) {
                controller.searchEnable.value = false;
                return;
              }

              controller.onSelectItemMenu(0);
            },
          ),
          actions: [
            46.0.horizontalSpace,
            Flexible(
              child: Obx(() {
                if (controller.searchEnable.value) {
                  return Padding(
                    padding: 8.allEdge,
                    child: AppTextField(
                      label: null,
                      hit: 'Search...',
                      prefixIcon: const Icon(Icons.search_rounded),
                      contentPadding: 12.0.horizontalEdge,
                    ),
                  );
                }

                return IconButton(
                  icon: const Icon(Icons.search_outlined),
                  onPressed: () {
                    controller.searchEnable.value = true;
                  },
                );
              }),
            ),
          ],
          title: Text(
            data.name ?? '-',
            style: GoogleFonts.inter(
              fontSize: 16.0.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            Divider(
              thickness: 1.0.h,
              height: 1.0.h,
              color: AppColors.primary2,
            ),
            const Expanded(child: ListItemFileWidget()),
          ],
        ),
      ),
    );
  }
}

class ListItemFileWidget extends GetWidget<FilesController> {
  const ListItemFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getFiles();
      },
      child: Obx(() {
        return ListView.separated(
          itemCount: controller.dataFiles.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ItemFileWidget(
                  data: controller.dataFiles[index],
                ),
                if (controller.dataFiles[index] == controller.dataFiles.last)
                  Divider(
                    thickness: 1.0.h,
                    height: 1.0.h,
                    color: AppColors.primary2,
                  ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Divider(
                  thickness: 1.0.h,
                  height: 1.0.h,
                  color: AppColors.primary2,
                ),
                3.verticalSpace,
                Divider(
                  thickness: 1.0.h,
                  height: 1.0.h,
                  color: AppColors.primary2,
                ),
              ],
            );
          },
        );
      }),
    );
  }
}

class ItemFileWidget extends GetWidget<FilesController> {
  final DataFile data;

  const ItemFileWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('dd, MMM yyyy');

    return TextButton(
      onPressed: () async {
        if (controller.dashController.deleteMode.value) {
          controller.onSelectDeleteItem(data);
          return;
        }

        if (controller.dashController.editMode.value) {
          controller.dashController.editMode.value = false;
          controller.dashController.moreEnable.value = false;

          await Get.toNamed(
            AppRoutes.newFile,
            arguments: ArgsCreateFile.edit(data: data),
          );

          controller.getFiles();
          return;
        }

        if (data.linkUrl?.isEmpty ?? true) {
          DialogHelpers.problem(
            title: 'Url Kosong',
            desc: 'Link url kosong',
          );

          return;
        }

        try {
          // if (data.linkUrl!.contains('.pdf')) {
          //   Get.to(() => PdfViewer(url: data.linkUrl!));
          //   return;
          // }

          if (await canLaunchUrl(Uri.parse(data.linkUrl!))) {
            launchUrl(
              Uri.parse(data.linkUrl!),
              mode: LaunchMode.inAppBrowserView,
            );
          }
        } catch (e) {
          DialogHelpers.problem(title: 'Error', desc: e.toString());
        }
      },
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        backgroundColor: AppColors.itemBg,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        data.name ?? '-',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            fontSize: 12.0.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    8.0.horizontalSpace,
                    Flexible(
                      child: Text(
                        ':',
                        style: GoogleFonts.inter(
                            fontSize: 12.0.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    8.0.horizontalSpace,
                    Expanded(
                      flex: 6,
                      child: Text(
                        data.linkUrl ?? '-',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            fontSize: 12.0.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Text(
                  data.dateTime != null
                      ? format.format(data.dateTime!)
                      : '-, -- ----',
                  style: GoogleFonts.inter(
                      fontSize: 9.0.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.dashController.deleteMode.value) {
                return Checkbox(
                  key: Key(controller.deleteFiles.contains(data).toString()),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  activeColor: AppColors.secondary,
                  value: controller.deleteFiles.contains(data),
                  onChanged: (v) {},
                );
              }

              if (controller.dashController.editMode.value) {
                return const Icon(Icons.edit);
              }

              return const Icon(Icons.arrow_forward_ios_rounded);
            }),
          ),
        ],
      ),
    );
  }
}

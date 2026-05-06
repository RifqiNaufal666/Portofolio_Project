import 'package:clima_app/configs/constant/app_radius.dart';
import 'package:clima_app/configs/constant/asset_const.dart';
import 'package:clima_app/configs/pages/app_routes.dart';
import 'package:clima_app/configs/themes/app_colors.dart';
import 'package:clima_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:clima_app/modules/features/folders/args/args_create.dart';
import 'package:clima_app/modules/features/folders/controllers/files_controller.dart';
import 'package:clima_app/modules/features/folders/controllers/folders_controller.dart';
import 'package:clima_app/modules/features/folders/files_page.dart';
import 'package:clima_app/modules/features/folders/folders_page.dart';
import 'package:clima_app/modules/features/faq/faq_page.dart';
import 'package:clima_app/shared/extension/spacing_widget.dart';
import 'package:clima_app/shared/widgets/buttons/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends GetWidget<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const FoldersPage(),
      const FaqPage(),
      Obx(() {
        return FilesPage(data: controller.folderSelected.value);
      })
    ];

    return Scaffold(
      drawer: AnimatedContainer(
        width: 155.0.w,
        duration: const Duration(milliseconds: 500),
        child: Drawer(
          backgroundColor: AppColors.bgBlue,
          child: Column(
            children: [
              context.mediaQuery.padding.top.verticalSpace,
              12.0.verticalSpace,
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(AppRoutes.optionMenu);
                },
                child: Image.asset(
                  LogoAssets.logo,
                  height: 42.0.w,
                  width: 42.0.w,
                ),
              ),
              14.0.verticalSpace,
              const Divider(height: 1.0),
              14.0.verticalSpace,
              GestureDetector(
                onTap: () async {
                  await Get.toNamed(AppRoutes.profile);

                  controller.update();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GetBuilder<DashboardController>(builder: (controller) {
                      if (controller.currentUser?.photoURL?.isNotEmpty ??
                          false) {
                        return ClipRRect(
                          borderRadius: AppRadius.r100,
                          child: Image.network(
                            controller.currentUser!.photoURL!,
                            height: 60.0.h,
                            width: 60.0.h,
                            fit: BoxFit.cover,
                          ),
                        );
                      }

                      return Icon(
                        Icons.person,
                        size: 40.0.sp,
                      );
                    }),
                    3.0.verticalSpace,
                    Text(
                      'Hi, ${(controller.currentUser?.displayName?.isNotEmpty ?? false) ? controller.currentUser?.displayName : (controller.currentUser?.email ?? '-')}',
                      style: GoogleFonts.inter(
                        fontSize: 11.0.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              71.0.verticalSpace,
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SideBarItem(
                      index: 0,
                      indexActive: [0, 2],
                      iconData: Icons.paste_rounded,
                      label: 'Data List',
                    ),
                    16.0.verticalSpace,
                    const SideBarItem(
                      index: 1,
                      indexActive: [1],
                      iconData: Icons.info_outline_rounded,
                      label: 'FAQ',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 61.0.w,
            child: Drawer(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              backgroundColor: AppColors.bgBlue,
              child: Column(
                children: [
                  context.mediaQuery.padding.top.verticalSpace,
                  12.0.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(AppRoutes.optionMenu);
                    },
                    child: Image.asset(
                      LogoAssets.logo,
                      height: 38.0.w,
                      width: 38.0.w,
                    ),
                  ),
                  14.0.verticalSpace,
                  Builder(builder: (context) {
                    return AppTextButton(
                      center: true,
                      label: null,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.zero,
                      textColor: AppColors.black,
                      bgColor: AppColors.bgBlue,
                      prefixIcon: Icon(
                        Icons.menu,
                        size: 30.0.sp,
                        color: AppColors.black,
                      ),
                      textStyle: GoogleFonts.inter(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }),
                  71.0.verticalSpace,
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SideBarItem(
                          index: 0,
                          indexActive: [0, 2],
                          center: true,
                          iconData: Icons.paste_rounded,
                          padding: EdgeInsets.zero,
                        ),
                        16.0.verticalSpace,
                        const SideBarItem(
                          index: 1,
                          indexActive: [1],
                          center: true,
                          iconData: Icons.info_outline_rounded,
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            thickness: 1.0.h,
            width: 1.0.h,
            color: AppColors.primary2,
          ),
          Flexible(
            child: Obx(() {
              return AnimatedSwitcher(
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                duration: const Duration(milliseconds: 200),
                child: pages[controller.selectedIndex.value],
              );
            }),
          ),
        ],
      ),
      floatingActionButton: Obx(() {
        bool deleteMode = controller.deleteMode.value;
        bool moreEnable = controller.moreEnable.value;

        return Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (moreEnable && !deleteMode) ...[
              IconButton(
                onPressed: () {
                  controller.editMode.value = false;
                  controller.deleteMode.value = !controller.deleteMode.value;
                },
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                ),
                icon: const Icon(
                  Icons.delete_outline,
                  color: AppColors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.deleteMode.value = false;
                  controller.editMode.value = !controller.editMode.value;
                },
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                ),
                icon: Obx(() {
                  return Icon(
                    controller.editMode.value ? Icons.close : Icons.edit_square,
                    size: 20.0.sp,
                    color: AppColors.white,
                  );
                }),
              ),
              IconButton(
                onPressed: () async {
                  controller.moreEnable.value = false;

                  if (controller.selectedIndex.value == 0) {
                    await Get.toNamed(
                      AppRoutes.newFolder,
                      arguments: ArgsCreateFolder.create(),
                    );

                    if (Get.isRegistered<FoldersController>()) {
                      FoldersController.i.getFolders();
                    }

                    return;
                  }

                  await Get.toNamed(
                    AppRoutes.newFile,
                    arguments: ArgsCreateFile.create(),
                  );

                  if (Get.isRegistered<FilesController>()) {
                    FilesController.i.getFiles();
                  }
                },
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                ),
                icon: const Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
              8.0.verticalSpace,
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (deleteMode) ...[
                  Obx(() {
                    if (controller.selectedIndex.value == 0 &&
                        Get.isRegistered<FoldersController>() &&
                        FoldersController.i.deleteFolders.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    if (controller.selectedIndex.value == 2 &&
                        Get.isRegistered<FilesController>() &&
                        FilesController.i.deleteFiles.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return IconButton(
                      onPressed: () async {
                        controller.deleteMode.value = false;
                        controller.selectAll.value = false;
                        controller.moreEnable.value = false;

                        if (controller.selectedIndex.value == 0 &&
                            Get.isRegistered<FoldersController>()) {
                          await FoldersController.i.onDeleteFolders();
                          FoldersController.i.deleteFolders.value = [];
                          FoldersController.i.getFolders();
                        }

                        if (controller.selectedIndex.value == 2 &&
                            Get.isRegistered<FilesController>()) {
                          await FilesController.i.onDeleteFiles();
                          FilesController.i.deleteFiles.value = [];
                          FilesController.i.getFiles();
                        }
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.red,
                      ),
                      tooltip: 'Hapus',
                      icon: Icon(
                        Icons.delete_forever_rounded,
                        size: 20.0.sp,
                        color: AppColors.white,
                      ),
                    );
                  }),
                  Obx(() {
                    return IconButton(
                      onPressed: () {
                        controller.selectAll.value =
                            !controller.selectAll.value;

                        if (controller.selectedIndex.value == 0 &&
                            Get.isRegistered<FoldersController>()) {
                          FoldersController.i.onSelectDeleteAll();
                        }

                        if (controller.selectedIndex.value == 2 &&
                            Get.isRegistered<FilesController>()) {
                          FilesController.i.onSelectDeleteAll();
                        }
                      },
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.r100,
                          side: const BorderSide(
                            color: AppColors.secondary,
                          ),
                        ),
                        backgroundColor: controller.selectAll.value
                            ? AppColors.secondary
                            : AppColors.white,
                      ),
                      tooltip: 'Pilih Semua',
                      icon: Icon(
                        Icons.select_all,
                        size: 20.0.sp,
                        color: controller.selectAll.value
                            ? AppColors.white
                            : AppColors.secondary,
                      ),
                    );
                  }),
                ],
                Obx(() {
                  if (controller.selectedIndex.value == 1) {
                    return const SizedBox.shrink();
                  }

                  return FloatingActionButton(
                    shape: RoundedRectangleBorder(borderRadius: AppRadius.r100),
                    backgroundColor: AppColors.secondary2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Builder(builder: (_) {
                        if (moreEnable) {
                          return Icon(
                            Icons.close,
                            size: 30.0.sp,
                          );
                        }

                        return Icon(
                          Icons.more_vert,
                          size: 30.0.sp,
                        );
                      }),
                    ),
                    onPressed: () {
                      if (moreEnable && deleteMode) {
                        controller.deleteMode.value = false;
                        return;
                      }

                      controller.moreEnable.value =
                          !controller.moreEnable.value;
                    },
                  );
                }),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class SideBarItem extends GetWidget<DashboardController> {
  final int index;
  final List<int> indexActive;
  final String? label;
  final IconData iconData;
  final bool center;
  final EdgeInsets? padding;

  const SideBarItem({
    super.key,
    required this.index,
    required this.indexActive,
    required this.iconData,
    this.label,
    this.padding,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppTextButton(
        label: label,
        center: center,
        padding: padding ?? 22.horizontalEdge,
        borderRadius: BorderRadius.zero,
        textColor: AppColors.black,
        onPressed: () {
          controller.onSelectItemMenu(index);
        },
        bgColor: indexActive.contains(controller.selectedIndex.value)
            ? AppColors.secondary2
            : AppColors.bgBlue,
        suffixIcon: Icon(
          iconData,
          color: AppColors.secondary,
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14.0.sp,
          fontWeight: FontWeight.w600,
        ),
      );
    });
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SpacingWidget on num {}

extension PaddingExtension on num {
  EdgeInsets get allEdge => EdgeInsets.all(toDouble()).r;
  EdgeInsets get horizontalEdge => EdgeInsets.symmetric(
        horizontal: toDouble(),
      ).r;
  EdgeInsets get verticalEdge => EdgeInsets.symmetric(
        vertical: toDouble(),
      ).r;
  EdgeInsets get verticalLEdge => EdgeInsets.only(
        left: toDouble(),
      ).r;
  EdgeInsets get verticalREdge => EdgeInsets.only(
        right: toDouble(),
      ).r;
}

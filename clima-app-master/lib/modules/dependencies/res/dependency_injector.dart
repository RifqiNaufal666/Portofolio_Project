import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

S sh<S>({String? tag}) => Get.find<S>(tag: tag);

A args<A>() => Get.arguments as A;

abstract class DependencyInjector extends Bindings {
  @protected
  @override
  void dependencies() {
    repositories();
    controller();
  }

  @protected
  void controller();
  @protected
  void repositories();
}

import 'package:flutter/material.dart';
import 'package:hrmodules/HRM_module/dashBoard_View.dart';

class HRM_Module extends StatefulWidget {
  const HRM_Module({super.key});

  @override
  State<HRM_Module> createState() => _HRM_ModuleState();
}

class _HRM_ModuleState extends State<HRM_Module> {
  @override
  Widget build(BuildContext context) {
    return DashBoard_View();
  }
}

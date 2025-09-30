import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 200,
      title: Text("Clean Architecture", style: TextStyle(fontSize: 32)),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      centerTitle: true,
      backgroundColor: Colors.deepPurpleAccent.shade100,
    );
  }

  Size get preferredSize => const Size.fromHeight(200);
}

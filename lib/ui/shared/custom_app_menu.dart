import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vertical_landing_page/providers/page_provider.dart';
import 'package:vertical_landing_page/ui/shared/custom_menu_item.dart';

class CustomAppMenu extends StatefulWidget {
  CustomAppMenu({Key? key}) : super(key: key);

  @override
  _CustomAppMenuState createState() => _CustomAppMenuState();
}

class _CustomAppMenuState extends State<CustomAppMenu>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context, listen: false);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: 150,
          height: isOpen ? 308 : 50,
          color: Colors.black,
          child: Column(
            children: [
              _MenuTile(isOpen: isOpen, controller: controller),
              if (isOpen) ...[
                CustomMenuItem(
                    text: 'Home',
                    delay: 40,
                    onPressed: () => pageProvider.goTo(0)),
                CustomMenuItem(
                    text: 'About',
                    delay: 60,
                    onPressed: () => pageProvider.goTo(1)),
                CustomMenuItem(
                    text: 'Pricing',
                    delay: 80,
                    onPressed: () => pageProvider.goTo(2)),
                CustomMenuItem(
                    text: 'Contact',
                    delay: 100,
                    onPressed: () => pageProvider.goTo(3)),
                CustomMenuItem(
                    text: 'Location',
                    delay: 120,
                    onPressed: () => pageProvider.goTo(4)),
                SizedBox(
                  height: 8,
                )
              ]
            ],
          ),
        ),
        onTap: () {
          setState(() {
            if (isOpen) {
              controller.reverse();
            } else {
              controller.forward();
            }
            isOpen = !isOpen;
          });
        },
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    Key? key,
    required this.isOpen,
    required this.controller,
  }) : super(key: key);

  final bool isOpen;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      child: Row(
        children: [
          AnimatedContainer(
            width: isOpen ? 40 : 0,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          ),
          Text(
            'Menu',
            style: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
          ),
          Spacer(),
          AnimatedIcon(
            color: Colors.white,
            icon: AnimatedIcons.menu_close,
            progress: controller,
          ),
        ],
      ),
    );
  }
}

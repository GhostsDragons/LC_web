import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'collapsible_sidebar.dart';
import 'package:lc_web/Pages/profile.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  late List<CollapsibleItem> _items;
  final AssetImage _avatarImg = const AssetImage('assets/LC_circle_avatar.png');
  // late String _headline;

  @override
  void initState() {
    super.initState();
    _items = _homeItems;
    // _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _homeItems {
    return [
      CollapsibleItem(
      text: 'Home',
      icon: Icons.home_outlined,
      onPressed: (){},
      isSelected: true,
    ),
    CollapsibleItem(
      text: 'Calendar',
      icon: Icons.calendar_month_outlined,
      onPressed: (){},
    ),
    CollapsibleItem(
      text: 'Chat',
      icon: Icons.textsms_outlined,
      onPressed: (){},
    ),
    CollapsibleItem(
      text: 'Course Catalog',
      icon: Icons.bookmark_border_outlined,
      onPressed: (){},
    ),
    CollapsibleItem(
      text: '1:1 Mentorship Program',
      icon: CupertinoIcons.graph_square,
      onPressed: (){},
    ),
    CollapsibleItem(
      text: 'Concept Clarity',
      icon: Icons.lightbulb_circle_outlined,
      onPressed: () {},
    ),
     CollapsibleItem(
      text: 'Copywriting 101',
      icon: Icons.edit,
      onPressed: (){},
    ),
    CollapsibleItem(
      text: 'Profile',
      icon: Icons.account_circle_outlined,
      onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Profile()));
      },
    ),
    CollapsibleItem(
      text: 'Settings',
      icon: Icons.lightbulb_circle_outlined,
      onPressed: () {},
    ),
     CollapsibleItem(
      text: 'Logout',
      icon: Icons.edit,
      onPressed: (){},
     ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CollapsibleSidebar(
        collapseOnBodyTap: true,
        showToggleButton: false,
        avatarImg: _avatarImg,

        isCollapsed: MediaQuery.of(context).size.width <= 800,
        items: _items,
        title: "Learners' Club",
        onTitleTap: () {
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //     content: Text('Yay! Flutter Collapsible Sidebar!')));
        },
        body: _body(size, context),

        unselectedTextColor: Colors.white,
        unselectedIconColor: Colors.white,

        // backgroundColor: const Color.fromARGB(255, 44, 129, 47),
        selectedTextColor: const Color.fromARGB(255, 65, 68, 255),

        textStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text(
          'Hi there',
          style: Theme.of(context).textTheme.headlineMedium,
          overflow: TextOverflow.visible,
          softWrap: false,
        ),
      ),
    );
  }
}

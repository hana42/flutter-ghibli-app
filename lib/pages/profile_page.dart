import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late List tabs;
  int _currentIndex = 0;

  // late String? photoUrl = auth.currentUser?.photoURL;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User user;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    user = _auth.currentUser!;

    tabs = ['My List', 'Downloads', 'Settings'];
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_handleTabControllerTick);
  }

  void _handleTabControllerTick() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  _tabsContent() {
    switch (_currentIndex) {
      case 0:
        return Text('User List');
      case 1:
        return Text('Downloads');
      case 2:
        return Column(
          children: [
            if (!user.emailVerified) const Text('Verify your email'),
            Text('Settings'),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.7),
                            BlendMode.hardLight,
                          ),
                          image: AssetImage('assets/logo/header.jpg'))),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 122,
                    height: 122,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: UserAvatar(
                        auth: _auth,
                        placeholderColor: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 12, 40, 0),
                    child: Align(
                        alignment: Alignment.center,
                        child: EditableUserDisplayName(auth: _auth)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 300,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Colors.blueGrey,
                  controller: _tabController,
                  tabs: tabs.map((e) => Tab(text: e)).toList(),
                ),
                _tabsContent(),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    Size(MediaQuery.of(context).size.width / 1.3, 40),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 24, 24, 24),
                  ),
                ),
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                label: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await _auth.signOut().then((_) => Navigator.popUntil(
                      context, (route) => route.isFirst));
                },
              ),
              TextButton.icon(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    Size(MediaQuery.of(context).size.width / 1.3, 40),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 24, 24, 24)),
                ),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  await _auth.currentUser!.delete().whenComplete(() =>
                      Navigator.popUntil(
                          context, (route) => route.isFirst));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

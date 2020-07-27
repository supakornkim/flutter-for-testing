import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_stock/screens/bottomnav/account/account_screen.dart';
import 'package:flutter_stock/screens/bottomnav/home/home_screen.dart';
import 'package:flutter_stock/screens/bottomnav/notification/notification_screen.dart';
import 'package:flutter_stock/screens/bottomnav/setting/setting_screen.dart';
import 'package:flutter_stock/screens/bottomnav/stock/stock_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  SharedPreferences sharedPreference;

  int _currentIndex = 0;
  String _title;
  String nameAccount, emailAccount;

  final List<Widget> _children = [
    HomeScreen(),
    StockScreen(),
    NotificationScreen(),
    SettingScreen(),
    AccountScreen()
  ];

  @override
  void initState() {
    super.initState();
    _title = 'หน้าหลัก';

    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreference = await SharedPreferences.getInstance();


    if (sharedPreference.getString("storeEmail") == null){
      print(sharedPreference.getString("storeEmail"));
      Navigator.pushNamed(context, '/login');
    }

    setState((){
      nameAccount = sharedPreference.getString("storename");
      emailAccount = sharedPreference.getString("storeEmail");
    });

    //print(sharedPreference.getString("storeEmail"));
  }

  // สร้าง method สำหรับการเปลี่ยนหน้า
  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;

      switch (index) {
        case 0: _title = 'หน้าหลัก';
        break;
        case 1: _title = 'สต๊อกสินค้า';
        break;
        case 2: _title = 'แจ้งเตือน';
        break;
        case 3: _title = 'ตั้งค่า';
        break;
        case 4: _title = 'ฉัน';
        break;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: GoogleFonts.kanit()),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              //เคลียรค่าใน sharepreference
              sharedPreference.clear();
              Navigator.pushNamed(context, '/login');
            },
            child: Text("ออกจากระบบ", style: TextStyle(color:Colors.white),)
          )
        ],
      ),
      // ส่วนของ DrawerMenu
      drawer: SafeArea(
          child: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  currentAccountPicture: GestureDetector(
                    onTap: () { },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('https://image.freepik.com/free-vector/profile-icon-male-avatar-hipster-man-wear-headphones_48369-8728.jpg'),
                    ),
                  ),
                  otherAccountsPictures: <Widget>[
                    GestureDetector(
                      onTap: () { },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('https://images.megapixl.com/4707/47075236.jpg'),
                      ),
                    )
                  ],
                  accountName: Text('$nameAccount'),
                  accountEmail: Text('$emailAccount'),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('https://www.vickyalvearshecter.com/wp-content/uploads/2015/02/2012-06-08_0000066-as-Smart-Object-1-600x400.jpg'),
                          fit: BoxFit.fill
                      )
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('เกี่ยวกับเรา'),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text('ข้อมูลการใช้งาน'),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/term');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.mail),
                  title: Text('ติดต่อทีมงาน'),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/contact');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('ออกจากระบบ'),
                  onTap: (){

                  },
                ),
                Divider(color: Colors.green[200],),
                ListTile(
                  leading: Icon(Icons.cancel),
                  title: Text('ปิดเมนู'),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          )
      ),
      body: _children[_currentIndex],

      // ส่วนของ Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('หน้าหลัก')),
            BottomNavigationBarItem(icon: Icon(Icons.storage), title: Text('สต็อก')),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), title: Text('แจ้งเตือน')),
            BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('ตั้งค่า')),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('ฉัน')),
          ]
      ),




    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:your_bank/components/bar_chart.dart';
import 'package:your_bank/screens/expenditure_screen.dart';
import 'package:your_bank/screens/profile.dart';
import 'package:your_bank/screens/search_stuff.dart';
import 'package:your_bank/utilities/constants.dart';

class Dashboard extends StatefulWidget {
  static const String screenId = 'dashboard_screen';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  final TextStyle whiteText = GoogleFonts.raleway(color: Colors.white);
  /*
   * @author: Lionel Lobo 
   *  To animate the below widgets we need to get the
   *  Position and size for use in various animations
   *  however here we will use positions as we want to
   *  add curve ins and what not
   * 
   */
  bool animateGraph = false;
  GlobalKey _textQuickBoard = GlobalKey();
//   GlobalKey _TextQuickBoard = GlobalKey();
// GlobalKey _TextQuickBoard = GlobalKey();
// GlobalKey _TextQuickBoard = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      _buildBody(context),
      SearchStuff(),
      ExpenditureScreen(),
      CustomerProfile(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: GoogleFonts.pacifico(fontSize: 32.0),
        ),
      ),
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Container _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: SecondaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Text(
                    "Mr John Doe",
                    style: whiteText.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Text(
                    "Next Statement Date: 20 Aug 2020",
                    style: whiteText.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Text(
                    "Current Balance: 100,000",
                    style: whiteText.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 10.0, 10.0, 10.0),
            child: CircleAvatar(
              minRadius: 25.0,
              maxRadius: 50.0,
              backgroundImage: AssetImage(avatar),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Quick Board",
              key: _textQuickBoard,
              style: GoogleFonts.raleway(
                textStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
          ),
          BarChartExample(),
          Card(
            elevation: 4.0,
            color: GrayColor,
            margin: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Container(
                      alignment: Alignment.bottomCenter,
                      width: 45.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 20,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 25,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 50,
                            width: 8.0,
                            color: SecondaryColor,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 30,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                    title: Text("Current Statement",
                        style: GoogleFonts.raleway(
                            fontSize: 14.0, fontWeight: FontWeight.w800)),
                    subtitle: Text(
                      "AED 1800",
                      style: GoogleFonts.raleway(
                          fontSize: 14.0,
                          color: SecondaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      //TODO: download pdf?
                    },
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: ListTile(
                    leading: Container(
                      alignment: Alignment.bottomCenter,
                      width: 45.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 20,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 25,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(width: 4.0),
                          AnimatedContainer(
                            duration: Duration(seconds: 2),
                            height: animateGraph ? 20.0 : 50.0,
                            width: 8.0,
                            color: animateGraph ? Colors.green : Colors.red,
                            curve: Curves.easeIn,
                            child: Container(
                              height: 50.0,
                              width: 8.0,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          Container(
                            height: 30,
                            width: 8.0,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      "Outstanding",
                      style: GoogleFonts.raleway(
                          fontSize: 14.0, fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      "AED 10.0",
                      style: GoogleFonts.raleway(
                          fontSize: 14.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      setState(() {
                        animateGraph = !animateGraph;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: _buildTile(
                    color: Colors.deepOrange,
                    icon: Icons.shopping_basket,
                    title: "New Offers",
                    data: "Gucci",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.green,
                    icon: Icons.monetization_on,
                    title: "Quick EMI",
                    data: "857",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _buildTile(
                    color: Colors.blue,
                    icon: Icons.favorite,
                    title: "Send Money",
                    data: "Beneficiaries",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.pink,
                    icon: Icons.chat,
                    title: "Live Chat",
                    data: "Hello",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.blue,
                    icon: Icons.history,
                    title: "Transactions",
                    data: "Apple AED 2000",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.grey.shade800,
      unselectedItemColor: Colors.grey,
      currentIndex: _currentIndex,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text("Search"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          title: Text("Your Expenditure"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          title: Text("My Profile"),
        ),
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Container _buildTile(
      {Color color, IconData icon, String title, String data}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            title,
            style: whiteText.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            data,
            style:
                whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}

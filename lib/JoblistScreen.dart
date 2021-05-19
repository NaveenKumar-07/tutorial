import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tutorial/CompanyCircle.dart';
import 'package:tutorial/CustomDrawer.dart';
import 'package:tutorial/DetailScreen.dart';
import 'package:tutorial/Job.dart';
import 'package:tutorial/account.dart';
import 'package:tutorial/login_screen.dart';
import 'package:tutorial/utils/Colors.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial/experiencelevel.dart';
import 'package:tutorial/notification.dart';
import 'package:tutorial/account.dart';

class JobListScreen extends StatefulWidget {
  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class JobTypes {
  final String title;
  bool checked;
  final int count;

  JobTypes({this.title, this.checked, this.count});
}

class _JobListScreenState extends State<JobListScreen> {
  List<JobTypes> jobTypes = [
    JobTypes(title: "Full-Time", checked: false, count: 135),
    JobTypes(title: "Part-Time", checked: false, count: 235),
    JobTypes(title: "Contract", checked: false, count: 39),
    JobTypes(title: "Internship", checked: false, count: 59),
    JobTypes(title: "Temporary", checked: false, count: 21),
    JobTypes(title: "Commission", checked: false, count: 3),
  ];
  RangeValues _rangeValues = RangeValues(10, 300000);
  String username = ' ';
  String email = ' ';
  var _curIndex = 0;
  Icon cusIcon = Icon(Icons.info);
  Widget cussearch = Text(
    "JOBS 360°",
    style: TextStyle(
        fontFamily: 'Bangers',
        fontWeight: FontWeight.w600,
        letterSpacing: 2.0,
        fontSize: 18.0,
        color: Colors.black87,
        shadows: <Shadow>[
          Shadow(
              blurRadius: 15.0,
              color: Colors.white70,
              offset: Offset.fromDirection(120, 12))
        ]),
  );
  List<Job> jobsList = [
    Job(
      description:
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Eum culpa ab vitae, totam voluptatum laudantium excepturi accusantium, incidunt sunt quos nihil, odit consequuntur non modi vel veniam. Eligendi, dicta? Eius.",
      iconUrl:
          "https://images.theconversation.com/files/93616/original/image-20150902-6700-t2axrz.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1000&fit=clip",
      location: "Austin, TX",
      title: "Flutter Developer",
      salary: "\$70,000 - 120,000\$",
      photos: [
        "https://cdn.pixabay.com/photo/2015/04/20/13/17/work-731198_960_720.jpg",
        "https://cdn.pixabay.com/photo/2017/07/31/11/31/laptop-2557468_960_720.jpg",
        "https://cdn.pixabay.com/photo/2017/07/31/11/46/laptop-2557586_960_720.jpg",
        "https://cdn.pixabay.com/photo/2015/05/28/14/38/ux-787980_960_720.jpg",
      ],
    ),
    Job(
      description:
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Eum culpa ab vitae, totam voluptatum laudantium excepturi accusantium, incidunt sunt quos nihi.",
      iconUrl:
          "data:image/png;base64,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",
      location: "Chennai,India",
      title: "Web Developer",
      salary: "\$50,000 - 80,000\$",
      photos: [
        "https://cdn.pixabay.com/photo/2015/04/20/13/17/work-731198_960_720.jpg",
        "https://cdn.pixabay.com/photo/2017/07/31/11/31/laptop-2557468_960_720.jpg",
        "https://cdn.pixabay.com/photo/2017/07/31/11/46/laptop-2557586_960_720.jpg",
        "https://cdn.pixabay.com/photo/2015/05/28/14/38/ux-787980_960_720.jpg",
      ],
    ),
    Job(
      description:
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Eum culpa ab vitae, totam voluptatum laudantium excepturi accusantium, incidunt sunt quos nihil, o",
      iconUrl:
          "data:image/png;base64,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",
      location: "Bangalore,India",
      title: "Backend Developer",
      salary: "\$170,000 - 230,000\$",
      photos: [
        "https://cdn.pixabay.com/photo/2015/04/20/13/17/work-731198_960_720.jpg",
        "https://cdn.pixabay.com/photo/2017/07/31/11/31/laptop-2557468_960_720.jpg",
        "https://cdn.pixabay.com/photo/2017/07/31/11/46/laptop-2557586_960_720.jpg",
        "https://cdn.pixabay.com/photo/2015/05/28/14/38/ux-787980_960_720.jpg",
      ],
    ),
    Job(
      description:
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Eum culpa ab vitae, totam voluptatum laudantium excepturi accusantium, incidunt sunt quos nihil, odit consequuntur non modi vel veniam. Eligendi, dicta? Eius.",
      iconUrl:
          "https://media-exp1.licdn.com/dms/image/C4D0BAQFnEYpR8MlYsA/company-logo_200_200/0?e=2159024400&v=beta&t=JjmiH_nomdQ1ibxnOEXTAHAld4GA_KeuvKqUdXWlkuU",
      location: "Chennai,India",
      title: "Web Designer",
      salary: "\$30,000 - 60,000\$",
      photos: [
        "https://cdn.pixabay.com/photo/2015/04/20/13/17/work-731198_960_720.jpg",
        "https://cdn.pixabay.com/photo/2017/07/31/11/31/laptop-2557468_960_720.jpg",
        "https://cdn.pixabay.com/photo/2017/07/31/11/46/laptop-2557586_960_720.jpg",
        "https://cdn.pixabay.com/photo/2015/05/28/14/38/ux-787980_960_720.jpg",
      ],
    ),
    Job(
      description:
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Eum culpa ab vitae, totam voluptatum laudantium excepturi accusantium, incidunt sunt quos nihil, odit consequuntur non modi vel veniam. Eligendi, dicta? Eius.",
      iconUrl:
          "https://i.pinimg.com/236x/c6/4a/b0/c64ab0058891e6b84255fba554d76c45--tesla-electric-tesla-motors.jpg",
      location: "Los Angeles,SA",
      title: "AI Developer",
      salary: "\$120,000 - 160,000\$",
      photos: [
        "https://cdn.pixabay.com/photo/2015/04/20/13/17/work-731198_960_720.jpg",
        "https://cdn.pixabay.com/photo/2017/07/31/11/31/laptop-2557468_960_720.jpg",
        "https://cdn.pixabay.com/photo/2017/07/31/11/46/laptop-2557586_960_720.jpg",
        "https://cdn.pixabay.com/photo/2015/05/28/14/38/ux-787980_960_720.jpg",
      ],
    ),
  ];

  //extract the link from the inner HTML

  showAbout() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("About Jobs 360"),
          children: <Widget>[
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    text: 'This App just contains jobs from single source '),
                TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                    text: "\n The app was Designed and Created by Naveen ")
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            )
          ],
          contentPadding:
              EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0, bottom: 5.0),
        );
      },
    );
  }

  buildListView() {
//    return JobListView();
  }

  bool loading = true;

  @override
  @override
  Future<void> loggedin() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences logindata = await SharedPreferences.getInstance();
    setState(() {
      email = logindata.getString('email');
      username = logindata.getString('username');
    });
  }

  Future<void> initState() {
    super.initState();
    loggedin();
  }

  void showbottom() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "Salary Estimate",
                  style: Theme.of(context).textTheme.headline6,
                ),
                RangeSlider(
                  min: 10,
                  max: 300000,
                  values: _rangeValues,
                  onChanged: (rangeValue) {
                    setState(() {
                      _rangeValues = rangeValue;
                    });
                  },
                  labels: RangeLabels(_rangeValues.start.toString(),
                      _rangeValues.end.toString()),
                ),
                Text(
                  "Job Type",
                  style: Theme.of(context).textTheme.headline6,
                ),
                GridView.count(
                  shrinkWrap: true,
                  childAspectRatio: 3,
                  crossAxisCount: 2,
                  children: List.generate(
                    jobTypes.length,
                    (i) {
                      return Row(
                        children: <Widget>[
                          Checkbox(
                            value: jobTypes[i].checked,
                            onChanged: (bool value) {
                              setState(() {
                                jobTypes[i].checked = value;
                              });
                            },
                          ),
                          Text("${jobTypes[i].title} (${jobTypes[i].count})"),
                        ],
                      );
                    },
                  ),
                ),
                Text(
                  "Experience Level",
                  style: Theme.of(context).textTheme.headline6,
                ),
                ExperienceLevelWidget(),
                Container(
                  height: 40,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        "Submit",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .apply(color: Colors.white),
                      ),
                      onPressed: () {
                        RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: JobListView(list: jobsList),
                        );
                      }),
                )
              ],
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: MyColors.bkColor,
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                    icon: cusIcon, color: Colors.white, onPressed: showAbout)
              ],
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: cussearch,
              centerTitle: true,
            ),
            drawer: Drawer(
              elevation: 16.0,
              child: Column(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(username,
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                    accountEmail: Text(email,
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text('N',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 30.0)),
                    ),
                  ),
                  ListTile(
                    title: Text('Home'),
                    leading: Icon(Icons.home),
                    selected: true,
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => JobListScreen()));
                    },
                  ),
                  Divider(
                    height: 0.3,
                  ),
                  ListTile(
                    title: Text('Account'),
                    leading: Icon(Icons.account_circle),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => AccountScreen()));
                    },
                  ),
                  Divider(
                    height: 0.3,
                  ),
                  ListTile(
                    title: Text('Notifications'),
                    leading: Icon(Icons.notifications),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              NotificationScreen()));
                    },
                  ),
                  Divider(
                    height: 0.3,
                  ),
                  ListTile(
                    title: Text('Log Out'),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () async {
                      SharedPreferences logindata =
                          await SharedPreferences.getInstance();
                      logindata.remove('email');
                      logindata.remove('username');
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                    },
                  ),
                  Divider(
                    height: 0.3,
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      title: Text('Search'), icon: Icon(Icons.search)),
                  BottomNavigationBarItem(
                    title: Text('Filters'),
                    icon: Icon(Icons.colorize),
                  )
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: _curIndex,
                onTap: (index) {
                  setState(() {
                    _curIndex = index;
                    switch (_curIndex) {
                      case 0:
                        setState(() {
                          if (this.cusIcon.icon == Icons.info) {
                            cusIcon = Icon(Icons.cancel);
                            cussearch = TextField(
                              textInputAction: TextInputAction.go,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search Jobs,Companies,Salary",
                                  hintStyle: TextStyle(color: Colors.white)),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            );
                          } else {
                            this.cusIcon = Icon(Icons.info);
                            this.cussearch = Text(
                              "JOBS 360°",
                              style: TextStyle(
                                  fontFamily: 'Bangers',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0,
                                  fontSize: 20.0,
                                  color: Colors.pink,
                                  shadows: <Shadow>[
                                    Shadow(
                                        blurRadius: 15.0,
                                        color: Colors.white70,
                                        offset: Offset.fromDirection(120, 12))
                                  ]),
                            );
                          }
                        });

                        break;
                      case 1:
                        showbottom();
                        break;
                    }
                  });
                }),
            body: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: JobListView(list: jobsList),
            )));
  }
}

class JobListView extends StatefulWidget {
  const JobListView({
    Key key,
    this.list,
  }) : super(key: key);
  final List<Job> list;

  @override
  JobListViewState createState() {
    return new JobListViewState();
  }
}

class JobListViewState extends State<JobListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.list.isNotEmpty
            ? widget.list.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Stack(
                    children: <Widget>[
                      Dismissible(
                        key: Key(item.title),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          setState(() {
                            widget.list.removeAt(widget.list.indexOf(item));
                          });
                        },
                        child: ClippedItem(item: item),
                      ),
                      CircleCompanyLogo(
                        company: item.iconUrl,
                      ),
                    ],
                  ),
                );
              }).toList()
            : []);
  }
}

class ClippedItem extends StatefulWidget {
  const ClippedItem({
    Key key,
    this.item,
  }) : super(key: key);

  final Job item;

  @override
  ClippedItemState createState() {
    return ClippedItemState();
  }
}

class ClippedItemState extends State<ClippedItem>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation = Tween<Offset>(begin: Offset(200.0, 0.0), end: Offset(0.0, 0.0))
        .animate(curvedAnimation);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: ClipPath(
        clipper: Clipper(),
        child: Card(
          color: Color.fromRGBO(47, 65, 123, 1.0),
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          child: InkWell(
            onTap: () {
              print(widget.item.title.trim());
              Navigator.push(
                context,
                MaterialPageRoute(
                    /*builder: (context) => Detail(widget.item),*/
                    ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, top: 20.0, right: 10.0, bottom: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                            height: 50.0,
                            child: Text(
                              widget.item.title.trim(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        color: Colors.white70,
                      ),
                      Text(
                        widget.item.title.trim(),
                        style: TextStyle(color: Colors.white70),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        widget.item.location.trim(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.location_city,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    var radius = 28.0;

    path.lineTo(0.0, size.height / 2 + radius);
    path.arcToPoint(
      Offset(0.0, size.height / 2 - radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

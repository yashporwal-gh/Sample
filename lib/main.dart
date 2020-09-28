import 'package:Sample/constants.dart';
import 'package:Sample/details_screen.dart';
import 'package:Sample/model/category.dart';
import 'package:flutter/material.dart';
//import 'package:Sample/model/DashboardCategory.dart';
import 'package:Sample/Dashboard.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:Sample/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample App',
      theme: ThemeData(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Charusat E-learn"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new DrawerHeader(
              child: Icon(
                Icons.account_box,
                size: 90,
              ),
              decoration: BoxDecoration(color: Colors.white),
            ),
            ListTile(
              title: Text('Courses Enrolled'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
                //Navigator.pop(context);
              },
            ),
            //Text('Menu Item 1'),
            //Text('Menu Item 2')
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     //  SvgPicture.asset("icons/menu.svg")
            //     //  Icon(Icons.menu),
            //    // Image.asset("images/user.png"),
            //   ],
            // ),
            // SizedBox(height: 30),
            Text("Hey Avinash,", style: kHeadingextStyle),
            Text("Find a course you want to learn", style: kSubheadingextStyle),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: <Widget>[
                  //  SvgPicture.asset("icons/search.svg"),
                  // IconButton(
                  //     icon: Icon(Icons.search),
                  //     onPressed: () {
                  //       showSearch(context: context, delegate: SearchBar());
                  //     }),
                  // Icons.search;
                  FlatButton(
                    onPressed: () {
                      showSearch(context: context, delegate: SearchBar());
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.search),
                        SizedBox(width: 16),
                        Text(
                          "Search for anything",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFA0A5BD),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Icon(Icons.search),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Courses", style: kTitleTextStyle),
                // Text(
                //   "See All",
                //   style: kSubtitleTextSyule.copyWith(color: kBlueColor),
                // ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(0),
                crossAxisCount: 2,
                itemCount: categories.length,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemBuilder: (context, index) {
                  return FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen()),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          height: index.isEven ? 200 : 240,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(categories[index].image),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              categories[index].name,
                              style: kTitleTextStyle,
                            ),
                          ),
                        ),
                        // Text(
                        //   '${categories[index].Instructor}',
                        //   style: TextStyle(
                        //     color: kTextColor.withOpacity(.5),
                        //   ),
                        // )
                      ],
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends SearchDelegate<String> {
  final Courses = [
    "Python",
    "AWS",
    "Computer Networking",
    "Java",
    "Operating System"
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query, style: TextStyle(fontSize: 20)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final my_list = query.isEmpty
        ? Courses
        : Courses.where((str) =>
                str.startsWith(query[0].toUpperCase() + query.substring(1)))
            .toList();
    return my_list.isEmpty
        ? Text("No Course Found....", style: TextStyle(fontSize: 20))
        : ListView.builder(
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                showResults(context);
              },
              title: Text(my_list[index]),
            ),
            itemCount: my_list.length,
          );
  }
}

class VideoPlayer extends StatelessWidget {
  final link;
  VideoPlayer(this.link);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: ListView(
        children: <Widget>[
          ChewieListItem(
            videoPlayerController: VideoPlayerController.network(
              'https://firebasestorage.googleapis.com/v0/b/classroom-f081d.appspot.com/o/WhatsApp%20Video%202020-08-15%20at%2012.54.03%20AM.mp4?alt=media&token=9f75937d-fb6d-42b6-a481-84a561b54eec',
            ),
            looping: true,
          ),
        ],
      ),
    );
  }
}

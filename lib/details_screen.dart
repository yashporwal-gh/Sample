import 'package:Sample/constants.dart';
import 'package:Sample/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:Sample/LecturesList.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
List<LectureList> ListofLinks = [];

class Database {
  Future<String> method() { 
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('Computer Network').once().then((DataSnapshot snap) {
      var Lecture = snap.value.keys;
      var Link = snap.value;
      // var i = 1;
      for (var key in Lecture) {
        ListofLinks.add(new LectureList("01", Link[key]['Link'], key));
        // i = i + 1;
      }
    });
  }
}
class StoreData extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<StoreData> {
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F4EF),
          image: DecorationImage(
            image: AssetImage("images/ux_big.png"),
            alignment: Alignment.topRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, top: 50, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // SvgPicture.asset("icons/arrow-left.svg"),
                      //SvgPicture.asset("icons/more-vertical.svg"),
                    ],
                  ),
                  SizedBox(height: 30),
                  // ClipPath(
                  //   clipper: BestSellerClipper(),
                  //   child: Container(
                  //     color: kBestSellerColor,
                  //     padding: EdgeInsets.only(
                  //         left: 10, top: 5, right: 20, bottom: 5),
                  //     // child: Text(
                  //     //   "BestSeller".toUpperCase(),
                  //     //   style: TextStyle(
                  //     //     fontWeight: FontWeight.w600,
                  //     //   ),
                  //     // ),
                  //   ),
                  // ),
                  SizedBox(height: 16),
                  Text("AWS", style: kHeadingextStyle),
                  SizedBox(height: 16),

                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 60),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 1,
                  // _State stat =  new _State(),

                  itemCount: ListofLinks.length,
                  // crossAxisSpacing: 20,
                  // mainAxisSpacing: 20,
                  itemBuilder: (context, index) {
                    return FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoPlayer(ListofLinks[index]
                                  .link)),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Course Content", style: kTitleTextStyle),
                                SizedBox(height: 30),
                                CourseContent(
                                  number: "01",
                                  // duration: 5.35,
                                  title: "new _State",
                                  link: "true",
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 50,
                                    color: kTextColor.withOpacity(.1),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: kBlueColor,
                                      ),
                                      child: Text(
                                        "Enroll Now",
                                        style: kSubtitleTextSyule.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1),

                  //
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CourseContent extends StatelessWidget {
  final String number;
  // final double duration;
  final String title;
  final String link;
  const CourseContent({
    Key key,
    this.number,
    //this.duration,
    this.title,
    this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Text(
            number,
            style: kHeadingextStyle.copyWith(
              color: kTextColor.withOpacity(.15),
              fontSize: 32,
            ),
          ),
          SizedBox(width: 20),
          RichText(
            text: TextSpan(
              children: [
                // TextSpan(
                //   text: "$duration mins\n",
                //   style: TextStyle(
                //     color: kTextColor.withOpacity(.5),
                //     fontSize: 18,
                //   ),
                // ),
                TextSpan(
                  text: title,
                  style: kSubtitleTextSyule.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 20),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kGreenColor.withOpacity(1),
            ),
            child: Icon(Icons.play_arrow, color: Colors.white),
          )
        ],
      ),
    );
  }
}

// class BestSellerClipper extends CustomClipper<Path> {
//   @override
//   getClip(Size size) {
//     var path = Path();
//     path.lineTo(size.width - 20, 0);
//     path.lineTo(size.width, size.height / 2);
//     path.lineTo(size.width - 20, size.height);
//     path.lineTo(0, size.height);
//     path.lineTo(0, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper oldClipper) {
//     return false;
//   }
// }

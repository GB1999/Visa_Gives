
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visa_gives/services/firebase_database_service.dart';
import 'package:visa_gives/widgets/featured_carousel.dart';
import 'package:visa_gives/models/nonprofit.dart';
import 'package:visa_gives/widgets/nonprofit_preview.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final database = Provider.of<FirebaseDatabaseService>(context);
      final nonprofits = database.fetchNonprofits;
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Nonprofit> nonprofits = [
    Nonprofit(
        id: 'np1',
        name: 'St. Judes',
        description:
            "Saint Jude Children's Research Hospital, founded in 1962, is a pediatric treatment and research facility focused on children's catastrophic diseases, particularly leukemia and other cancers.",
        expenditures: 'Money helps kids',
        coverPhoto: 'https://wrcb.images.worldnow.com/images/19279667_G.jpeg?auto=webp&disable=upscale&height=560&fit=bounds&lastEditedDate=1584892203000',
        additionalPhotos: [],
        tags: [
          'Cancer',
          'Children',
          'Medical',
        ]),
    Nonprofit(
        id: 'np2',
        name: 'American Civil Liberties Union',
        description:
            "The American Civil Liberties Union is a nonprofit organization founded in 1920 'to defend and preserve the individual rights and liberties guaranteed to every person in this country by the Constitution and laws of the United States'.",
        expenditures: 'Money goes places',
        coverPhoto: 
          'https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web17-7ptactionplan-1160x768.jpg?itok=YUzRCJfN',
        additionalPhotos: [],
        tags: [
          'Civil',
          'African-American',
        ]),
  ];
    
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            //physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: <Widget>[
              // DrawerHeader(
              //   child: drawerProfile(
              //     user.name,
              //     user.profilePicture,
              //   ),
              //   decoration: BoxDecoration(
              //       //color: Colors.blue,
              //       ),
              // ),
              customListTile(
                40,
                'Donation History',
                Icons.description,
                -1.3,
                '/Donation_History',
              ),
              customListTile(
                40,
                'Bookmarked',
                Icons.bookmark_border,
                -1.3,
                '/Bookmarked',
              ),
              customListTile(
                40,
                'Payment Options',
                Icons.credit_card,
                -1.3,
                '/Payment_Options',
              ),
              Divider(
                height: 20,
              ),
              customListTile(
                40,
                'Settings',
                Icons.settings,
                -1.3,
                '/Settings',
              ),
              customListTile(
                40,
                'Notifications',
                Icons.notifications,
                -1.3,
                '/Notifications',
              ),
              Divider(),
              customListTile(
                40,
                'Terms of Service',
                Icons.description,
                -1.3,
                '/Terms_of_Service',
              ),
              customListTile(
                40,
                'Privacy Policy',
                Icons.description,
                -1.3,
                '/Privacy_Policy',
              ),
              Divider(),
              customListTile(
                40,
                'Sign Out',
                Icons.exit_to_app,
                -1.3,
                '/Sign_Out',
              ),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: new IconThemeData(color: Colors.black38),
          actions: <Widget>[
            Align(
              child: Text(
                'Search',
                style: TextStyle(color: Colors.black38),
              ),
              alignment: Alignment.center,
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black38,
              ),
              onPressed: () {},
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<FirebaseDatabaseService>(context).fetchNonprofits();
            setState(() {
            });
          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([FeaturedCarousel()]),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => ChangeNotifierProvider.value(
                    value: nonprofits[i],
                    child: NonprofitPreview(),
                  ),
                  childCount: nonprofits.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerProfile(String name, String profileUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        profileUrl != null ? CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(profileUrl),
          backgroundColor: Colors.transparent,
        ) : Icon(Icons.account_circle, size: 30,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name, style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }

  Widget customListTile(double height, String title, IconData iconData,
      double alignment, String routeName) {
    return Container(
      height: height,
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(title),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: Icon(
            iconData,
            size: 18,
            color: Colors.black,
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
      ),
    );
  }
}

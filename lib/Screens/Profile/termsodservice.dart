import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';
import 'package:addistutor_student/constants.dart';

import 'package:flutter/material.dart';

class ProductDescriptionPage extends StatefulWidget {
  final String name, image;

  const ProductDescriptionPage({Key? key, this.name = '', this.image = ''})
      : super(key: key);
  @override
  _ProductDescriptionPageState createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  // initialize reusable widget

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Material(
            color: Colors.white,
            child: InkWell(
              borderRadius:
                  BorderRadius.circular(AppBar().preferredSize.height),
              child: const Icon(
                Icons.arrow_back_ios,
                color: DesignCourseAppTheme.nearlyBlack,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: const Text(
            "Terms of Service ",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
        ),
        body: ListView(
          children: [
            _createProductImageAndTitle(boxImageSize),
            Divider(height: 0, color: Colors.grey[400]),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                '1. Payment \n',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                  height: 0.9,
                  wordSpacing: 0.4,
                  color: kPrimaryColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                ' \nAs soon as a tutor accepts your request, you are ecpected to finalise payment within 24 hrs. Failure to do so means NextGen won’t be able to guarantee the same tutor.\n\n',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.4,
                  height: 0.9,
                  wordSpacing: 0.4,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(height: 0, color: Colors.grey[400]),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                '1. Siblings \n',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                  height: 0.9,
                  wordSpacing: 0.4,
                  color: kPrimaryColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                ' \nA sibling can join a session provided that s/he is in the same category (KG, first cycle primary, second cycle primary, secondary or Preparatory) as the child to whom the service is requested. In such instances no additional payment is required. However, if the sibling is not in the same category or it is more than one sibling, a separate bookings needs to be made.\n\n',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.4,
                  height: 0.9,
                  wordSpacing: 0.4,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _createProductImageAndTitle(boxImageSize) {
    return Container(
        margin: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: Image.asset('assets/images/lg3.png',
                    width: boxImageSize, height: boxImageSize)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Terms of service of students",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                      height: 0.9,
                      color: kPrimaryColor,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

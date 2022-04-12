import 'package:addistutor_student/Screens/search/components/hotel_app_theme.dart';
import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/remote_services/user.dart';

import 'package:flutter/material.dart';

class HotelListView extends StatelessWidget {
  const HotelListView({Key? key, this.hotelData, this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final Search? hotelData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              offset: const Offset(4, 4),
              blurRadius: 16,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 2,
                    child: Image.network(
                      "https://nextgeneducation.et/api/teacher-profile-picture/${hotelData!.id}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: HotelAppTheme.buildLightTheme().backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  hotelData!.first_name +
                                      " " +
                                      hotelData!.last_name,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(children: [
                                  Text(
                                    ' ${hotelData!.gender}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.withOpacity(0.8)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.location_pin,
                                    color: kPrimaryLightColor,
                                    size: 10,
                                  ),
                                  Text(
                                    ' ${hotelData!.location.name}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.withOpacity(0.8)),
                                  ),
                                ]),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16, top: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              // Text(
                              //   '${hotelData!.qualification_id.title} ',
                              //   textAlign: TextAlign.left,
                              //   style: const TextStyle(
                              //     fontWeight: FontWeight.w600,
                              //     fontSize: 12,
                              //   ),
                              // ),
                              hotelData!.rating != null
                                  ? Row(children: [
                                      Text(
                                        '${hotelData!.rating} ',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: kPrimaryLightColor,
                                        size: 20,
                                      ),
                                    ])
                                  : Row(children: [
                                      Text(
                                        '0 ',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: kPrimaryLightColor,
                                        size: 20,
                                      ),
                                    ])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

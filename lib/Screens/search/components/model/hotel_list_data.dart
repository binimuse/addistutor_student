class HotelListData {
  HotelListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = 180,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int perNight;

  static List<HotelListData> hotelList = <HotelListData>[
    HotelListData(
      imagePath: 'assets/images/profile2.jpg',
      titleTxt: 'Biniyam musema',
      subTxt: 'Addis ababa',
      dist: 2.0,
      reviews: 8,
      rating: 4.4,
      perNight: 1800,
    ),
    HotelListData(
      imagePath: 'assets/images/profile1.jpg',
      titleTxt: 'Biniyam musema',
      subTxt: 'Addis ababa',
      dist: 2.0,
      reviews: 8,
      rating: 4.4,
      perNight: 1800,
    ),
    HotelListData(
      imagePath: 'assets/images/profile3.jpg',
      titleTxt: 'Biniyam musema',
      subTxt: 'Addis ababa',
      dist: 2.0,
      reviews: 8,
      rating: 4.4,
      perNight: 1800,
    ),
    HotelListData(
      imagePath: 'assets/images/profile3.jpg',
      titleTxt: 'Biniyam musema',
      subTxt: 'Addis ababa',
      dist: 2.0,
      reviews: 8,
      rating: 4.4,
      perNight: 1800,
    ),
    HotelListData(
      imagePath: 'assets/images/profile3.jpg',
      titleTxt: 'Biniyam musema',
      subTxt: 'Addis ababa',
      dist: 2.0,
      reviews: 8,
      rating: 4.4,
      perNight: 1800,
    ),
  ];
}

// ignore_for_file: non_constant_identifier_names

class Student {
  int id;

  String parent_first_name;
  String parent_last_name;
  String first_name;

  String last_name;
  String phone_no;
  String email;
  String gender;
  String birth_date;
  String location;

  String grade;
  String study_purpose;
  String about;

  Student({
    required this.id,
    required this.parent_first_name,
    required this.parent_last_name,
    required this.first_name,
    required this.last_name,
    required this.phone_no,
    required this.email,
    required this.gender,
    required this.birth_date,
    required this.location,
    required this.grade,
    required this.study_purpose,
    required this.about,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json["id"] as int,
      parent_first_name: json["parent_first_name"],
      parent_last_name: json["parent_last_name"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      phone_no: json["phone_no"],
      email: json["email"],
      gender: json["gender"],
      birth_date: json["birth_date"],
      location: json["location"],
      grade: json["grade"],
      study_purpose: json["study_purpose"],
      about: json["about"],
    );
  }
}

class Locations {
  int id;

  String name;
  String description;

  Locations({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      id: json["id"],
      name: json["name"],
      description: json["description"],
    );
  }
}

class GetLocationforedit {
  int id;

  String name;
  String description;
  List<Locations> locaion;
  GetLocationforedit({
    required this.id,
    required this.name,
    required this.description,
    required this.locaion,
  });

  factory GetLocationforedit.fromJson(Map<String, dynamic> json) {
    return GetLocationforedit(
      id: json["id"] as int,
      name: json["name"],
      description: json["description"],
      locaion: List<Locations>.from(
          json["locations"].map((x) => Locations.fromJson(x))),
    );
  }
}

class GetLocation {
  int id;

  String name;
  String description;

  GetLocation({
    required this.id,
    required this.name,
    required this.description,
  });

  factory GetLocation.fromJson(Map<String, dynamic> json) {
    return GetLocation(
      id: json["id"] as int,
      name: json["name"],
      description: json["description"],
    );
  }
}

class GetEducationlevel {
  int id;

  String title;
  String description;

  GetEducationlevel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory GetEducationlevel.fromJson(Map<String, dynamic> json) {
    return GetEducationlevel(
      id: json["id"] as int,
      title: json["title"],
      description: json["description"],
    );
  }
}

class GetSubject {
  int id;

  String title;
  String code;

  GetSubject({
    required this.id,
    required this.title,
    required this.code,
  });

  factory GetSubject.fromJson(Map<String, dynamic> json) {
    return GetSubject(
      id: json["id"] as int,
      title: json["title"],
      code: json["code"],
    );
  }
}

class Qualification {
  int id;

  String title;
  String description;

  Qualification({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) {
    return Qualification(
      id: json["id"] as int,
      title: json["title"],
      description: json["description"],
    );
  }
}

class Search {
  int id;
  String user_id;
  String first_name;
  String middle_name;
  String last_name;
  String phone_no;
  String gender;
  String about;
  String rating;
  String price;

  String location_id;
  String profile_img;
  String teaching_since;
  GetLocation location;
  // Qualification qualification_id;
//  List<GetSubject> preferred_tutoring_subjects;
  GetSubject subject_id;

  Search({
    required this.id,
    required this.user_id,
    required this.first_name,
    required this.middle_name,
    required this.last_name,
    required this.phone_no,
    required this.gender,
    required this.about,
    required this.price,
    required this.rating,
    required this.location_id,
    required this.profile_img,
    required this.teaching_since,
    required this.location,
    //  required this.qualification_id,
    //  required this.preferred_tutoring_subjects,
    required this.subject_id,
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      id: json["id"],
      user_id: json["user_id"],
      first_name: json["first_name"],
      middle_name: json["middle_name"],
      last_name: json["last_name"],
      phone_no: json["phone_no"],
      gender: json["gender"],
      about: json["about"],
      price: json["price"],
      rating: json["rating"],
      profile_img: json["profile_img"],
      teaching_since: json["teaching_since"],
      location_id: json["location_id"],
      location: GetLocation.fromJson(json["location"]),
      subject_id: GetSubject.fromJson(
        json["subject_id"],
      ),
    );
  }
}

class Day {
  int id;

  String day;
  String teacher_id;

  Day({
    required this.id,
    required this.day,
    required this.teacher_id,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      id: json["id"] as int,
      day: json["day"],
      teacher_id: json["teacher_id"],
    );
  }
}

class Bookingschedule {
  int id;

  String day;
  String readable_time;
  String booking_id;

  Bookingschedule({
    required this.id,
    required this.day,
    required this.readable_time,
    required this.booking_id,
  });

  factory Bookingschedule.fromJson(Map<String, dynamic> json) {
    return Bookingschedule(
      id: json["id"] as int,
      day: json["day"],
      readable_time: json["readable_time"],
      booking_id: json["booking_id"],
    );
  }
}

class ReqTech {
  int id;

  String first_name;
  String middle_name;
  String last_name;
  String phone_no;
  String gender;
  String birth_date;

  String about;
  String rating;

  String location_id;
  String profile_img;
  String teaching_since;

  ReqTech({
    required this.id,
    required this.first_name,
    required this.middle_name,
    required this.last_name,
    required this.phone_no,
    required this.gender,
    required this.birth_date,
    required this.about,
    required this.rating,
    required this.location_id,
    required this.profile_img,
    required this.teaching_since,
  });

  factory ReqTech.fromJson(Map<String, dynamic> json) {
    return ReqTech(
      id: json["id"],
      first_name: json["first_name"],
      middle_name: json["middle_name"],
      last_name: json["last_name"],
      phone_no: json["phone_no"],
      gender: json["gender"],
      birth_date: json["birth_date"],
      about: json["about"],
      rating: json["rating"],
      profile_img: json["profile_img"],
      teaching_since: json["teaching_since"],
      location_id: json["location_id"],
    );
  }
}

class RequestedBooking {
  int id;

  String session;
  int sessiontaken;
  String message;
  String verified_status;
  String teacher_id;
  String is_active;
  String ended_at;
  GetSubject subject;
  String student_id;
  List<Bookingschedule> booking_schedule;
  ReqTech teacher;

  RequestedBooking({
    required this.id,
    required this.session,
    required this.sessiontaken,
    required this.is_active,
    required this.message,
    required this.verified_status,
    required this.teacher_id,
    required this.student_id,
    required this.teacher,
    required this.subject,
    required this.ended_at,
    required this.booking_schedule,
  });

  factory RequestedBooking.fromJson(Map<String, dynamic> json) {
    return RequestedBooking(
      id: json["id"] as int,
      is_active: json["is_active"],
      session: json["session"],
      message: json["message"],
      verified_status: json["verified_status"],
      teacher_id: json["teacher_id"],
      student_id: json["student_id"],
      ended_at: json["ended_at"],
      sessiontaken: json["sessions_taken"],
      subject: GetSubject.fromJson(json["subject"]),
      teacher: ReqTech.fromJson(json["teacher"]),
      booking_schedule: List<Bookingschedule>.from(
          json["booking_schedule"].map((x) => Bookingschedule.fromJson(x))),
    );
  }
}

class ContactUS {
  String name;
  String email;
  String phone;
  String phone2;
  String facebook;
  String twitter;
  String instagram;
  String linkedin;

  ContactUS({
    required this.name,
    required this.email,
    required this.phone,
    required this.phone2,
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.linkedin,
  });

  factory ContactUS.fromJson(Map<String, dynamic> json) {
    return ContactUS(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      phone2: json["secondary_phone"],
      facebook: json["facebook"],
      twitter: json["twitter"],
      instagram: json["instagram"],
      linkedin: json["linkedin"],
    );
  }
}

class NotificationData {
  String message;
  String redirect_url;
  String notification_type;

  String teacher_name;
  int booking_id;
  String student_name;

  NotificationData({
    required this.message,
    required this.redirect_url,
    required this.notification_type,
    required this.teacher_name,
    required this.booking_id,
    required this.student_name,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      message: json["message"],
      redirect_url: json["redirect_url"],
      notification_type: json["notification_type"],
      teacher_name: json["teacher_name"],
      booking_id: json["booking_id"],
      student_name: json["student_name"],
    );
  }
}

class Notifications {
  String id;
  String type;
  String notifiable_type;
  String notifiable_id;
  String read_at;

  String created_at;
  NotificationData data;
  Notifications({
    required this.id,
    required this.type,
    required this.notifiable_type,
    required this.notifiable_id,
    required this.read_at,
    required this.created_at,
    required this.data,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json["id"],
      type: json["type"],
      notifiable_type: json["notifiable_type"],
      notifiable_id: json["notifiable_id"],
      read_at: json["read_at"],
      created_at: json["created_at"],
      data: NotificationData.fromJson(json["data"]),
    );
  }
}

class Qr {
  String data;

  Qr({
    required this.data,
  });

  factory Qr.fromJson(Map<String, dynamic> json) {
    return Qr(
      data: json["data"],
    );
  }
}

class Balance {
  String wallet_amount;

  Balance({
    required this.wallet_amount,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      wallet_amount: json["wallet_amount"],
    );
  }
}

class Transaction {
  String slip_id;
  String amount;
  String status;
  String date;

  Transaction({
    required this.slip_id,
    required this.amount,
    required this.status,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      slip_id: json["slip_id"],
      amount: json["amount"],
      status: json["status"],
      date: json["date"],
    );
  }
}

class Myaccount {
  String full_name;
  String email;
  String phone;

  Myaccount({
    required this.full_name,
    required this.email,
    required this.phone,
  });

  factory Myaccount.fromJson(Map<String, dynamic> json) {
    return Myaccount(
      full_name: json["full_name"],
      email: json["email"],
      phone: json["phone"],
    );
  }
}

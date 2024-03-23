class BookingsModel{
  String booking_id;
  String booking_amount;
  String date;
  String expiry;
  String guide_id;
  String guide_name;
  String guide_photo;
  String status;
  String sub_id;
  String sub_lang;
  String sub_photo;
  String sub_title;
  String user_id;
  String user_name;
  String user_avatar;

  BookingsModel({
    required this.booking_id,
    required this.booking_amount,
    required this.date,
    required this.expiry,
    required this.guide_id,
    required this.guide_name,
    required this.guide_photo,
    required this.status,
    required this.sub_id,
    required this.sub_lang,
    required this.sub_photo,
    required this.sub_title,
    required this.user_id,
    required this.user_name,
    required this.user_avatar

  });
}
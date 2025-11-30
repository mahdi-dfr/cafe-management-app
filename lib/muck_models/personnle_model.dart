import 'package:cafe_app/core/constants/assets_route.dart';

class PersonnelModel {
  int? id;
  String? firstName;
  String? lastName;
  String? avatar;
  String? phoneNumber;
  String? email;
  int? age;
  int? offDay;
  String? position;
  String? hiringDate = '';

  PersonnelModel(
    this.id,
    this.firstName,
    this.lastName,
    this.avatar,
    this.phoneNumber,
    this.email,
    this.age,
    this.offDay,
    this.position,
  );
}

List<PersonnelModel> personnelList = [
  PersonnelModel(1, 'Mahdi', 'Daneshfar', AssetsRoute.img, '09123334455', 'test@mail.com', 25, 0, 'سرپرست'),
  PersonnelModel(2, 'Ali', 'Rahimi', AssetsRoute.img, '09124534450', 'test1@mail.com', 26, 1, 'باریستا'),
  PersonnelModel(3, 'Hassan', 'Mirjafary', AssetsRoute.img, '09143324465', 'test2@mail.com', 27, 2, 'باریستا',),
  PersonnelModel(4, 'Hosein', 'Azimi', AssetsRoute.img, '09123334455', 'test8@mail.com', 24, 3, 'باریستا'),
  PersonnelModel(5, 'Sara', 'Afshar', AssetsRoute.img, '09123334455', 'test5@mail.com', 23, 4, 'سرپرست'),
  PersonnelModel(6, 'Bahar', 'Rezae', AssetsRoute.img, '09123334455', 'test6@mail.com', 28, 5, 'سالن دار'),
  PersonnelModel(7, 'Farhad', 'Hosseini', AssetsRoute.img, '09123334455', 'test3@mail.com', 30, 6, 'باریستا'),
  PersonnelModel(8, 'Faezeh', 'Amiri', AssetsRoute.img, '09123374448', 'test4@mail.com', 29, 4, 'سالن دار'),
];

Map<int, dynamic> convertDayOff = {
  0: 'شنبه',
  1: 'یکشنبه',
  2: 'دوشنبه',
  3: 'سه شنبه',
  4: 'چهارشنبه',
  5: 'پنجشنبه',
  6: 'جمعه',
};


List<String> charter = [
  'حضور در محل کار 10 دقیقه قبل از شروع تایم کاری',
  'پوشش فرم مناسب مجموعه در محل کار',
  'رعایت بهداشت و نظافت فردی و آراستگی در محل کار',
  'رعایت ادب و احترام هنگام کار کردن با همکار',
  'رعایت اصول اخلاقی و ادب در مقابل مدیریت و مسئول بخش مورد نظر',
  'گزارش روزانه مربوط به هر سکشن به مدیریت مجموعه',
  'رعایت نحوه برخورد و اصول اخلاقی حرفه ای در مقابل مشتری',
  'رعایت تکنیکال اصول و قواعد هر سکشن',
  'هماهنگی با مدیر مربوطه برای ورود و خروج از محیط کار',
  'در صورت بروز هر گونه مشکل به مدیر اطلاع دهید',
  'مظافت کامل هر سکشن قبل از اتمام شیفت',
  'ارسال فیلم بک واش هر سکشن در گروه قبل از تحویل شیفت',
];

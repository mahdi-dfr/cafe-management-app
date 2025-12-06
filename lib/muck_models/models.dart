class BackWash {
  String? title;
  String? user;
  String? day;
  bool? status;

  BackWash(this.title, this.user, this.status, this.day);
}

List<BackWash> backwashList = [
  BackWash('شستن پیچر ها', 'مهدی دانش فر', false, 'شنبه'),
  BackWash('شستن مت بار ها', 'علی رضایی', true, 'یکشنبه'),
  BackWash('شستن شیکر ها', 'مهدی دانش فر', true, 'دوشنبه'),
  BackWash('شستن کدی بار', 'حسین عظیمی', false, 'شنبه'),
  BackWash('شستن ایزارهای بار', 'سارا افشار', true, 'شنبه'),
  BackWash('شستن جویس باتل ها', 'سارا افشار', true, 'شنبه'),
  BackWash('بکواش بار استیشن', 'فائزه امیری', false, 'شنبه'),
  BackWash('تمیز کردن یخچال ها', 'مهدی دانش فر', false, 'شنبه'),
  BackWash('چک کردن بانک ها', 'فرهاد حسینی', true, 'شنبه'),
  BackWash('نوشتن لیست خرید', 'فرهاد حسینی', false, 'شنبه'),
  BackWash('تمیز کردن ماک باکس', 'فائزه امیری', true, 'شنبه'),
];

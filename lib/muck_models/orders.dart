class TableModel {
  final int number;
  final bool isOccupied;
  final List<String> orders;

  TableModel({required this.number, required this.isOccupied, required this.orders});
}

class Order{
  String? orderName;
  String? orderImage;
  int? count;

}
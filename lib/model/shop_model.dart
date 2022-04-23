class ShopModel {
  final int id;
  final String itemName;
  final String itemPrice;
  final String itemDate;
  final String itemQuantity;
  final String total;

  ShopModel(
      {this.id,
      this.itemName,
      this.itemPrice,
      this.itemDate,
      this.itemQuantity,
      this.total});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemName': itemName,
      'itemPrice': itemPrice,
      'itemDate': itemDate,
      'itemQuantity': itemQuantity,
      'total': total
    };
  }

  static ShopModel fromMap(Map<String, dynamic> map) {
    return ShopModel(
        id: map['id'],
        itemName: map['itemName'],
        itemQuantity: map['itemQuantity'],
        itemPrice: map['itemPrice'],
        itemDate: map['itemDate'],
        total: map['total']);
  }
}

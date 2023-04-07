class Snack {
  final String foodCode;
  final String name;
  final String picture;
  final String price;
  final String pictureOri;
  final String createdAt;
  final int id;

  Snack({
    required this.foodCode,
    required this.name,
    required this.picture,
    required this.price,
    required this.pictureOri,
    required this.createdAt,
    required this.id,
  });

  factory Snack.fromJson(Map<String, dynamic> json) {
    return Snack(
      foodCode: json['food_code'],
      name: json['name'],
      picture: json['picture'],
      price: json['price'],
      pictureOri: json['picture_ori'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'food_code': foodCode,
        'name': name,
        'picture': picture,
        'price': price,
        'picture_ori': pictureOri,
        'created_at': createdAt,
        'id': id,
      };
}

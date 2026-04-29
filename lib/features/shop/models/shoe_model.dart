class Shoe {
  final String name;
  final String price;
  final String description;
  final String imagePath;
  final bool isBestSeller;
  final String detail;

  Shoe({
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    this.isBestSeller = false,
    required this.detail,
  });

  factory Shoe.fromMap(Map<String, dynamic> map) {
    return Shoe(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      description: map['description'] ?? '',
      imagePath: map['imagePath'] ?? '',
      detail: map['detail'] ?? '',
      isBestSeller: map['isBestSeller'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'imagePath': imagePath,
      'detail': detail,
      'isBestSeller': isBestSeller,
    };
  }
}

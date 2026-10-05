class CarModel {
  int _id;
  String _name;
  String _type;
  double _price;
  String _imageUrl;
  String _description;
  String _engine;
  String _topSpeed;
  int _year;
  bool _isFavorite;
  int _stock;

  CarModel({
    required int id,
    required String name,
    required String type,
    required double price,
    required String imageUrl,
    required String description,
    required String engine,
    required String topSpeed,
    int year = 2025,
    bool isFavorite = false,
    int stock = 1,
  }) : _id = id,
       _name = name,
       _type = type,
       _price = price,
       _imageUrl = imageUrl,
       _description = description,
       _engine = engine,
       _topSpeed = topSpeed,
       _year = year,
       _isFavorite = isFavorite,
       _stock = stock;

  // ===== GETTERS =====
  int get id => _id;
  String get name => _name;
  String get type => _type;
  double get price => _price;
  String get imageUrl => _imageUrl;
  String get description => _description;
  String get engine => _engine;
  String get topSpeed => _topSpeed;
  int get year => _year;
  bool get isFavorite => _isFavorite;
  int get stock => _stock;

  String get formattedPrice {
    final formatted = _price
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.');
    return 'Rp $formatted';
  }

  String get availabilityStatus {
    if (_stock == 0) return 'Habis';
    if (_stock < 3) return 'Stok Terbatas ($_stock unit)';
    return 'Tersedia ($_stock unit)';
  }

  // ===== SETTERS =====
  set name(String value) {
    if (value.isEmpty) throw Exception('Nama mobil tidak boleh kosong');
    _name = value;
  }

  set price(double value) {
    if (value < 0) throw Exception('Harga tidak boleh negatif');
    _price = value;
  }

  set type(String value) {
    const validTypes = ['Sedan', 'SUV', 'Sport', 'Electric'];
    if (!validTypes.contains(value)) {
      throw Exception('Tipe mobil tidak valid: $value');
    }
    _type = value;
  }

  set stock(int value) {
    if (value < 0) throw Exception('Stok tidak boleh negatif');
    _stock = value;
  }

  // ===== METHODS =====
  void toggleFavorite() {
    _isFavorite = !_isFavorite;
  }

  bool isPromo() => _price > 2000000000;

  double calculateDiscount(double percent) {
    if (percent < 0 || percent > 100) {
      throw Exception('Diskon harus antara 0-100%');
    }
    return _price - (_price * percent / 100);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'type': _type,
      'price': _price,
      'imageUrl': _imageUrl,
      'description': _description,
      'engine': _engine,
      'topSpeed': _topSpeed,
      'year': _year,
      'isFavorite': _isFavorite,
      'stock': _stock,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'] as int,
      name: map['name'] as String,
      type: map['type'] as String,
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'] as String,
      description: map['description'] as String,
      engine: map['engine'] as String,
      topSpeed: map['topSpeed'] as String,
      year: map['year'] as int? ?? 2025,
      isFavorite: map['isFavorite'] as bool? ?? false,
      stock: map['stock'] as int? ?? 1,
    );
  }

  @override
  String toString() => 'CarModel($_name, $_type, $formattedPrice)';
}

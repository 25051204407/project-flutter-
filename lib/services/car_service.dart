import '../models/car_model.dart';

class CarService {
  // ===== SINGLETON =====
  static final CarService _instance = CarService._internal();
  factory CarService() => _instance;
  CarService._internal();

  // ===== DATA =====
  final List<CarModel> _cars = [
    CarModel(
      id: 1,
      name: 'Mercedes-Benz S-Class',
      type: 'Sedan',
      price: 3500000000,
      imageUrl:
          'https://images.unsplash.com/photo-1660139131278-607310e532fe?q=80&w=1169&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      description:
          'Sedan mewah dengan teknologi terdepan dan kenyamanan kelas dunia.',
      engine: '3.0L V6 Turbo',
      topSpeed: '250 km/h',
      stock: 5,
    ),
    CarModel(
      id: 2,
      name: 'Mercedes-Benz G-Class',
      type: 'SUV',
      price: 4800000000,
      imageUrl:
          'https://images.unsplash.com/photo-1520031441872-265e4ff70366?w=800',
      description:
          'SUV ikonik dengan desain kotak legendaris dan performa off-road.',
      engine: '4.0L V8 Biturbo',
      topSpeed: '220 km/h',
      stock: 2,
    ),
    CarModel(
      id: 3,
      name: 'Mercedes-AMG GT',
      type: 'Sport',
      price: 5200000000,
      imageUrl:
          'https://images.unsplash.com/photo-1686556761699-67f1c9e4858b?q=80&w=1176&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      description: 'Mobil sport dengan performa tinggi dan desain aerodinamis.',
      engine: '4.0L V8 Biturbo',
      topSpeed: '318 km/h',
      stock: 1,
    ),
    CarModel(
      id: 4,
      name: 'Mercedes-Benz EQS',
      type: 'Electric',
      price: 3200000000,
      imageUrl:
          'https://images.unsplash.com/photo-1708903518664-ba5dd825de74?q=80&w=1331&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      description: 'Sedan listrik mewah dengan jangkauan jauh.',
      engine: 'Electric Motor',
      topSpeed: '210 km/h',
      stock: 3,
    ),
    CarModel(
      id: 5,
      name: 'Mercedes-Benz C-Class',
      type: 'Sedan',
      price: 1200000000,
      imageUrl:
          'https://images.unsplash.com/photo-1739644247038-adf09eccffe4?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      description: 'Sedan kompak dengan desain modern dan performa dinamis.',
      engine: '2.0L Turbo',
      topSpeed: '240 km/h',
      stock: 8,
    ),
    CarModel(
      id: 6,
      name: 'Mercedes-Benz GLE',
      type: 'SUV',
      price: 2100000000,
      imageUrl:
          'https://images.unsplash.com/photo-1732347700505-e1231e0f7c94?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      description: 'SUV premium dengan kenyamanan keluarga.',
      engine: '3.0L V6 Turbo',
      topSpeed: '230 km/h',
      stock: 4,
    ),
  ];

  // ===== GETTERS =====
  List<CarModel> get allCars => List.unmodifiable(_cars);

  List<CarModel> get favoriteCars => _cars.where((c) => c.isFavorite).toList();

  // ===== METHODS =====
  List<CarModel> getByType(String type) {
    if (type == 'Semua') return allCars;
    return _cars.where((c) => c.type == type).toList();
  }

  List<CarModel> search(String keyword) {
    return _cars
        .where(
          (c) =>
              c.name.toLowerCase().contains(keyword.toLowerCase()) ||
              c.type.toLowerCase().contains(keyword.toLowerCase()),
        )
        .toList();
  }

  CarModel? getById(int id) {
    try {
      return _cars.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  void toggleFavorite(int id) {
    final car = getById(id);
    car?.toggleFavorite();
  }
}

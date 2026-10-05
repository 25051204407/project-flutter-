import 'package:flutter/material.dart';

import '../models/car_model.dart';

class CarCard extends StatelessWidget {
  final CarModel car;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;

  const CarCard({
    super.key,
    required this.car,
    required this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.network(
                car.imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, Error, StackTrace) => Container(
                  width: 120,
                  height: 120,
                  color: Colors.black26,
                  child: const Icon(
                    Icons.directions_car,
                    color: Colors.white54,
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${car.type} • ${car.year}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      car.formattedPrice,
                      style: const TextStyle(
                        color: Color(0xFF00ADEF),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      car.availabilityStatus,
                      style: TextStyle(
                        color: car.stock > 0
                            ? Colors.greenAccent
                            : Colors.redAccent,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: onFavoriteTap,
              icon: Icon(
                car.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: car.isFavorite ? Colors.redAccent : Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

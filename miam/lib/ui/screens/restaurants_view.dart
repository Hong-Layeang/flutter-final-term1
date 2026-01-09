import 'package:flutter/material.dart';

import '../../models/restaurant.dart';
import '../../models/restaurant_type.dart';
import '../theme.dart';
import 'restaurant_comments_view.dart';

class RestaurantsView extends StatefulWidget {
  const RestaurantsView({super.key, required this.restaurants});

  final List<Restaurant> restaurants;

  @override
  State<RestaurantsView> createState() => _RestaurantsViewState();
}

class _RestaurantsViewState extends State<RestaurantsView> {
  bool _showOnlyKhmer = false;

  @override
  Widget build(BuildContext context) {
    List<Restaurant> displayedRestaurants = _showOnlyKhmer
        ? widget.restaurants.where((r) => r.type == RestaurantType.khmer).toList()
        : widget.restaurants;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.main,
        title: const Text('Miam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: _showOnlyKhmer,
                  onChanged: (value) {
                    setState(() {
                      _showOnlyKhmer = value ?? false;
                    });
                  },
                ),
                const Text('Show only Khmer restaurants'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: displayedRestaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = displayedRestaurants[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantCommentsView(
                            restaurant: restaurant,
                          ),
                        ),
                      ).then((_) => setState(() {}));
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name,
                              style: TextStyle(
                                fontSize: AppTexts.normal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 20),
                                    const SizedBox(width: 4),
                                    Text(
                                      restaurant.averageRate.toStringAsFixed(1),
                                      style: TextStyle(fontSize: AppTexts.small),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Chip(
                                  label: Text(
                                    restaurant.type.name.toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: restaurant.type.color,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget to disaply a restaurant type chips
import 'package:final_exam/models/restaurant_type.dart';
import 'package:flutter/material.dart';

class RestaurantTypeChip extends StatelessWidget {
  final RestaurantType restaurantType;
  final bool isSelected;
  final ValueChanged<bool>? onChanged;

  const RestaurantTypeChip({
    super.key,
    required this.restaurantType,
    this.isSelected = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(restaurantType.name),
      backgroundColor: isSelected ? restaurantType.color : Colors.grey,
    );
  }
}
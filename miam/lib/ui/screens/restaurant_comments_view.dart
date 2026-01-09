import 'package:flutter/material.dart';

import '../../models/restaurant.dart';
import '../theme.dart';
import 'restaurant_comments_form.dart';

class RestaurantCommentsView extends StatefulWidget {
  const RestaurantCommentsView({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  State<RestaurantCommentsView> createState() => _RestaurantCommentsViewState();
}

class _RestaurantCommentsViewState extends State<RestaurantCommentsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.main,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.main,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  widget.restaurant.name,
                  style: TextStyle(
                    fontSize: AppTexts.large,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.restaurant.address,
                  style: TextStyle(fontSize: AppTexts.small),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Chip(
                      label: Text(
                        widget.restaurant.type.name.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: widget.restaurant.type.color,
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            widget.restaurant.averageRate.toStringAsFixed(1),
                            style: TextStyle(fontSize: AppTexts.small),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.restaurant.comments.isEmpty
                ? const Center(
                    child: Text('No comments yet'),
                  )
                : ListView.builder(
                    itemCount: widget.restaurant.comments.length,
                    itemBuilder: (context, index) {
                      final comment = widget.restaurant.comments[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  comment.feedback,
                                  style: TextStyle(fontSize: AppTexts.normal),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Text(
                                  comment.stars.toString(),
                                  style: TextStyle(fontSize: AppTexts.small),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.main,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantCommentsForm(
                restaurant: widget.restaurant,
              ),
            ),
          ).then((_) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
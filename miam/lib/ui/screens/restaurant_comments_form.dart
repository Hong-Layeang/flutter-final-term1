import 'package:flutter/material.dart';

import '../../models/restaurant.dart';
import '../theme.dart';

class RestaurantCommentsForm extends StatefulWidget {
  const RestaurantCommentsForm({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  State<RestaurantCommentsForm> createState() => _RestaurantCommentsFormState();
}

class _RestaurantCommentsFormState extends State<RestaurantCommentsForm> {
  int _selectedStars = 0;
  final TextEditingController _feedbackController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitComment() {
    if (_feedbackController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Enter your feedback';
      });
      return;
    }

    widget.restaurant.addComment(
      RestaurantComment(
        stars: _selectedStars,
        feedback: _feedbackController.text.trim(),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.main,
            padding: const EdgeInsets.all(16),
            child: SafeArea(
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'How was your dinner?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    value: _selectedStars,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: List.generate(
                      6,
                      (index) => DropdownMenuItem(
                        value: index,
                        child: Text(index.toString()),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedStars = value ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _feedbackController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      labelText: 'Any feedback?',
                      labelStyle: TextStyle(
                        color: _errorMessage != null ? Colors.red : null,
                      ),
                      hintText: _errorMessage,
                      hintStyle: const TextStyle(color: Colors.red),
                      border: const OutlineInputBorder(),
                      errorBorder: _errorMessage != null
                          ? const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      if (_errorMessage != null && value.trim().isNotEmpty) {
                        setState(() {
                          _errorMessage = null;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitComment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Comment',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
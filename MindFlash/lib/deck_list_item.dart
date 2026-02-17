import 'package:flutter/material.dart';
import 'deck_model.dart';

class DeckListItem extends StatelessWidget {
  final Deck deck;
  final VoidCallback onDelete;

  const DeckListItem({
    super.key,
    required this.deck,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    String firstLetter =
        deck.name.isNotEmpty ? deck.name[0].toUpperCase() : '?';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                firstLetter,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deck.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  deck.subject,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5B4FE6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "${deck.cardCount} cards",
                    style: const TextStyle(
                      color: Color(0xFF5B4FE6),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete_outline, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
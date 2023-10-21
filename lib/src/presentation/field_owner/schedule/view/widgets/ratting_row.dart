import 'package:flutter/material.dart';

class RattingRow extends StatelessWidget {
  const RattingRow(
      {Key? key,
      required this.subTitle,
      required this.rating,})
      : super(key: key);

  final String subTitle;
  final double rating;

  List<Icon> _buildRateStars() {
    final items =
        List.generate(rating.toInt(), (index) => const Icon(Icons.star_rate,color: Colors.yellow, ));
    if (rating % 1 != 0) {
      items.add(const Icon(Icons.star_half_rounded, color: Colors.yellow,));
    }
    items.addAll(List.generate(
        5 - rating.ceil(), (index) => const Icon(Icons.star_outline_rounded, color: Colors.black54,)));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ..._buildRateStars(),
                const SizedBox(width: 2),
                Text('$rating de 5'),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    subTitle,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ],
    );
  }
}
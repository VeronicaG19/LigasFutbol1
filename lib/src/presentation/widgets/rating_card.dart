import 'package:flutter/material.dart';

class RatingCard extends StatelessWidget {
  const RatingCard(
      {Key? key,
      required this.title,
      this.subTitle,
      this.trailing,
      required this.rating,
      this.description})
      : super(key: key);

  final String title;
  final String? subTitle;
  final String? trailing;
  final double rating;
  final String? description;

  List<Icon> _buildRateStars() {
    final items = List.generate(
        rating.toInt(),
        (index) => const Icon(
              Icons.star_rate,
              color: Colors.amber,
            ));
    if (rating % 1 != 0) {
      items.add(const Icon(
        Icons.star_half_rounded,
        color: Colors.amber,
      ));
    }
    items.addAll(List.generate(
        5 - rating.ceil(),
        (index) => const Icon(
              Icons.star_outline_rounded,
              color: Colors.black38,
            )));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 25,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 12, 10, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  child: Container(
                    color: Colors.black54,
                    child: const Icon(
                      Icons.person,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    trailing ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: Colors.black38),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ..._buildRateStars(),
                const SizedBox(
                  width: 10,
                ),
                Text('$rating de 5',
                    style:
                        const TextStyle(fontSize: 13, color: Colors.black38)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subTitle ?? '',
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(description ?? 'Sin comentarios',
                  style: const TextStyle(fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class GeneralRatingCard extends StatelessWidget {
  const GeneralRatingCard(
      {Key? key,
      required this.title,
      required this.rating,
      this.author,
      required this.onPressed})
      : super(key: key);
  final String title;
  final double rating;
  final String? author;
  final VoidCallback onPressed;

  List<Icon> buildRateStars() {
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
      //  key: CoachKey.qualifyGeneralRating,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 8.0, 3.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 8.0, 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...buildRateStars(),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('${rating.toStringAsFixed(1)} de 5',
                          style: const TextStyle(
                              color: Colors.black38, fontSize: 13)),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 2.0, 8.0, 5.0),
                      child: Text(
                        author ?? '',
                        maxLines: 2,
                        style: const TextStyle(color: Colors.black38),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward, color: Colors.black38),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:learn_firebase/product_details.dart';
import 'package:learn_firebase/product_model.dart';

class FoundData extends StatelessWidget {
  final int count;
  final bool useBorder;
  final double borderWidth;
  final double borderRadius;
  final Color color;
  const FoundData({
    required this.useBorder,
    required this.borderWidth,
    required this.borderRadius,
    required this.count,
    required this.color,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      itemCount: count <= 10 && count >= 0 ? count : 0,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final taxiModel = productModels[index];
        return GestureDetector(
          onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductDetails(productModel: taxiModel, color: color))),
          child: Container(
            height: 280,
            decoration: BoxDecoration(
              color: const Color(0xffF0EFF4),
              border: useBorder ? Border.all(width: borderWidth) : null,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Column(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(taxiModel.imgUrl)
                      )
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(taxiModel.carModel,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(taxiModel.direction,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(taxiModel.price,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.visibility, color: Colors.grey,),
                            const SizedBox(width: 5),
                            Text(taxiModel.interests.toString()),
                            const Spacer(),
                            const Icon(CupertinoIcons.bookmark)
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_firebase/product_model.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel productModel;
  final Color color;
  const ProductDetails({
    required this.color,
    required this.productModel,
    super.key
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.productModel.imgUrl)
                      )
                  ),
                  child: Align(
                    alignment: const Alignment(0.9, 1.2),
                    child: Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5
                            )
                          ]
                      ),
                      child: const Icon(CupertinoIcons.bookmark),
                    ),
                  ),
                ),
                Container(
                  height: 48,
                  margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xffDFE1E7))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: ()=> Navigator.pop(context),
                          child: const Icon(CupertinoIcons.back)
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(widget.productModel.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.share)
                    ],
                  ),
                ),
              ],
            ),
            Container(
              color: widget.color.withOpacity(0.2),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.productModel.direction,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(widget.productModel.carModel,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(" ● Ovqatlanishga to'xtash mumkin${widget.productModel.nonSmokingDriver ? '' : ' emas'}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(widget.productModel.nonSmokingDriver ? " ● Chekmaydigan haydovchi" : " ● Chekadigan haydovchi",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(widget.productModel.negotiable ? " ● Narxni savdolashish mumkin" : " ● Narx o'zgartirilmaydi",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(" ● To'lov turi: ${paymentType(widget.productModel.paymentType)}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  const Text('TAVSIF',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(widget.productModel.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(widget.productModel.price,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      const Icon(Icons.visibility, color: Colors.grey,),
                      const SizedBox(width: 5),
                      Text(widget.productModel.interests.toString()),
                      const SizedBox(width: 5),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 15, left: 20, right: 20),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              height: 60,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Text("Bo'glanish",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }

  String paymentType(PaymentType paymentType){
    switch(paymentType.name){
      case 'cash': return "Naxt";
      case 'card': return "Karta";
      case 'cashOrCard': return "Naxt yoki karta";
      default: return "Aniqlanmagan";
    }
  }
}

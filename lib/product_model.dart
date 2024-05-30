class ProductModel {
  String fullName;
  String imgUrl;
  String carModel;
  String direction;
  String price;
  String description;
  String phoneNumber;
  String? telegramUsername;
  bool negotiable;
  bool nonSmokingDriver;
  bool canStopForMeal;
  PaymentType paymentType;
  int interests;
  List<String> tags;

  ProductModel({
    required this.fullName,
    required this.imgUrl,
    required this.carModel,
    required this.direction,
    required this.price,
    required this.description,
    required this.phoneNumber,
    this.telegramUsername,
    required this.negotiable,
    required this.nonSmokingDriver,
    required this.canStopForMeal,
    required this.paymentType,
    required this.interests,
    required this.tags
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        fullName: json["fullName"] as String,
        imgUrl: json["imgUrl"] as String,
        carModel: json["carModel"] as String,
        direction: json["direction"] as String,
        price: json["price"] as String,
        description: json["description"] as String,
        phoneNumber: json["phoneNumber"] as String,
        telegramUsername: json["telegramUsername"] == null ? null : json["telegramUsername"] as String,
        negotiable: json["negotiable"] as bool,
        nonSmokingDriver: json["nonSmokingDriver"] as bool,
        canStopForMeal: json["canStopForMeal"] as bool,
        paymentType: json["paymentType"] as PaymentType,
        interests: json["interests"] as int,
        tags: List<String>.from(json["tags"].map((tag) => tag.toString()))
    );
  }

  Map<String, dynamic> get toJson => {
    "fullName": fullName,
    "imgUrl": imgUrl,
    "carModel": carModel,
    "direction": direction,
    "price": price,
    "description": description,
    "phoneNumber": phoneNumber,
    if(telegramUsername != null) "telegramUsername": telegramUsername,
    "negotiable": negotiable,
    "nonSmokingDriver": nonSmokingDriver,
    "canStopForMeal": canStopForMeal,
    "paymentType": paymentType,
    "interests": interests,
    "tags": tags
  };
}

enum PaymentType {
  cash,
  card,
  cashOrCard
}

List<ProductModel> productModels = [
  ProductModel(
      fullName: 'Elmurod Haqnazarov',
      imgUrl: 'https://w.forfun.com/fetch/2e/2e52a0e68baccb396e81a688bb52be01.jpeg?w=2200',
      carModel: 'Cobalt',
      direction: "Bag'dod Toshkent",
      price: "120 000  so'm",
      description: "Bag'dod Toshkent yo'nalishi bo'yicha yuramiz. +998 91 688 44 60. Bag'dod Toshkent yo'nalishi bo'yicha yuramiz. +998 91 688 44 60. Bag'dod Toshkent yo'nalishi bo'yicha yuramiz. +998 91 688 44 60. ",
      phoneNumber: '+998(91) 688-44-60',
      telegramUsername: 'https://t.me/diyorbekqurbonov',
      negotiable: true,
      nonSmokingDriver: true,
      canStopForMeal: true,
      paymentType: PaymentType.cashOrCard,
      interests: 36578,
      tags: []
  ),
  ProductModel(
      fullName: 'Elon Musk',
      imgUrl: 'https://w.forfun.com/fetch/2e/2e52a0e68baccb396e81a688bb52be01.jpeg?w=2200',
      carModel: 'Nexia 3',
      direction: "Rishton Toshkent",
      price: "125 000  so'm",
      description: "Rishton Toshkent yo'nalishi bo'yicha qatnaymiz",
      phoneNumber: '+998 91 688 44 60',
      negotiable: false,
      nonSmokingDriver: false,
      canStopForMeal: false,
      paymentType: PaymentType.card,
      interests: 78528,
      tags: []
  ),
  ProductModel(
      fullName: 'Jahongir Poziljonuv',
      imgUrl: 'https://w.forfun.com/fetch/2e/2e52a0e68baccb396e81a688bb52be01.jpeg?w=2200',
      carModel: 'Cobalt',
      direction: "Andjon shahri",
      price: "100 000  so'm",
      description: "Andjon Toshkent yo'nalishi bo'yicha qatnaymiz",
      phoneNumber: '+998 91 688 44 60',
      negotiable: true,
      nonSmokingDriver: true,
      canStopForMeal: true,
      paymentType: PaymentType.cash,
      interests: 23487,
      tags: []
  ),
  ProductModel(
      fullName: 'Stiv Jobs',
      imgUrl: 'https://w.forfun.com/fetch/2e/2e52a0e68baccb396e81a688bb52be01.jpeg?w=2200',
      carModel: 'Spark',
      direction: "Farg'ona Toshkent",
      price: "150 000  so'm",
      description: "Farg'ona Toshkent yo'nalishi bo'yicha qatnaymiz",
      phoneNumber: '+998 91 688 44 60',
      negotiable: true,
      nonSmokingDriver: true,
      canStopForMeal: false,
      paymentType: PaymentType.cashOrCard,
      interests: 36629,
      tags: []
  ),
  ProductModel(
      fullName: 'Artur Pendragon',
      imgUrl: 'https://w.forfun.com/fetch/2e/2e52a0e68baccb396e81a688bb52be01.jpeg?w=2200',
      carModel: 'Gentra',
      direction: "Samarqand Toshkent",
      price: "132 000  so'm",
      description: "Samarqand Toshkent yo'nalishi bo'yicha qatnaymiz",
      phoneNumber: '+998 91 688 44 60',
      negotiable: true,
      nonSmokingDriver: true,
      canStopForMeal: true,
      paymentType: PaymentType.cashOrCard,
      interests: 128749,
      tags: []
  ),
  ProductModel(
      fullName: 'Erik Xaydar',
      imgUrl: 'https://w.forfun.com/fetch/2e/2e52a0e68baccb396e81a688bb52be01.jpeg?w=2200',
      carModel: 'Lasetti',
      direction: "Navoi Toshkent",
      price: "200 000  so'm",
      description: "Navoi Toshkent yo'nalishi bo'yicha qatnaymiz",
      phoneNumber: '+998 91 688 44 60',
      negotiable: false,
      nonSmokingDriver: true,
      canStopForMeal: true,
      paymentType: PaymentType.cash,
      interests: 578,
      tags: []
  ),
  ProductModel(
      fullName: 'Bobur Mansuruv',
      imgUrl: 'https://w.forfun.com/fetch/2e/2e52a0e68baccb396e81a688bb52be01.jpeg?w=2200',
      carModel: 'Cobalt',
      direction: "Navoiy Toshkent",
      price: "220 000  so'm",
      description: "Navoiy Toshkent yo'nalishi bo'yicha qatnaymiz",
      phoneNumber: '+998 91 688 44 60',
      negotiable: true,
      nonSmokingDriver: true,
      canStopForMeal: true,
      paymentType: PaymentType.cashOrCard,
      interests: 82564,
      tags: []
  ),
  ProductModel(
      fullName: 'Shukurullo Isroilov',
      imgUrl: 'https://w.forfun.com/fetch/2e/2e52a0e68baccb396e81a688bb52be01.jpeg?w=2200',
      carModel: 'Gentra',
      direction: "Bag'dod Toshkent",
      price: "Narx kelishiladi",
      description: "Bag'dod Toshkent yo'nalishi bo'yicha qatnaymiz",
      phoneNumber: '+998 91 688 44 60',
      negotiable: false,
      nonSmokingDriver: true,
      canStopForMeal: true,
      paymentType: PaymentType.cashOrCard,
      interests: 27845,
      tags: []
  ),
  ProductModel(
      fullName: 'Mirzobek Xolmadov',
      imgUrl: 'https://w.forfun.com/fetch/2e/2e52a0e68baccb396e81a688bb52be01.jpeg?w=2200',
      carModel: 'Nexi 3',
      direction: "Namangan Toshkent",
      price: "100 000  so'm",
      description: "Namangan Toshkent yo'nalishi bo'yicha qatnaymiz",
      phoneNumber: '+998 91 688 44 60',
      negotiable: true,
      nonSmokingDriver: true,
      canStopForMeal: true,
      paymentType: PaymentType.cashOrCard,
      interests: 97845,
      tags: []
  ),
  ProductModel(
      fullName: 'Dileme',
      imgUrl: 'https://w.forfun.com/fetch/2e/2e52a0e68baccb396e81a688bb52be01.jpeg?w=2200',
      carModel: 'Nexi 3',
      direction: "Bag'dod Toshkent",
      price: "100 000  so'm",
      description: "Bag'dod Toshkent yo'nalishi bo'yicha qatnaymiz",
      phoneNumber: '+998 91 688 44 60',
      negotiable: true,
      nonSmokingDriver: true,
      canStopForMeal: true,
      paymentType: PaymentType.cashOrCard,
      interests: 47585,
      tags: []
  ),
];

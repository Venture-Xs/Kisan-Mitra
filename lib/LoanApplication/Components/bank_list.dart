//Dummy Data for Banks

class Bank {
  final int bankId;
  final String name;
  final double rating;
  final String imageURL;
  final String decription;

  Bank({
    required this.bankId,
    required this.name,
    required this.rating,
    required this.imageURL,
    required this.decription,
  });

  //List of Banks data
  static List<Bank> indianBanks = [
    Bank(
      bankId: 1,
      name: "South Indian Bank",
      rating: 4.5,
      imageURL: "assets/images/bankLogos/south_logo.png",
      decription:
          "A leading private sector bank with a legacy of customer trust and financial excellence.",
    ),
    Bank(
      bankId: 2,
      name: "State Bank of India",
      rating: 4.7,
      imageURL: "assets/images/bankLogos/sbi_logo.png",
      decription:
          "The largest public sector bank in India, providing a wide range of financial services.",
    ),
    Bank(
      bankId: 3,
      name: "HDFC Bank",
      rating: 4.6,
      imageURL: "assets/images/bankLogos/hdfc_logo.png",
      decription:
          "A leading private sector bank known for its customer-centric approach and innovative services.",
    ),
    Bank(
      bankId: 4,
      name: "ICICI Bank",
      rating: 4.5,
      imageURL: "assets/images/bankLogos/icici.png",
      decription:
          "A major private sector bank offering a diverse range of banking and financial solutions.",
    ),
    Bank(
      bankId: 5,
      name: "Punjab National Bank",
      rating: 4.2,
      imageURL: "assets/images/bankLogos/pnb_logo.png",
      decription:
          "A prominent public sector bank with a long-standing history of serving customers across India.",
    ),
  ];
}

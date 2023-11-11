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
  List<Bank> indianBanks = [
    Bank(
      bankId: 1,
      name: "State Bank of India",
      rating: 4.7,
      imageURL: "https://example.com/sbi_logo.png",
      decription:
          "The largest public sector bank in India, providing a wide range of financial services.",
    ),
    Bank(
      bankId: 2,
      name: "HDFC Bank",
      rating: 4.6,
      imageURL: "https://example.com/hdfc_logo.png",
      decription:
          "A leading private sector bank known for its customer-centric approach and innovative services.",
    ),
    Bank(
      bankId: 3,
      name: "ICICI Bank",
      rating: 4.5,
      imageURL: "https://example.com/icici_logo.png",
      decription:
          "A major private sector bank offering a diverse range of banking and financial solutions.",
    ),
    Bank(
      bankId: 4,
      name: "Punjab National Bank",
      rating: 4.2,
      imageURL: "https://example.com/pnb_logo.png",
      decription:
          "A prominent public sector bank with a long-standing history of serving customers across India.",
    ),
    Bank(
      bankId: 5,
      name: "Axis Bank",
      rating: 4.4,
      imageURL: "https://example.com/axis_logo.png",
      decription:
          "A private sector bank known for its technology-driven services and customer-friendly approach.",
    ),
  ];
}

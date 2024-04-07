class Vegitables {
  final String name;
  final String price;
  final String image;
  final String des;
  final String pergram;
  final String country;
  Vegitables({
    this.des = 'Lettuce is an annual plant of the daisy',
    this.pergram = '~ 150 gr / piece',
    this.country = 'Spain',
    required this.name,
    required this.price,
    required this.image,
  });
}

final List<String> filter = [
  'Cabbage and lettuce (14)',
  'Cucumbers and tomato (2)',
  'Onions and garlic (8)',
  'Peppers (7)'
];
List<Vegitables> veg = [
  Vegitables(
      name: 'Boston Lettuce', price: '1.10 ', image: 'assets/images/img1.png'),
  Vegitables(
      name: 'Purple Cauliflower 1.85',
      price: '1.10',
      image: 'assets/images/img2.png'),
  Vegitables(
      name: 'Savoy Cabbage', price: '1.45', image: 'assets/images/img3.png')
];

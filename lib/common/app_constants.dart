enum AppEnumImageSearchTerms {
  yellowFlowers(title: 'Yellow Flowers', value: 'yellow+flowers'),
  redRoses(title: 'Red Roses', value: 'red+roses'),
  sunflowers(title: 'Sunflowers', value: 'sunflowers'),
  tulipFlowers(title: 'Tulip Flowers', value: 'tulip+flowers'),
  lavenderFlowers(title: 'Lavender Flowers', value: 'lavender+flowers');

  final String title;
  final String value;

  const AppEnumImageSearchTerms({required this.title, required this.value});
}

class Category {
  final String name;
  final String image;

  Category(this.name, this.image);
}

List<Category> categories = categoriesData
    .map((item) => Category(item['name'], item['image']))
    .toList();

var categoriesData = [
  {"name": "Computer Networks", 'image': "images/computer_networking.jpg"},
  {"name": "Operating Systems", 'image': "images/OS.jfif"},
  {"name": "Python", 'image': "images/Python.jfif"},
  {"name": "AWS", 'image': "images/AWS.jfif"},
];

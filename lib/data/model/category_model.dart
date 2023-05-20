class CategoryModel{
  final int categoryId;
  final String categoryName;
  final String categoryImage;
  CategoryModel({required this.categoryId,required this.categoryName,required this.categoryImage});
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['id'].toInt(),
      categoryName: json['name'],
      categoryImage: json['cover'],
    );
  }
}
class SupCategoryModel{
  final int supCategoryId;
  final String categoryId;
  final String categoryName;
  final String categoryImage;
  SupCategoryModel({required this.supCategoryId,required this.categoryId,required this.categoryName,required this.categoryImage});
  factory SupCategoryModel.fromJson(Map<String, dynamic> json) {
    return SupCategoryModel(
      supCategoryId: json['id'],
      categoryId: json['category_id'],
      categoryName: json['name'],
      categoryImage: json['cover'],
    );
  }
}
import 'package:hive/hive.dart';
part 'favModel.g.dart';

@HiveType(typeId: 1)
class FavourModel extends HiveObject{
  
  @HiveField(0)
  int? id;
  
  FavourModel({required this.id});
}
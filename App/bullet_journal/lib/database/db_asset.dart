// @dart=2.9
import 'package:hive/hive.dart';
part 'db_asset.g.dart';

@HiveType(typeId: 8)
class AssetDB extends HiveObject {
  @HiveField(0)
  String identifier;
  @HiveField(1)
  String name;
  @HiveField(2)
  int originalWidth;
  @HiveField(3)
  int originalHeight;

  AssetDB(
    this.identifier,
    this.name,
    this.originalWidth,
    this.originalHeight,
  );
}

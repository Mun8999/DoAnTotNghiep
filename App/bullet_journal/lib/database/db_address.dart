// @dart=2.9
import 'package:bullet_journal/database/db_component.dart';
import 'package:hive/hive.dart';
part 'db_address.g.dart';

@HiveType(typeId: 4)
class AddressDB extends ComponentDB {
  @HiveField(6)
  String address;
  AddressDB(String address, double offset_dx, double offset_dy,
      double size_width, double size_height, double opacity)
      : super(offset_dx, offset_dy, size_width, size_height, opacity) {
    this.address = address;
  }
}

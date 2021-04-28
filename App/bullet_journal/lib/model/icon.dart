class MyIcon {
  String? id;
  late String name;
  late String path;
  MyIcon(id, name, path) {
    this.id = id;
    this.name = name;
    this.path = path;
  }
  @override
  String toString() {
    return this.name + this.path;
  }
}

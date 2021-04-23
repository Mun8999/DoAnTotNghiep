class MyIcon {
  String id;
  String name;
  String path;
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

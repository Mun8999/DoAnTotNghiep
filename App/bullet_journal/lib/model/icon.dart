class MyIcon {
  String name;
  String path;
  MyIcon(name, path) {
    this.name = name;
    this.path = path;
  }
  @override
  String toString() {
    return this.name + this.path;
  }
}

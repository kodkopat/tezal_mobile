extension IsNumeric on String {
  bool isNumeric() {
    if (this.isEmpty) return false;
    return double.tryParse(this) != null;
  }
}

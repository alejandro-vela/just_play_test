extension StringCapitalization on String {
  String capitalize() {
    return split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

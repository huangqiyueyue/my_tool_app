extension StringExtension on String {
  bool get isNullOrEmpty => trim().isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

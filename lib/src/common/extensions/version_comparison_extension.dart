extension VersionComparison on String {
  /// Verilen diğer bir versiyonla bu versiyonu karşılaştırır.
  /// -1: Küçük
  ///  0: Eşit
  ///  1: Büyük
  int compareToVersion(String otherVersion) {
    final thisParts = split('.').map(int.tryParse).toList();
    final otherParts = otherVersion.split('.').map(int.tryParse).toList();
    final maxLength = thisParts.length > otherParts.length ? thisParts.length : otherParts.length;

    for (var i = 0; i < maxLength; i++) {
      final thisPart = thisParts.length > i ? (thisParts[i] ?? 0) : 0;
      final otherPart = otherParts.length > i ? (otherParts[i] ?? 0) : 0;

      if (thisPart > otherPart) return 1;
      if (thisPart < otherPart) return -1;
    }
    return 0;
  }

  /// Belirtilen diğer versiyondan büyük olup olmadığını kontrol eder.
  bool isGreaterThan(String otherVersion) => compareToVersion(otherVersion) > 0;

  /// Belirtilen diğer versiyondan küçük olup olmadığını kontrol eder.
  bool isLessThan(String otherVersion) => compareToVersion(otherVersion) < 0;

  /// Belirtilen diğer versiyona eşit olup olmadığını kontrol eder.
  bool isEqualTo(String otherVersion) => compareToVersion(otherVersion) == 0;
}

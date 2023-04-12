class LFAppFailure {
  final String code;
  final String errorMessage;
  final String? data;

  const LFAppFailure({
    required this.code,
    required this.errorMessage,
    this.data,
  });
}

part of 'external_link_cubit.dart';

@immutable
abstract class ExternalLinkState {}

class ExternalLinkInitial extends ExternalLinkState {}

class ExternalLinkLoaded extends ExternalLinkState {}

class ExternalLinkLoadError extends ExternalLinkState {}

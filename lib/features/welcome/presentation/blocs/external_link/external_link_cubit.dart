import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'external_link_state.dart';

class ExternalLinkCubit extends Cubit<ExternalLinkState> {
  ExternalLinkCubit() : super(ExternalLinkInitial());

  Future<void> openWebPage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      emit(ExternalLinkLoadError());
    }
  }
}

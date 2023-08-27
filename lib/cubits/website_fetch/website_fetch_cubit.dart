import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'website_fetch_state.dart';

class WebsiteFetchCubit extends Cubit<WebsiteFetchState> {
  WebsiteFetchCubit() : super(WebsiteFetchInitial());
}

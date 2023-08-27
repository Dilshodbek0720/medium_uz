import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'website_add_state.dart';

class WebsiteAddCubit extends Cubit<WebsiteAddState> {
  WebsiteAddCubit() : super(WebsiteAddInitial());
}

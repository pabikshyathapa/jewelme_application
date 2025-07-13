import 'package:bloc_test/bloc_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_state.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_view_model.dart';

class MockRegisterBloc extends MockBloc<RegisterEvent, RegisterState>
implements RegisterViewModel {}

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockRegisterBloc registerBloc;
}
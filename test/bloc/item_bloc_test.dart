import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moostamil/blocs/upload/upload_bloc.dart';
import 'package:moostamil/utils/paths.dart';

class MockItemBloc extends Mock implements UploadBloc {}

void main() async {
  const channel = MethodChannel('plugins.flutter.io/path_provider');
  // ignore: cascade_invocations
  channel.setMockMethodCallHandler((MethodCall methodCall) async => '.');

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  late MockItemBloc mockItemBloc;

  final instance = FakeFirebaseFirestore();
  final data = <String, dynamic>{'title': 'brand new iPhone'};

  // await instance.collection(Paths.uploads).add(data);

  // final snapshot = await instance.collection(Paths.uploads).get();

  setUp(() {
    mockItemBloc = MockItemBloc();
  });

  tearDown(() {
    mockItemBloc.close();
  });

  test('Add item to firestore', () async {
    await instance.collection(Paths.uploads).add(data);
  });
}

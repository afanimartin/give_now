import 'package:flutter_test/flutter_test.dart';

import '../mocks/bloc/upload_bloc_mock.dart';
import '../mocks/bloc/upload_state_mock.dart';

void main() {
  UploadBlocMock? uploadBlocMock;
  UploadStateMock? uploadStateMock;

  setUp(() {
    uploadBlocMock = UploadBlocMock();
    uploadStateMock = const UploadStateMock();
  });

  tearDown(() {
    uploadBlocMock?.close();
  });

  test('title state is pure', () {
    expect(uploadStateMock?.title.pure, true);
    expect(uploadStateMock?.title.value, '');
  });
}

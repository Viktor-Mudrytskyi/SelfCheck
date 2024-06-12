import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:self_check/core/failures/firestore_failure.dart';
import 'package:self_check/core/wrappers/response_wrapper.dart';
import 'package:self_check/data/folders/models/folder_model.dart';
import 'package:self_check/data/words/model/word_model.dart';

final class FirestoreManager {
  const FirestoreManager({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _userCollection =>
      _firestore.collection('users');

  DocumentReference<Map<String, dynamic>> _userDoc(String uid) =>
      _userCollection.doc(uid);

  CollectionReference<Map<String, dynamic>> _foldersCollection(String uid) =>
      _userDoc(uid).collection('folders');

  CollectionReference<Map<String, dynamic>> _wordsCollection(String uid) =>
      _userDoc(uid).collection('words');

  Future<ApiResponse<void, FirestoreFailure>> createFolder({
    required String uid,
    required FolderModel folderModel,
  }) async {
    try {
      await _foldersCollection(uid).add(folderModel.toJson());

      return const ApiResponse.success(null);
    } on FirebaseException catch (e) {
      return ApiResponse.failure(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return ApiResponse.failure(UnknownFirestoreFailure());
    }
  }

  Future<ApiResponse<void, FirestoreFailure>> createWord({
    required String uid,
    required WordModel wordModel,
  }) async {
    try {
      await _wordsCollection(uid).add(wordModel.toJson());

      return const ApiResponse.success(null);
    } on FirebaseException catch (e) {
      return ApiResponse.failure(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return ApiResponse.failure(UnknownFirestoreFailure());
    }
  }

  Future<ApiResponse<void, FirestoreFailure>> editWord({
    required String uid,
    required WordModel wordModel,
  }) async {
    try {
      await _wordsCollection(uid).doc(wordModel.uid).set(wordModel.toJson());

      return const ApiResponse.success(null);
    } on FirebaseException catch (e) {
      return ApiResponse.failure(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return ApiResponse.failure(UnknownFirestoreFailure());
    }
  }

  Future<ApiResponse<void, FirestoreFailure>> deleteWord({
    required String uid,
    required WordModel wordModel,
  }) async {
    try {
      await _wordsCollection(uid).doc(wordModel.uid).delete();
      return const ApiResponse.success(null);
    } on FirebaseException catch (e) {
      return ApiResponse.failure(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return ApiResponse.failure(UnknownFirestoreFailure());
    }
  }

  Future<ApiResponse<List<WordModel>, FirestoreFailure>> getWords({
    required String uid,
  }) async {
    try {
      final docRefs = await _wordsCollection(uid).get();
      final mappedList = docRefs.docs
          .map(
            (e) => WordModel.fromJson(
              {
                ...e.data(),
                'uid': _getLastPathSegment(e.reference.path),
              },
            ),
          )
          .toList();
      return ApiResponse.success(mappedList);
    } on FirebaseException catch (e) {
      return ApiResponse.failure(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return ApiResponse.failure(UnknownFirestoreFailure());
    }
  }

  String _getLastPathSegment(String path) {
    final lastIndexSeparator = path.lastIndexOf('/') + 1;
    if (path.length < lastIndexSeparator) {
      return '';
    }
    return path.substring(path.lastIndexOf('/') + 1);
  }
}

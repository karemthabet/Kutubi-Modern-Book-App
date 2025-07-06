import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/domain/usecases/fetch_featured_books_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'featured_books_state.dart';

/// ✅ Cubit مسؤول عن تحميل وعرض الكتب المميزة (Featured Books)
class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit({required this.fetchFeaturedBooksUsecase})
      : super(FeaturedBooksInitial());

  /// 🧠 نداء لحالة الـ usecase لجلب الكتب
  final FetchFeaturedBooksUsecase fetchFeaturedBooksUsecase;

  /// ✅ بنخزن كل الكتب اللي تم تحميلها (حتى نستخدمهم في pagination)
  List<BookEntity> books = [];

  /// ✅ لتحديد هل في صفحات تانية نقدر نحمّلها ولا لأ
  bool hasMoreData = true;

  /// 📦 دالة لجلب الكتب، سواء أول مرة أو مع التحميل التدريجي (pagination)
  Future<void> getFeaturedBooks({int pageNumber = 0}) async {
    // ✅ أول تحميل (الصفحة 0) = نعرض spinner عادي
    if (pageNumber == 0) {
      emit(FeaturedBooksLoading());
    } else {
      // ✅ تحميل صفحة جديدة (pagination) = نعرض spinner أسفل الكتب القديمة
      emit(FeaturedBooksPaginationLoading(oldBooks: books));
    }

    // ⏳ نطلب البيانات من الـ usecase
    final result = await fetchFeaturedBooksUsecase.call(pageNumber);

    // 🧪 نتعامل مع النتيجة سواء فشل أو نجاح
    result.fold(
      // ❌ لو فيه فشل
      (failure) {
        if (pageNumber == 0) {
          // ❌ فشل في أول تحميل
          emit(FeaturedBooksFailure(errMessage: failure.errMessage));
        } else {
          // ❌ فشل أثناء pagination
          emit(FeaturedBooksPaginationFailure(
            oldBooks: books,
            errMessage: failure.errMessage,
          ));
        }
      },

      // ✅ لو نجح تحميل الكتب
      (newBooks) {
        // 🟡 لو عدد الكتب أقل من 10، نعتبر إنه مفيش صفحات تانية
        if (newBooks.length < 10) hasMoreData = false;

        // ✅ نضيف الكتب الجديدة على اللي قبلها
        books.addAll(newBooks);

        // 🔄 نبعث الحالة الجديدة بالكتب المحدثة
        emit(FeaturedBooksSuccess(books: books, hasMoreData: hasMoreData));
      },
    );
  }
}

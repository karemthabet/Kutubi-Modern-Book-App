import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/domain/usecases/fetch_featured_books_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'featured_books_state.dart';

/// ✅ Cubit مسؤول عن تحميل الكتب المميزة (Featured Books) مع دعم التحميل التدريجي (pagination)
class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit({required this.fetchFeaturedBooksUsecase})
      : super(FeaturedBooksInitial());

  /// نداء للـ usecase المسؤول عن تحميل البيانات من الـ repository
  final FetchFeaturedBooksUsecase fetchFeaturedBooksUsecase;

  /// بنخزن كل الكتب المحمّلة
  List<BookEntity> books = [];

  /// هل فيه بيانات إضافية نقدر نحملها؟ (pagination)
  bool hasMoreData = true;

  /// صفحة البيانات الحالية (بتبدأ من 0)
  int currentPage = 0;

  /// هل في عملية تحميل شغالة حاليًا؟ (عشان ما نبعّتش طلبين في نفس الوقت)
  bool isLoading = false;

  /// 📦 تحميل الكتب
  Future<void> getFeaturedBooks() async {
    // ✅ نحمي من إرسال ريكويست جديد أثناء تحميل أو لما مفيش صفحات تانية
    if (isLoading || !hasMoreData) return;

    isLoading = true;

    // 👇 لو أول صفحة، نبعث حالة تحميل عادي
    if (currentPage == 0) {
      emit(FeaturedBooksLoading());
    } else {
      // 👇 لو بنحمّل صفحة تانية (pagination)، نبعث حالة تحميل جزئي
      emit(FeaturedBooksPaginationLoading(oldBooks: books));
    }

    // ⏳ نطلب الكتب من الـ usecase
    final result = await fetchFeaturedBooksUsecase.call(currentPage);

    result.fold(
      // ❌ لو فشل
      (failure) {
        isLoading = false;
        if (currentPage == 0) {
          emit(FeaturedBooksFailure(errMessage: failure.errMessage));
        } else {
          emit(FeaturedBooksPaginationFailure(
            oldBooks: books,
            errMessage: failure.errMessage,
          ));
        }
      },

      // ✅ لو نجح تحميل الصفحة
      (newBooks) {
        books.addAll(newBooks);

        // ✅ لو عدد الكتب الجديدة أقل من 10، يبقى مفيش صفحات تانية
        if (newBooks.length < 10) hasMoreData = false;

        currentPage++; // نزود رقم الصفحة
        isLoading = false;

        // ✅ نبعث الحالة النهائية بالكتب المجمعة
        emit(FeaturedBooksSuccess(books: books, hasMoreData: hasMoreData));
      },
    );
  }
}

part of 'featured_books_cubit.dart';

/// ✅ دي الـ abstract class الأساسية اللي كل الحالات هتورث منها.
/// بنستخدم `sealed class` عشان نضمن إن الحالات تكون مغلقة ومحددة بس داخل هذا الملف.
sealed class FeaturedBooksState {}

/// ✅ أول حالة (initial): بتتستخدم لما يكون الـ Cubit لسه متعملهوش أي تحميل.
final class FeaturedBooksInitial extends FeaturedBooksState {}

/// ✅ حالة تحميل أولية: بتستخدم لما نبدأ نحمّل أول مجموعة من الكتب (الصفحة الأولى).
final class FeaturedBooksLoading extends FeaturedBooksState {}

/// ✅ حالة النجاح:
/// لما يتم تحميل الكتب بنجاح سواء أول مرة أو مع pagination.
/// - [books]: قائمة الكتب اللي اتحمّلت.
/// - [hasMoreData]: بتقولنا لو لسه فيه كتب تانية نقدر نجيبها (صفحات تانية).
final class FeaturedBooksSuccess extends FeaturedBooksState {
  final List<BookEntity> books;
  final bool hasMoreData;

  FeaturedBooksSuccess({required this.books, required this.hasMoreData});
}

/// ❌ حالة الفشل:
/// لو حصل فشل أثناء تحميل أول دفعة من الكتب.
/// - [errMessage]: رسالة الخطأ اللي ممكن نعرضها للمستخدم.
final class FeaturedBooksFailure extends FeaturedBooksState {
  final String errMessage;

  FeaturedBooksFailure({required this.errMessage});
}

/// ✅ حالة تحميل صفحة جديدة (pagination):
/// بنستخدمها لما نكون بنحمّل صفحة تانية أو بعدها.
/// - [oldBooks]: الكتب اللي اتحمّلت قبل كدا، وهنعرضها لحد ما الصفحة الجديدة تخلص تحميل.
final class FeaturedBooksPaginationLoading extends FeaturedBooksState {
  final List<BookEntity> oldBooks;

  FeaturedBooksPaginationLoading({required this.oldBooks});
}

/// ❌ حالة فشل أثناء تحميل صفحة جديدة (pagination):
/// - [oldBooks]: الكتب القديمة اللي لسه عندنا.
/// - [errMessage]: رسالة الخطأ اللي حصلت.
final class FeaturedBooksPaginationFailure extends FeaturedBooksState {
  final List<BookEntity> oldBooks;
  final String errMessage;

  FeaturedBooksPaginationFailure({
    required this.oldBooks,
    required this.errMessage,
  });
}

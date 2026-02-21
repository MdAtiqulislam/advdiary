import 'package:advdiary/app/routes/app_pages.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:get/get.dart';
import '../../bookDetails/controllers/book_details_controller.dart';
import '../models/books_model.dart';

enum BookLevel { books, chapters, subchapters }

class BooksController extends GetxController {
  var isLoading=false.obs;

  var level = BookLevel.books.obs;

  var books = <Book>[].obs;
  var selectedChapters = <Chapter>[].obs;
  var selectedSubChapters = <SubChapter>[].obs;

  var currentTitle = "Books".obs;


  void getBooks()async {
    isLoading.value=true;
    selectedChapters.value=[];
    selectedSubChapters.value=[];
    var endPoint=APIEndPoints.getBooks;
    try {
      var res=await RemoteServices.getRequest(endPoint: endPoint);
      if(res!=null){
        BooksModel booksModel=BooksModel.fromJson(res);
        books.value=booksModel.data??[];
      }
    } finally {
      isLoading.value=false;
    }
  }

  void openChapters(Book book) {

      selectedChapters.value = book.chapters??[];
      level.value = BookLevel.chapters;
      currentTitle.value = book.heading??"";

  }

  void openSubChapters(Chapter chapter) {
    if ((chapter.subchapters??[]).isEmpty) {
      Get.put(BookDetailsController()).title.value=chapter.title??"";
      Get.find<BookDetailsController>().initialUrl=chapter.urlLink??"";
      Get.toNamed(Routes.BOOK_DETAILS);
    } else {
      selectedSubChapters.value = chapter.subchapters??[];
      level.value = BookLevel.subchapters;
      currentTitle.value = chapter.title??"";
    }
  }

  void goBack() {
    if (level.value == BookLevel.subchapters) {
      level.value = BookLevel.chapters;
    } else if (level.value == BookLevel.chapters) {
      level.value = BookLevel.books;
    } else {
      Get.back();
    }
  }
}

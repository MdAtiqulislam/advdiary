import 'package:advdiary/app/modules/notes/models/notes_model.dart';
import 'package:advdiary/common_widgets/custom_snackbar.dart';

import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:get/get.dart';
import '../../../../models/pagination_model.dart';

class NotesController extends GetxController {

  var isLoading=false.obs;
  var isReLoading=false.obs;
  var isLoadingMore=false.obs;
  var notes=<SingleNote>[].obs;
  var pagination=Pagination().obs;


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getNotes({bool showReloading=false})async{
    showReloading?isReLoading.value:isLoading.value=true;
    var endPoint=APIEndPoints.getNotes;
    try {
      var res=await RemoteServices.getRequest(endPoint: endPoint);
      if(res!=null){

        print(res);
        NotesModel notesModel=NotesModel.fromJson(res);
        notes.value=notesModel.data??[];
        pagination.value=notesModel.pagination??Pagination();
      }
    } finally {
      isLoading.value=false;
      isReLoading.value=false;
    }
  }

  void loadMore({required String url})async{
    isLoadingMore.value=true;
    try {
      await RemoteServices.getRequestLoadMore(url: url).then((value){
        if(value!=null){
          NotesModel notesModel=NotesModel.fromJson(value);
          notes.value+=notesModel.data??[];
          pagination.value=notesModel.pagination??Pagination();
        }
      });
    } finally {
      isLoadingMore.value=false;
    }
  }

  Future<void> removeNote({required String id}) async {
    isReLoading.value=true;
    var endPoint=APIEndPoints.removeNote;
    var parameters={"delete_id":id};
    try {
      var res=await RemoteServices.postRequest(endPoint: endPoint,parameters: parameters);
      if(res!=null){
        notes.removeWhere((note) => note.id.toString() == id);
        CustomSnackBar(
          isSuccess: true,
          msg: res["msg"]
        ).showSnackBar();
      }
    } finally {
      isReLoading.value=false;
    }
  }


}

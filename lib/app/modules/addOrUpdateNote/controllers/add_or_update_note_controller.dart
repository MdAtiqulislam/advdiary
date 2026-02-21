import 'package:advdiary/app/modules/notes/controllers/notes_controller.dart';
import 'package:advdiary/app/modules/notes/models/notes_model.dart';
import 'package:advdiary/constraints/api_endpoints.dart';
import 'package:advdiary/services/remote_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddOrUpdateNoteController extends GetxController {
  var title = "Add Note".obs;
  var isLoading=false.obs;

  // TextEditingControllers
  final TextEditingController noteTitleController = TextEditingController();
  final TextEditingController noteContentController = TextEditingController();

//  int? noteId;

  var selectedNote=SingleNote();

  @override
  void onInit() {
    super.onInit();
  }




  void saveNote() {
    if (selectedNote.id == null) {
     addNote();
    } else {
      updateNote();
    }
  }

  @override
  void onClose() {
    noteTitleController.dispose();
    noteContentController.dispose();
    super.onClose();
  }

  Future<void> addNote()async {
    isLoading.value=true;
    var endPoint=APIEndPoints.addNote;
    var body={
      "title":noteTitleController.text.trim(),
      "description":noteContentController.text.trim(),
    };
    try {
      var res=await RemoteServices.postRequest(endPoint: endPoint,body: body);
      if(res!=null){
        Get.put(NotesController()).getNotes();
        Get.back();
      }
    } finally {
      isLoading.value=false;
    }
  }

  void preloadData(){
    noteTitleController.text=selectedNote.title??"";
    noteContentController.text=selectedNote.description??"";
    title.value="Update Note";
  }

  Future<void> updateNote() async{
    isLoading.value=true;
    var endPoint=APIEndPoints.updateNote;
    var parameters={
      "id":selectedNote.id.toString(),
    };
    var body={
      "title":noteTitleController.text.trim(),
      "description":noteContentController.text.trim(),
    };
    try {
      var res=await RemoteServices.postRequest(endPoint: endPoint,parameters: parameters,body: body);
      if(res!=null){
        resetValue();
        Get.put(NotesController()).getNotes(showReloading: true);
        Get.back();
      }
    } finally {
      isLoading.value=false;
    }
  }

  void resetValue() {
    selectedNote=SingleNote();
    noteContentController.text="";
    noteTitleController.text="";
  }
  
}

var mode = ""
var filelist = []
var dialogList = []
var asdFile
var currentDialog
var dropzone
var isReplaceAllPressed = false
var isCopyAllPressed = false

$(document).ready(function(){
    initializeFileList();
    // Dropzone.autoDiscover = false;
    Dropzone.options.itemDropzone = {
        autoProcessQueue: false,
        parallelUploads: 8,
        addRemoveLinks: true,
        
        init: function(){
            dropzone = Dropzone.forElement("#itemDropzone")
            dropzone.on("addedfile", function(file){
                $("#submit_upload_btn").click(function(){ startUpload() })
                var filename = file.name;
                if(checkForExists(filename)){
                    createDialog(filename)
                }
                // asdFile = file
                // startUpload();
                activateButton();
            });
            dropzone.on("complete", function(){
                dropzone.processQueue();
            })
            dropzone.on("queuecomplete", function(){
                dropzone.removeAllFiles();
                isReplaceAllPressed = false;
                isCopyAllPressed = false;
            })
        }
    };
});


function activateButton(){
    if(dropzone.files.length >= 1 && dialogList.length == 0){
        $("#submit_upload_btn").removeClass("disabled");
    }
}

function disableButton(){
    $("#submit_upload_btn").addClass("disabled");    
}

function startUpload(){
    if(dialogList.length == 0){
        if(dropzone.files.length == 1){
            dropzone.processFile(dropzone.files[0]);
        } else {
            dropzone.processQueue();
        }
    }
    disableButton();
}

function initializeFileList(){
    $(".name-column").each(function(){
        filelist.push($(this).attr("name"))
    })
}

function addToDialogList(dialog){
    for(var i = 0; i < dialogList.length; i++){
        dialogList[i].dialog('close');
    }
    dialogList.push(dialog);
}

function removeDialog(filename){
    for(var i = 0; i < dialogList.length; i++){
        if(dialogList[i].dialog("option", "upload_name") == filename){
            dialogList.splice(i, 1)
        }
    }
}

function removeAllDialogs(){
    dialogList = []
}

function submitAllDialogsAsReplace(){
    for(var i = 0; i < dialogList.length; i++){
        dialogList[i].dialog("option", "buttons")['Replace'].apply(dialogList[i]);
    }
    removeAllDialogs();
}

function submitAllDialogsAsCopy(){
    for(var i = 0; i < dialogList.length; i++){
        dialogList[i].dialog("option", "buttons")['Create copy'].apply(dialogList[i]);
    }
    removeAllDialogs();
}

function removeLastDialog(){
    index = dialogList.length - 1
    dialogList.splice(index, 1);
}

function showLastDialog(){
    var index = dialogList.length - 1
    if(index >= 0){
        dialogList[index].dialog('open');
    }
}

function createDialog(filename){
    currentDialog = showFileActionDialog(filename).dialog('close');
    addToDialogList(currentDialog);
    currentDialog.dialog('open');
}

function checkForExists(filename){
    return jQuery.inArray(filename, filelist) == -1 ? false : true
}

function createInboxMessage(filename){
    return "<p>There is already a file with the same name in this folder.<br>Filename: " + filename + "</p>"
}

function showFileActionDialog(filename){
    var dialog =  $(createInboxMessage(filename)).dialog({
        upload_name: filename,
        title: "Files upload",
        closeOnEscape: false,
        open: function(event, ui) {
            $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
        },
        width: "50%",
        buttons: {
            "Replace": function() {
                replaceFile(filename);
                dialog.dialog('close');
            },
            "Replace all":  function() {
                dialog.dialog('close');
                replaceAll();
            },
            "Create copy":  function() {
                createCopy(filename);
                dialog.dialog('close');
            },
            "Copy all": function(){
                isCopyAllPressed = true;                
                dialog.dialog('close');
                copyAll(filename);
            },
            "Don't upload":  function() {
                ignoreFile(filename);
                dialog.dialog('close');
            }
        }
    });
    return dialog;
}

function replaceFile(filename){
    if(!isReplaceAllPressed){
        removeLastDialog();
        showLastDialog();
    }
    // startUpload();
    activateButton();
}

function copyAll(){
    submitAllDialogsAsCopy();
    activateButton();
}

function replaceAll(){
    isReplaceAllPressed = true;
    submitAllDialogsAsReplace();
    // startUpload();
    activateButton();
    
}

function ignoreFile(filename){
    for(var i = 0; i < dropzone.files.length; i++){
        if(dropzone.files[i].name == filename){
            dropzone.removeFile(dropzone.files[i]);
            removeDialog(filename);
        }
    }
    showLastDialog();
    // startUpload();
    activateButton();
    
}

function createCopy(filename){
    for(var i = 0; i < dropzone.files.length; i++){
        if(dropzone.files[i].name == filename){
            nameParts = filename.split(".")
            dropzone.files[i].upload.filename = nameParts[0] + "(copy)." + nameParts[1];
            if(!isCopyAllPressed){
                removeDialog(filename);
            }
        }
    }
    if(!isCopyAllPressed){
        // removeLastDialog();
        showLastDialog();
    }
    // showLastDialog();
    activateButton();
}
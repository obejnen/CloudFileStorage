var FOLDERFORMTOPOFFSET = 35;

function openFolderForm() {
    var pos = $("#new_folder_btn").position();
    $("#folder-form").css({ left: pos.left, top: pos.top + FOLDERFORMTOPOFFSET });
    $("#folder-form").css({ display: "inline-block" });
    $(".form-control").focus();
}

function closeFolderForm() {
    $("#folder-form").css({ display: "none" });
    $("#new_folder")[0].reset();
}

$("#item_file").on("change", function(){
    openItemForm();
    var files = $("#item_file")[0].files;
    var length = files.length;
    $("#files").empty();
    length > 1 ? $("#files").height(files.length*24) : $("#files").height(30)
    length > 1 ? $("#files2upload").height(files.length*24) : $("#files2upload").height(30)        
    for(i = 0; i < files.length; i++){
        $("#files").append("<div id='file" + i + "'>" + files[i].name + "</div>");
    }
});

function openItemForm() {
    document.getElementById("files2upload").style.position = $("#item_file").position;
    document.getElementById("files2upload").style.display = "block";
}

function closeItemForm() {
    document.getElementById("files2upload").style.display = "none";
}
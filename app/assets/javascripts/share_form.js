var SHAREFORMTOPOFFSET = 35;

function openFolderShareForm(row_id) {
    closeShareForm();
    var pos = $("#share-folder-" + row_id).position();
    $("#share-form-folder-" + row_id).css({ left: pos.left, top: pos.top + SHAREFORMTOPOFFSET });
    $("#share-form-folder-" + row_id).css({ display: "inline-block" });
    $(".form-control").focus();
}

function openItemShareForm(row_id) {
    closeShareForm();
    var pos = $("#share-item-" + row_id).position();
    $("#share-form-item-" + row_id).css({ left: pos.left, top: pos.top + SHAREFORMTOPOFFSET });
    $("#share-form-item-" + row_id).css({ display: "inline-block" });
    $(".form-control").focus();
}

function closeShareForm() {
    $("[id*='share-form-'").css({ display: "none" });
}

function resetShareForm() {
    $("#username").val("");
}
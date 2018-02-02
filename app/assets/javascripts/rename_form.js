var RENAMEFORMTOPOFFSET = 35;

function openRenameFolderForm(row_id) {
    closeRenameForm();
    var pos = $("#rename-folder-" + row_id).position();
    $("#rename-form-folder-" + row_id).css({ left: pos.left, top: pos.top + RENAMEFORMTOPOFFSET });
    $("#rename-form-folder-" + row_id).css({ display: "inline-block" });
    $(".form-control").focus();
}

function openRenameItemForm(row_id) {
    closeRenameForm();
    var pos = $("#rename-item-" + row_id).position();
    $("#rename-form-item-" + row_id).css({ left: pos.left, top: pos.top + RENAMEFORMTOPOFFSET });
    $("#rename-form-item-" + row_id).css({ display: "inline-block" });
    $(".form-control").focus();
}

function closeRenameForm() {
    $("[id*='rename-form-'").css({ display: "none" });
}

function resetRenameForm() {
    $("#name").val("");
}

// Override the default confirm dialog by rails
$.rails.allowAction = function(link){
  if (link.data("confirm") == undefined){
    return true;
  }
  $.rails.showConfirmationDialog(link);
  return false;
}

// User click confirm button
$.rails.confirmed = function(link){
  link.data("confirm", null);
  link[0].click();
}

// Display the confirmation dialog
$.rails.showConfirmationDialog = function(link){
  var message = link.data("confirm");
  swal({
    title: message,
    type: 'warning',
    showCancelButton: true,
    confirmButtonText: 'Sim',
    confirmButtonColor: '#d33',
    cancelButtonText: 'Não',
    reverseButtons: true
  }).then(function(result){
    if (result.value) {
      $.rails.confirmed(link);
    }
  });
};

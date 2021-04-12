// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require sweetalert2
//= require popper
//= require bootstrap
//= require select2-full
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('ready turbolinks:load', function(){
  sideBarControl()

  $('.select2').select2({
    theme: "bootstrap"
  })

})

function sideBarControl(){
  let sidebarOpen = localStorage.getItem('sidebarOpen')
  const isMobileDevice = /Mobi/i.test(window.navigator.userAgent)

  if (sidebarOpen === null || isMobileDevice){
    localStorage.setItem('sidebarOpen', false)
    collapsesItems()
  }

  $(".sidebar-btn").click(function(){
    localStorage.setItem('sidebarOpen', !toBoolean(sidebarOpen))
    collapsesItems()
  })

  if (toBoolean(sidebarOpen) && !isMobileDevice){
    collapsesItems()
  }
}

function collapsesItems(){
  $(".wrapper").toggleClass("collapses")
  $(".box").toggleClass("collapses")
  $(".alert").toggleClass("collapses")
}

function toBoolean(bool) {
  if (bool == 'true'){
    return true
  } else if(bool == 'false'){
    return false
  }else{
    return undefined
  }
}

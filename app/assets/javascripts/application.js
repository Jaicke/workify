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
//= require cocoon
//= require sweetalert2
//= require popper
//= require bootstrap
//= require select2-full
//= require activestorage
//= require turbolinks
//= require_tree .

var toBoolean = function(bool) {
  if (bool == 'true'){
    return true
  } else if(bool == 'false'){
    return false
  }else{
    return undefined
  }
}

var APPLICATION = (function(application){
  'use strict'

  var delayedSearch = function(){
    var timer;

    $('.search-input').on('keyup', function(){
      clearTimeout(timer);
      timer = setTimeout(() => {
        $(this).closest('form').submit()
      }, 800);
    })
  }

  var initializeSelect2 = function(){
    $('.select2').select2({
      theme: "bootstrap"
    })

    $('#modal-window').on('shown.bs.modal', function () {
      $('.select2').select2({
        theme: 'bootstrap'
      });
    })
  }

  var initializeTooltip = function(){
    $('[data-toggle="tooltip"]').tooltip()
  }

  var initializePopover = function(){
    $('[data-toggle="popover"]').popover()
  }

  var collapsesItems = function(){
    $(".wrapper").toggleClass("collapses")
    $(".box").toggleClass("collapses")
    $(".alert").toggleClass("collapses")
  }

  var sideBarControl = function(){
    let sidebarOpen = localStorage.getItem('sidebarOpen')
    let isMobileDevice = /Mobi/i.test(window.navigator.userAgent)

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

  var application = {
    init: function(){
      delayedSearch()
      sideBarControl()
      initializeSelect2()
      initializeTooltip()
      initializePopover()
    }
  }

  return application
}(APPLICATION || {}))

$(document).on('ready turbolinks:load', function(){
  APPLICATION.init()
})

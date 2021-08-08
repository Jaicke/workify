var WORKS = (function(works){
  'use strict'

  var toggleGroupMembersFields = function(){
    $('body').on('change', '#work_group', function(){
      toggleFields()
    })
  }

  var toggleFields = function(){
    let groupCheck = $('#work_group')
    let groupMembersFields = $('#fields-for-group-members')

    if (groupCheck.is(":checked")){
      groupMembersFields.slideToggle("slow")
    } else {
      groupMembersFields.slideToggle("slow")
    }
  }

  var works = {
    init: function(){
      toggleGroupMembersFields()
    }
  }

  return works
}(WORKS || {}))

$(document).on('ready turbolinks:load', function(){
  WORKS.init()
})

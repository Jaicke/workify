var COMMENTS = (function(comments){
  'use strict'

  var toggleButtons = function(){
    $('body').on('input', '#comment-input', function(){
      let value = $(this).val()

      if(value) {
        $('#comment-submit').prop("disabled", false)
      }else{
        $('#comment-submit').prop("disabled", true)
      }
    })

    $('body').on('focus', '#comment-input', function(){
      $('#comment-submit').removeClass('d-none')
      $('#comment-cancel').removeClass('d-none')
    })

    $('body').on('click', '#comment-cancel', function(){
      $('#comment-submit').addClass('d-none')
      $('#comment-cancel').addClass('d-none')
      $('#comment-submit').prop("disabled", true)
      $('#comment-input').val('')
    })
  }

  var showReplyForm = function(){
    $('body').on('click', '.reply-link', function(){
      let parentId = $(this).data('parent-id')
      let authorReply = $(this).data('author-reply')

      $(`.reply-form-${parentId}`).removeClass('d-none')
      $(`.reply-form-${parentId} textarea#body`).focus()

      if(authorReply) {
        $(`.reply-form-${parentId} textarea#body`).val(`${authorReply}, `)
      } else {
        $(`.reply-form-${parentId} textarea#body`).val('')
      }
    })
  }

  var comments = {
    init: function(){
      toggleButtons()
      showReplyForm()
    }
  }

  return comments
}(COMMENTS || {}))


$(document).on('ready turbolinks:load', function(){
  COMMENTS.init()
})

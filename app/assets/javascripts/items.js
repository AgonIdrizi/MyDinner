
var replies = document.querySelectorAll('.fa-reply')
replies.forEach(reply => {
    reply.parentElement.addEventListener('click',showReplyDiv)
});

function showReplyDiv(e) {
    e.preventDefault()
    parentCardDiv = e.target.parentElement.parentElement.parentElement.parentElement.parentElement
    replyReviewDiv = parentCardDiv.nextElementSibling
    
    replyReviewDiv.classList.contains('hide') ? replyReviewDiv.classList.remove('hide') : replyReviewDiv.classList.add('hide')
    
}


var showReplies = document.querySelectorAll('.show-replies')
showReplies.forEach(showReply => {
    showReply.addEventListener('click', showOrHideReplies)
});

function showOrHideReplies (e) {
  e.preventDefault()
  var alldiv = e.target.parentElement.parentElement.parentElement.parentElement
  Array.from(alldiv.children).forEach(div => {
    
    if ( div.classList.contains('reply') && div.classList.contains('hide') ) {
      div.classList.remove('hide')
    } else if ( div.classList.contains('reply') && !div.classList.contains('hide')) {
        div.classList.add('hide')
    }
  });
}

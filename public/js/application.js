$(document).ready(function() {

  /****** sends user input,
   *      receives response,
   *      whipes card,
   *      redraws with answer *****/

  /* CAPTURE */

  $( "#answer-form" ).on( "submit", function(event) {
    event.preventDefault();
    answerQuestion();
  });

  /* CALL SUBROUTINES */

  function answerQuestion() {
    // get data from form
    var formData = getFormData();
    // send data to server and receive response
    sendData(formData);
  }

  /* READ AND PACKAGE DATA FROM FORM
     returned as an object */

  function getFormData() {
    var url = $( "#answer-form" ).attr( "action" );
    var answer = $( "#answer-form > input" ).val();
    return { "url": url, "answer": answer };
  }

  /* AJAX SENDS FORM DATA
     AND RECEIVE RESPONSE

     MANIPULATES DOM ON SUCESS
     
     response is an object */

  function sendData(formData) {
    var posty = $.post(formData.url,
      { "user_response": formData.answer },
      function( response ) {
        modifyDom(response);
      }
    );
  }

  /* DOM MANIPULATION */

  function modifyDom(response) {
    whipeCard();
    showAnswer(response);
  }

  function whipeCard() {
    $( "#card" ).children().fadeOut(400).remove();
    /* insert extra bottom padding
       so as to preserve card size */
    $( "#card" ).css("padding-bottom", "6.3em");
  }

  function showAnswer(response) {
    console.log(response);
  }
});

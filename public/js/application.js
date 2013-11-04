$(document).ready(function() {

  /****** sends user input,
   *      receives response,
   *      wipes card,
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
        // parse JSON and call DOM modifier

       
        console.log(response);

        try {
          modifyDom(JSON.parse(response));
        } catch(error) {
          // $(document).empty()
          $('body').html(response);
        }
      }
    ).fadeIn(800);

      }
 
  /* DOM MANIPULATION */

  function modifyDom(response) {
    wipeCard();
    showAnswer(response);
  }

  function wipeCard() {
    $( "#card" ).children().fadeOut();
    $( "#card" ).children().remove();
    /* insert extra bottom padding
       so as to preserve card size */
    $( "#card" ).css("padding-bottom", "6.3em");
  }

  function showAnswer(response) {
    console.log(response);
    // reset padding
    $( "#card" ).css("padding-bottom", "2em");
    // append the goods
    $( "#card").append(
       "<h3 class=\"text-center\">" + response["outcome"] + "</h3>"
      + "<p class=\"text-center\">The answer is " + response.answer
      + "</p>"
      + "<span class=\"next-center\"><a href=\"/decks/" + response.deck
      + "/draw_card\">next card</a></span>"
      + "</div>"
    ).fadeIn(800);

  }

  /* INSERT NEXT CARD EVENT HERE */

});

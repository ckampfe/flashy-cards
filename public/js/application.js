$(document).ready(function() {

  /* AJAX TO POST CARD ANSWER */

  // this is the event
  $( "#answer-form" ).on( "submit", function(event) {
    event.preventDefault();
    // this calls the subroutines
    answerQuestion();
  });

  function answerQuestion() {
    // get data from form
    var formData = getFormData();
    // send data to server and receive response
    var serverSays = sendData(formData); 
    // modify DOM / fade 
    modifyDom(serverSays); 
  }

  function getFormData() {
    var url = $( "#answer-form" ).attr( "action" );
    var answer = $( "#answer-form > input" ).val();
    console.log(url);
    return { "url": url, "answer": answer };
  }

  function sendData(formData) {
    var dataObject = { "user_response": formData.answer }
    console.log(dataObject);
    $.post(formData.url, dataObject, function( response ) {
      console.log(response);
      return response;
    });
  }

  function modifyDom(serverSays) {
    console.log("made it here!");
    console.log(serverSays);
  }
});

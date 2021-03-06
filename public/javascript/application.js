$(document).ready(function() {

var inlineEdit = function() {
  $('.contact-name').editable();
  $('.contact-email').editable();
  $('.contact-number').editable();
};

  var basicListeners = function() {
    showContactInfo();
    hideContactInfo();
    removeContact();
    inlineEdit();
  };


  var showContactInfo = function() { 
    $('.glyphicon-plus').click(function(){
      $(this).closest('.contact').animate({height:'110'}, 100);
      $(this).toggle();
      $(this).next().fadeIn();
      $(this).siblings().last().css({
        'visibility': 'visible'
      });
    });
  };

  var hideContactInfo = function() { 
    $('.glyphicon-minus').click(function(){
      $(this).closest('.contact').animate({height:'60'}, 100);      
      $(this).toggle();
      $(this).prev().fadeIn();
      $(this).siblings().last().css({
        'visibility': 'hidden'
      });
    });
  };


  var successCallback = function(data) {
      $('#contact-list').empty();

      data.forEach(function(contact) {
          html =  '<div class="contact" id="'+contact.id+'"><div class="contact-header text-center"><a href ="/post" data-type="text" data-pk="'+contact.id+'" data-url="/post" data-name="name" class="contact-name">'+contact.name+'</a> <span class="glyphicon glyphicon-plus" aria-hidden="true"></span><span class="glyphicon glyphicon-minus" aria-hidden="true"></span><span class="glyphicon glyphicon-remove delete-contact" aria-hidden="true"></span> </div><div class="contact-body"><a href ="/post" data-type="text" data-pk="'+contact.id+'" data-url="/post" data-name="email" class="contact-email">'+contact.email+'</a><a href ="/post" data-type="text" data-pk="'+contact.id+'" data-url="/post" data-name="number" class="contact-number">'+contact.number+'</a></div></div>';
          $('#contact-list').append(html);
      });

      $('.form-inline').find('input').val('');
      basicListeners();
    }

  var removeContact = function() {
    $('.glyphicon-remove').click(function(){
      var id = $(this).closest('.contact').attr('id')

      $.ajax({
        type: "POST",
        url: "/delete",
        data: "id="+id,
        success: successCallback
      })
    });
  };


  $(".form-inline").submit(function(e){
    var postData = $(this).serializeArray();
    e.preventDefault();

    $.ajax({
        type: "POST",
        url:"/new",
        data: postData,
        success: successCallback
    });

  });




basicListeners();


});






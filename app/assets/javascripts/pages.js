// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// Simple single page application framework
// Author: andrew @ terrainformatica.com

(function($,window){

  var pageHandlers = {};
  var currentPage;
  
  // show the "page" with optional parameter
  function show(pageName,param) { 
    // invoke page handler
    var ph = pageHandlers[pageName]; 
    if( ph ) { 
      var $page = $("section#" + pageName);
      ph.call( $page.length ? $page[0] : null,param ); // call "page" handler
    }
    // activate the page  
    $("#sidebar-wrapper li.active").removeClass("active");
    $("#sidebar-wrapper li a[href=#"+pageName+"]").closest("li").addClass("active");
    
    $(document.body).attr("page",pageName)
                    .find("section").removeClass("active")
                    .filter("section#" + pageName).addClass("active");
  }  

  // "page" loader
  function app(pageName,param) {
  
    var $page = $(document.body).find("section#" + pageName);  
    
    var src = $page.attr("src");
    if( src && $page.find(">:first-child").length == 0) { 
      $.get(src, "html") // it has src and is empty - load it
          .done(function(html){ currentPage = pageName; $page.html(html); show(pageName,param); })
          .fail(function(){ $page.html("failed to get:" + src); });
    } else
      show(pageName,param);
  }

  // register page handler  
  app.handler = function(handler) {
    var $page = $(document.body).find("section#" + currentPage);  
    pageHandlers[currentPage] = handler.call($page[0]);
  }
  
  function onhashchange() 
  {
    var hash = location.hash || "#start_work";
    
    var re = /#([-_0-9A-Za-z]+)(\:(.+))?/;
    var match = re.exec(hash);
    hash = match[1];
    var param = match[3];
    app(hash,param); // navigate to the page
  }
  
  window.addEventListener('popstate', function(event) {
    if(window.location.hash) {
      onhashchange()
    }
  });
  
  window.app = app; // setup the app as global object
  
  $(function(){ onhashchange() }); // initial state setup

})(jQuery,this);
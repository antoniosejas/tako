/* TaKo v0.1.0 - 11/11/2013
   http://
   Copyright (c) 2013  - Licensed  */
(function(){var a;window.TaKo=a={}}).call(this);(function(){TaKo.Aside=function(a){var b,c,d,e,f;b=$("aside");c=$("#background");e=function(){c.css("z-index","109");return b.addClass("show")};d=function(){b.removeClass("show");return c.css("z-index","0")};f=function(){if(b.hasClass("show")){return d()}else{return e()}};$("[data-action=aside]").each(function(a){return $(this).bind("click",function(){return f()})});return{show:e,hide:d,toggle:f}}(TaKo)}).call(this);
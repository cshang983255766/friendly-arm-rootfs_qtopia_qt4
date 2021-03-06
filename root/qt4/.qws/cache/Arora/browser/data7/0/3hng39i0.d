   �       http://arm9.net/js/newsticker.js    ����� %{e�e�         
     O K           �      Last-Modified   Wed, 08 May 2013 12:24:16 GMT   Accept-Ranges   bytes   Content-Encoding   gzip   Content-Type   application/javascript   Server   Apache   ETag   "190b8f-739-4dc340324dc00"   Vary   Accept-Encoding // Create namespace
if (at == undefined) var at = {};
if (at.bartelme == undefined) at.bartelme = {};

// Newsticker Class
at.bartelme.newsticker = Class.create();
at.bartelme.newsticker.prototype = {
	initialize: function()
	{
		// Get elements
		this.interval = 5000;
		this.container = $("newsticker");
		this.messages  = $A(this.container.getElementsByTagName("dd"));
		this.number_of_messages = this.messages.length;
		if (this.number_of_messages == 0)
		{
			this.showError();
			return false;
		}
		this.current_message = 0;
		this.previous_message = null;
		
		this.hideMessages();
		this.showMessage();
		// Install timer
		this.timer = setInterval(this.showMessage.bind(this), this.interval);
  	},
	showMessage: function()
	{
		Effect.Appear(this.messages[this.current_message]);
		setTimeout(this.fadeMessage.bind(this), this.interval-1000);
		if (this.current_message < this.number_of_messages-1)
		{
			this.previous_message = this.current_message;
			this.current_message = this.current_message + 1;
		} else {
			this.current_message = 0;
			this.previous_message = this.number_of_messages - 1;
		}
	},
	fadeMessage: function()
	{
		Effect.Fade(this.messages[this.previous_message]);
	},
	hideMessages: function()
	{
		this.messages.each(function(message)
		{
			Element.hide(message);
		})
	},
	
	showError: function()
	{
		if (this.container.getElementsByTagName("ul").length == 0)
		{
			this.list = document.createElement("ul");
			this.container.appendChild(this.list);
		} else {
			this.list = this.container.getElementsByTagName("ul")[0];
		}
		this.errorMessage = document.createElement("li");
		this.errorMessage.className = "error";
		this.errorMessage.innerHTML = "Could not retrieve data";
		this.list.appendChild(this.errorMessage);
	}
}

Event.observe(window, "load", function(){new at.bartelme.newsticker()}, false);

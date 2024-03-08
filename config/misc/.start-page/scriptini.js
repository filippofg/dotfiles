function startTime() {
	var now 	= new Date();
	// time: get hours and minutes w/padding digit if necessary
	var hours 	= addPaddingZero(now.getHours());
	var minutes = addPaddingZero(now.getMinutes());
/* 	var seconds = addPaddingZero(now.getSeconds());
 */	
	// set the clock
	document.getElementById('clock').innerHTML = hours + ":" + minutes /* + ":" + seconds */;
	
	// date:
	var date	= now.getDate();  						// 15
	var month	= addPaddingZero(now.getMonth()+1);		// (0)9
	var year 	= now.getFullYear();					// 2019

	var today = date + "/" + month + "/" + year;		// 15/09/2019

	document.getElementById('date').innerHTML = today;	// set the current date
	var time 	= setTimeout(startTime, 500);
}

function addPaddingZero(digit) {
	if(digit < 10) digit = "0" + digit;
	return digit;
}

function search() {
	var content = document.getElementById('ricercatore').value;	// search field
	var provider;
	var keywords = content.split(' ');	// tokenize the input value
	switch(keywords[0]) {
		case ':g':	// google
			provider = 'https://www.google.it/search?q=';
			break;
		/* case ':d':
			provider = 'www.duckduckgo.com';
			break; */
		case ':wi':	// wikipedia (it)
			provider = 'https://it.wikipedia.org/w/index.php?search=';
			break;
		case ':we':	// wikipedia (en)
		case ':w':	// also wikipedia (en)
			provider = 'https://en.wikipedia.org/w/index.php?search=';
			break;
		case ':aw':	// archwiki
			provider = 'https://wiki.archlinux.org/index.php?search=';
			break;
		case ':dw':	// debian wiki
			provider = 'https://wiki.debian.org/FrontPage?action=fullsearch&value=';
			break;
		case ':so':	// stackoverflow
			provider = 'https://www.stackoverflow.com/search?q=';
			break;
		case ':gh':	// github
			provider = 'https://www.github.com/search?q=';
			break;
		case ':yt': // youtube
			provider = 'https://www.youtube.com/results?search_query=';
			break;
		default:	// default provider: duckduckgo
			provider = 'https://www.duckduckgo.com/?q=';
			break;
	}
	if(keywords[0][0] == ':')	// if the token array contains a special provider specifier
		keywords.splice(0,1);	// delete it before joining the keywords

	keywords = keywords.join('+');	// "GET"

	var link = provider + keywords;	

	window.location = link;	// redirect
}

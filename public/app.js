
function something()
	{
		var x = window.localStorage.getItem('abc');
		//x = parseInt(x);
		x = x *1 + 1;
		window.localStorage.setItem('abc', x)

		alert(x);		
	}
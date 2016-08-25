
function something()
	{
		var x = window.localStorage.getItem('abc');
		//x = parseInt(x);
		x = x *1 + 1;
		window.localStorage.setItem('abc', x)
		//alert(x);				
	}

function add_to_cart(id)	
	{	
		var key = 'product_'+id;
		var x = window.localStorage.getItem(key);
		x = x * 1 + 1;
		window.localStorage.setItem(key, x);
		total_in_cart();
	}

function rem_from_cart(id)	
	{	
		var key = 'product_'+id;
		var x = window.localStorage.getItem(key);
		x = x * 1 - 1;
		if (x <= 0) {
			window.localStorage.removeItem(key);
			location.reload();
		}
		else {
			window.localStorage.setItem(key, x);
		}
		
		total_in_cart();
	}	

function total_in_cart()	
	{	
		var total_c = 0;

		for (var i = 0; i < window.localStorage.length; i++) {			
				key = window.localStorage.key(i);
				if (key.search("product")>=0) {
					p = key.search("_") + 1;				
					id = key.substring(p);
					t = window.localStorage[key]*1;
					total_c = total_c + t;
					document.getElementById("countb_"+id).innerHTML = t;
					document.getElementById("countb2_"+id).innerHTML = t;				
				}				

		}
		document.getElementById("countt").innerHTML = total_c;

		ord_str = get_orders();
		$('#order_str').val(ord_str)

		btext = 'Check out order ( '+ total_c +' )'
		$('#order_button').val(btext)		
		

	}

function clearorder()	
	{
		window.localStorage.clear();		
		location.reload();
	}

function get_orders()	
	{	
		var orders = '';

		for (var i = 0; i < window.localStorage.length; i++) {
			key = window.localStorage.key(i);
			if (key.search("product")>=0) {						
				value = window.localStorage[key];
				orders = orders + key + '='+value+',';							
			}		
		}
		if (orders.length>0) {
			orders = orders.substring(0,orders.length-1);
		}
		return orders;		
	}	

function hidden_button()
	{
		var inp_h = document.getElementById('buttn_h');
		var btn = document.getElementById('order_button');
            if (inp_h.val = 0) {
                btn.style.display='block';
            } else {
                btn.style.display='none';
            }

	}

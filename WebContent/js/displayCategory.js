
$(document).ready(function()
		{


	$.ajax
	({
		type: "GET",
		url: "GetCategory",
		dataType:"json",
		success: function(data)
		{

			if(data.Messages.length)
			{
				/*  var $table = $("<table>").appendTo($("#myTable"));  */
				$("table").tablesorter({ sortList: [ [1,0], [2,0],] });
				$.each(data.Messages, function(i,data)
						{
					/*		 var html = "<tr>" + "<td><input type='checkbox' name='selected[]' value='"+ data.category_id+"'></td>"+ "<td class='text-left'>" + data.category_name+ "</td><td  class='text-left'>"+data.category_desc+"</td></tr>";
		    $('#myTable').append(html);*/

					var tr;

					tr = $('<tr/>');
					tr.append("<td><input type='checkbox' name='catid'  value='" + data.category_id + "' ></td>");
					tr.append("<td>" + data.category_name + "</td>");
					tr.append("<td>" + data.category_desc + "</td>");
					$('#myTable').append(tr);


					//This function is triggered when the user clicks the Submit button


					/* var msg_data="<div  id='msg"+data.category_id+"'>"+data.category_id+data.category_name+data.category_desc+"</div>";
		$(msg_data).appendTo("#content");  */
					/* 	
		var cat_id = data.category_id;
		var cat_name = data.category_name;
		var desc = data.category_desc;
		document.getElementById("data1").innerHTML = cat_id; 
		document.getElementById("data2").innerHTML = cat_name; 
		document.getElementById("data3").innerHTML = desc;  */
					/* 	 $("<tr>").appendTo($table)                     // Create HTML <tr> element, set its text content with currently iterated item and append it to the <table>.
         .append($("#id").text(data.category_id))        // Create HTML <td> element, set its text content with id of currently iterated product and append it to the <tr>.
         .append($("#name").text(data.category_name))      // Create HTML <td> element, set its text content with name of currently iterated product and append it to the <tr>.
         .append($("#desc").text(data.category_desc));    // Create HTML <td> element, set its text content   */

					/*	$("button").click(function(){
						var favorite = [];
						$.each($("input[name='id']:checked"), function(){            
							favorite.push($(this).val());
						});
						alert("My favourite sports are: " + favorite.join(", "));

					});
					 */



					$("table").trigger("update");

						});
				
				function setSettings() {
					if ('localStorage' in window && window['localStorage'] !== null) {
						try {
							var favcolor = document.getElementById('catid').value;
						

							localStorage.key = favcolor;
						} catch (e) {
							if (e == QUOTA_EXCEEDED_ERR) {
								alert('Quota exceeded!');
							}
						}
						} else {
							alert('Cannot store user preferences as your browser do not support local storage');
						}
					}
			}

			else
			{
				$("#myTable").html("No Results");
				return false;
			}
		}
	});






		});










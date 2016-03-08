function validateForm() {

	if (document.myForm.sname.value == "") {
		alert("Please provide your surname for parent!");
		document.myForm.sname.focus();
		return false;
	}
	
	if (document.myForm.gname.value == "") {
		alert("Please provide your given name for parent!");
		document.myForm.gname.focus();
		return false;
	}

	if (document.myForm.country.value == "" || document.myForm.country.value.length != 2) {
		alert("Please provide your country code for parent!");
		document.myForm.country.focus();
		return false;
	}
/*	
	var phoneno = /^\d{10}$/;*/
	if (document.myForm.contact_number.value == "" || document.myForm.contact_number.value.length != 8) {
		//if((inputtxt.value.match(phoneno)) 
		alert("Please provide a valid phone number for parent!");
		document.myForm.contact_number.focus();
		return false;
	}


	if (document.myForm.address.value == "") {
		alert("Please provide your address for parent!");
		document.myForm.address.focus();
		return false;
	}

	if (document.myForm.postal_code.value == ""
			|| document.myForm.postal_code.value.length != 6) {
		alert("Please provide your postal code for parent!");
		document.myForm.postal_code.focus();
		return false;
	}

	if (document.myForm.sname1.value == "") {
		alert("Please provide your surname for child!");
		document.myForm.sname1.focus();
		return false;
	}

	if (document.myForm.gname1.value == "") {
		alert("Please provide your given name for child!");
		document.myForm.gname1.focus();
		return false;
	}

	if (document.myForm.country1.value == "" || document.myForm.country1.value.length != 2) {
		alert("Please provide your country code for child!");
		document.myForm.country1.focus();
		return false;
	}

	if (document.myForm.contact_number1.value == "" || document.myForm.contact_number1.value.length != 8) {
		alert("Please provide a valid phone number for child!");
		document.myForm.contact_number1.focus();
		return false;
	}

	if (document.myForm.address1.value == "") {
		alert("Please provide your address for child!");
		document.myForm.address1.focus();
		return false;
	}

	if (document.myForm.postal_code1.value == "" || document.myForm.postal_code1.value.length != 6) {
		alert("Please provide your postal code for child!");
		document.myForm.postal_code1.focus();
		return false;
	}
	return (true);

}

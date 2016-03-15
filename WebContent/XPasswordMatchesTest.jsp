<html>
<body>
	<form id="passwordForm">
		<fieldset>
			<legend>Change Your Password</legend>
			<ul>
				<li><label for="password1">Password 1:</label> <input
					type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title = "Error: password do not match
					OR " required id="password1" /></li>
				<li><label for="password2">Password 2:</label> <input
					type="password" required id="password2" /></li>
			</ul>
			<input type="submit" />
		</fieldset>
	</form>
</body>

<script> 
(function() {
    var password1 = document.getElementById('password1');
    var password2 = document.getElementById('password2');
    
    var checkPasswordValidity = function() {
        if (password1.value != password2.value) {
            password1.setCustomValidity('Passwords must match.');
        } else {
            password1.setCustomValidity('');
        }        
    };
    
    password1.addEventListener('change', checkPasswordValidity, false);
    password2.addEventListener('change', checkPasswordValidity, false);
    
    var form = document.getElementById('passwordForm');
    form.addEventListener('submit', function(event) {
        checkPasswordValidity();
        if (!this.checkValidity()) {
            event.preventDefault();
            //Implement you own means of displaying error messages to the user here.
            password1.focus();
        }
    }, false);
}());

</script>

</html>
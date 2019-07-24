<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<link href="../styles.css" rel="stylesheet"/>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<div class="jumbotron jumbotron-fluid">
  <div class="container">
    <h1 class="">Black && White</h1>
    <p class="">Online Shopping Made Easy</p>
  </div>
</div>

<div class="container">
	<div class="container-2">
		<h2>Register</h2>
		    <p><form:errors path="user.*"/></p>
		    
		    <form:form method="POST" action="/registration" modelAttribute="user">
		        <p>
		            <form:label path="firstName">First Name:</form:label>
		            <form:input path="firstName"/>
		        </p>
		         <p>
		            <form:label path="lastName">Last Name:</form:label>
		            <form:input path="lastName"/>
		        </p>
		        <p>
		            <form:label path="email">Email:</form:label>
		            <form:input type="email" path="email"/>
		        </p>
		
		
		        <p>
		            <form:label path="password">Password:</form:label>
		            <form:password path="password"/>
		        </p>
		        <p>
		            <form:label path="passwordConfirmation">Password Confirmation:</form:label>
		            <form:password path="passwordConfirmation"/>
		        </p>
		        <input type="submit" value="Register!"/>
		    </form:form>
	</div>
	<div class="container-2">
		<h2>Login</h2>
		    <p><c:out value="${error}" /></p>
		    <form method="post" action="/login">
		        <p>
		            <label for="email">Email</label>
		            <input type="text" id="email" name="email"/>
		        </p>
		        <p>
		            <label for="password">Password</label>
		            <input type="password" id="password" name="password"/>
		        </p>
		        <input type="submit" value="Login!"/>
		    </form>    
	</div>


</div>
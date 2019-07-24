<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<link href="../styles.css" rel="stylesheet"/>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<div class="container">
	<h1>
	<c:out value="${product.getName() }"/>
	</h1>
	<img src="${product.getPictureUrl() }"><br>
	Price:<c:out value="${product.getPrice() }"/><br>
</div>
	
<div class="container">
	<form:form method="post" action="/addToBasket/${product.getId() }" modelAttribute="orderProduct">
		<select name="quantity">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
		</select>
		<input type="submit" value="Submit">
	</form:form>
</div>


<div class="container">
	<a href="/products/${product.getId() }/delete">Delete this Product</a>
	<a href="/dashboard">Back to Dashboard</a>
</div>

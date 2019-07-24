<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<link href="styles.css" rel="stylesheet"/>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<div class="container">
	<div class="container">
		<h1>Welcome <c:out value="${user.getFirstName() }"/></h1>
		
		<p>
		<a href="/basket">Go to basket</a> |
		<a href="/allOrders">Go to Order History</a>
		</p>
	</div>

<div class="container">
	<table>
	<tr>
	<th>Product Name</th>
	<th>Product Price</th>
	</tr>
	<c:forEach var="i" items="${allProducts }">
	<tr>
	<td>		<a href="/products/${i.getId() }"><c:out value="${i.getName() }"/></a></td>
	<td><c:out value="${i.getPrice() }"/></td>
	</tr>
	</c:forEach>
	</table>
</div>



<div class="container">
	<a href="/new">Add New Product</a> |
	<a href="/logout">Logout</a>
	</div>
</div>




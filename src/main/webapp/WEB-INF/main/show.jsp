<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<link href="../styles.css" rel="stylesheet"/>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<div class="container">
	<p>Order Number: <c:out value="${clientOrder.getId() }"/></p>
	<table>
		<tr>
			<th>Products</th>
			<th>Quantity</th>
			<th>Price</th>
		</tr>
			<c:set var="totalPrice" value="0"/>
			<c:set var="totalQuantity" value="0"/>
		<c:forEach var="j" items="${clientOrder.getOrderProducts() }">
		<tr>
				<td><c:out value="${j.getProduct().getName() }"/></td>
				<td><c:out value="${j.getQuantity()}"/></td>
				<td><c:out value="${j.getProduct().getPrice() }"/></td>
				<c:set var="totalPrice" value="${totalPrice+j.getProduct().getPrice() }"/> 
				<c:set var="totalQuantity" value="${totalQuantity+1 }"/> 
		</tr>
		</c:forEach>
		
	</table>
	
	

		<div class="container">
			<p>
			Total Price: <c:out value="${totalPrice }"/>
			</p>
			<p>
			Number of items in basket: <c:out value="${totalQuantity }"/>
			</p>
		</div>

	<a href="/dashboard">Back to Dashboard</a>
</div>

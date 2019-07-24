<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<link href="styles.css" rel="stylesheet"/>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<div class="container">
<h3>This is basket</h3>
<c:out value="${emptyMessage }"/>
<c:choose>
	<c:when test="${clientOrder!=null && clientOrder.getOrderProducts().size()>0 }">

			<c:set var="totalPrice" value="0"/>
			<c:set var="totalQuantity" value="0"/>
		<c:forEach var="i" items="${clientOrder.getOrderProducts() }">
			<div class="container">		
				<p> Product Name: <c:out value="${i.getProduct().getName() }"/></p>
				<p> Quantity: <c:out value="${i.getQuantity() }"/></p>
				<p> Price: <c:out value="${i.getProduct().getPrice() }"/></p>
				<img src="${i.getProduct().getPictureUrl() }"/>
	
				<c:set var="totalPrice" value="${totalPrice+i.getProduct().getPrice() }"/> 
				<c:set var="totalQuantity" value="${totalQuantity+1 }"/> 
				<p><a href="/removeFromBasket/${i.getId()}">Remove from basket</a></p>
			</div>
		</c:forEach>
		
		
	</c:when>
	<c:otherwise>
		<p>Basket is empty</p>
	</c:otherwise>
</c:choose>



<p>
	<a href="checkoutBasket">Checkout</a>
</p>

<a href="/deleteBasket">Delete basket</a> |


<a href="/dashboard">Back to Dashboard</a>
</div>
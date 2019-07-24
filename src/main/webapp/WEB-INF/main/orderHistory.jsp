<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<link href="styles.css" rel="stylesheet"/>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<div class="container">
<h3>Your Orders</h3>
<c:choose>
	<c:when test="${clientOrders.size()>0}">
		<c:forEach var="i" items="${clientOrders }">
		<c:if test="${i.isCheckedOut() }">
			<div class="container">
				<p>
					Order Number: <a href="clientOrder/${i.getId() }""><c:out value="${i.getId() }"/></a>
				</p>
				<p>
					Date ordered: <c:out value="${i.getCreatedAt() }"/>
				</p>
				<p>
						Items Ordered:
					<c:forEach var="j" items="${i.getOrderProducts() }">
						<i>				
							<c:out value="${j.getProduct().getName() }"/> . 
						</i>		
						
					</c:forEach>
				</p>
			</div>
		</c:if>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<p>
			You have not created an order yet.
		</p>
	</c:otherwise>
</c:choose>


<a href="/dashboard">Back to Dashboard</a>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<link href="styles.css" rel="stylesheet"/>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">


<form:form action="/addProduct" method="post" modelAttribute="product">

    <p>
        <form:label path="name">Product Name:</form:label>
        <form:errors path="name"/>
        <form:input path="name"/>
	</p>
    <p>
        <form:label path="price">Price:</form:label>
        <form:errors path="price"/>
        <form:input path="price"/>
	</p>	
    <p>
        <form:label path="pictureUrl">Picture url:</form:label>
        <form:errors path="pictureUrl"/>
        <form:input path="pictureUrl"/>
	</p>	
	    <input type="submit" value="Create Product"/>
</form:form>

<a href="/dashboard">Back to dashboard</a>
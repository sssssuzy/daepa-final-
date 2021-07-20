<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="leftMenu">
	<div class="item"><a href="/product/best">BEST</a></div>
	<div class="item"><a href="/product/outer">OUTER</a></div>
	<div class="item"><a href="/product/top">TOP</a></div>
	<div class="item"><a href="/product/bottom">BOTTOM</a></div>
</div>
<div class="rightMenu">
	<div class="item"><a href="/order/cart">CART</a></div>
	<c:if test="${user.userid=='manager'}">
	<div class="item"><a href="/mall/list">MAll</a></div>		
	<div class="item"><a href="/product/list">PRODUCT</a></div>	
	</c:if>
	<div class="item"><a href="/purchase/list">ORDER</a></div>
	<div class="item"><a href="/community/list">Q/A</a></div>	
</div>
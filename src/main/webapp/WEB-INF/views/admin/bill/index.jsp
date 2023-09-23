<%@page import="tdtu.bookstore.model.Bill"%>
<%@page import="tdtu.bookstore.model.User"%>
<%@page import="tdtu.bookstore.repository.UserRepository"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%
UserRepository userRepository = (UserRepository) request.getAttribute("userRepository");
%>

<%!public String getUser(Integer userid, UserRepository userRepository) {

		User user = userRepository.findById(userid).get();
		return user.getUsername();
	}%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../../head.jsp"></jsp:include>
<title>Quản lý sách</title>
<style>
.book-price {
	color: red;
}
</style>
</head>

<body class="d-flex flex-column vh-100">
	<jsp:include page="../header.jsp"></jsp:include>


	<div class="d-flex px-4 py-1 bg-dark">
		<div class="col col-9 fs-4 fw-bold text-white">Quản lý hóa đơn</div>
	</div>

	<div class="overflow-auto">
		<table class="table table-hover table-striped">
			<thead>
				<tr class="table-secondary">
					<th scope="col">Id</th>
					<th scope="col">Tên người dùng</th>
					<th scope="col">Ngày đặt</th>
					<th scope="col">Tổng hóa đơn</th>
					<th scope="col">Trạng thái</th>
					<th scope="col">Thao tác</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${bills}" var="bill">
					<tr>
						<td>${bill.id}</td>
						<td><%=getUser(((Bill) pageContext.getAttribute("bill")).getUserid(), userRepository)%></td>
						<td>${bill.adddate}</td>
						<td><span class="book-price fw-bold">${bill.getTotalPriceString()}
								VND</span></td>
						<td><c:choose>
								<c:when test="${bill.status == 0}">
									Chưa giao hàng
								</c:when>
								<c:when test="${bill.status == -1}">
									Hủy giao hàng
								</c:when>
								<c:otherwise>
									Đã giao hàng
								</c:otherwise>
							</c:choose></td>
						<td>
							<button class="btn btn-primary" data-bs-toggle="modal"
								data-bs-target="#viewModal" onclick="view(${bill.id})">
								<i class="fa-solid fa-eye"></i>
							</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>


	<div class="modal fade modal-lg" id="viewModal" tabindex="-1">
		<form method="post" action="/admin/books" id="viewForm">
			<div class="modal-dialog"  id="modalBody">
				
			</div>
		</form>
	</div>
</body>

<script>
var curBillid = 0;

async function view(billid) {
	curBillid = billid;
	const response = await fetch('/admin/bills/'+billid);
	const billdetail = await response.text();
	$("#modalBody").html(billdetail);
}

function doneBill() {
    $.ajax({
        url: '/admin/bills/'+curBillid+'/done',
        type: 'post',
        success: (data) => {
        	if (data.includes("done_success")) {
        		window.location.replace("/admin/bills")
        	} else {
        		alert("Hoàn thành đơn thất bại")
        	}
        }
    });
}

function cancelBill() {
    $.ajax({
        url: '/admin/bills/'+curBillid+'/cancel',
        type: 'post',
        success: (data) => {
        	if (data.includes("done_success")) {
        		window.location.replace("/admin/bills")
        	} else {
        		alert("Hủy đơn thất bại")
        	}
        }
    });
}
</script>
</html>
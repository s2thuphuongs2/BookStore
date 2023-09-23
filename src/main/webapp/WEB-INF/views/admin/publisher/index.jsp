<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="../../head.jsp"></jsp:include>
<title>Quản lý nhà xuất bản</title>

</head>
<body class="d-flex flex-column vh-100">
	<jsp:include page="../header.jsp"></jsp:include>


	<div class="d-flex px-4 py-1 bg-dark">
		<div class="col col-9 fs-4 fw-bold text-white">Quản lý nhà xuất
			bản</div>

		<div class="col col-3 text-end">
			<button type="button" class="btn btn-success" data-bs-toggle="modal"
				data-bs-target="#addModal">Thêm nhà xuất bản</button>
		</div>
	</div>
	<div class="overflow-auto">
		<table class="table table-hover table-striped">
			<thead>
				<tr class="table-secondary">
					<th scope="col">Id</th>
					<th scope="col">Tên</th>
					<th scope="col">Thao tác</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${publishers}" var="publisher">
					<tr>
						<td>${publisher.id}</td>
						<td>${publisher.name}</td>
						<td>
							<button class="btn btn-primary" data-bs-toggle="modal"
								data-bs-target="#editModal"
								onclick="edit(${publisher.id}, '${publisher.name}')">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
							<button class="btn btn-danger" data-bs-toggle="modal"
								data-bs-target="#deleteModal"
								onclick="deleteId(${publisher.id}, '${publisher.name}')">
								<i class="fa-solid fa-trash"></i>
							</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>


	<div class="modal fade" id="addModal" tabindex="-1">
		<form method="post" action="/admin/publishers"
			enctype="multipart/form-data">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5">Thêm nhà xuất bản</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<label for="publisherName" class="form-label">Tên nhà
								xuất bản</label> <input type="text" class="form-control"
								id="publisherName" name="publisherName">
						</div>



					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-primary">Thêm</button>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div class="modal fade" id="editModal" tabindex="-1">
		<form id="editForm" method="post" enctype="multipart/form-data">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5">Chỉnh sửa nhà xuất bản</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<label class="form-label">Tên nhà xuất bản</label> <input
								type="text" class="form-control" id="publisherNameEdit"
								name="publisherName">
						</div>



					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-primary">Sửa</button>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div class="modal fade" id="deleteModal" tabindex="-1">
		<form id="deleteForm" method="post" enctype="multipart/form-data">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5">Xóa nhà xuất bản</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<label class="form-label">Tên nhà xuất bản</label> <input
								type="text" class="form-control" id="publisherNameDelete"
								name="publisherName" disabled>
						</div>



					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-danger">Xóa</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>

<script>

function edit(id, name) {
	$("#publisherNameEdit").val(name)
	$("#editForm").attr("action","/admin/publishers/"+id+"/edit")
}

function deleteId(id, name) {
	$("#publisherNameDelete").val(name)
	$("#deleteForm").attr("action","/admin/publishers/"+id+"/delete")
}
</script>
</html>
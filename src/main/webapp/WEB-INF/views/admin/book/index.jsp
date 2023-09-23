<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="../../head.jsp"></jsp:include>
<title>Quản lý sách</title>

</head>
<body class="d-flex flex-column vh-100">
	<jsp:include page="../header.jsp"></jsp:include>


	<div class="d-flex px-4 py-1 bg-dark">
		<div class="col col-9 fs-4 fw-bold text-white">Quản lý sách</div>

		<div class="col col-3 text-end">
			<button type="button" class="btn btn-success" data-bs-toggle="modal"
				data-bs-target="#addModal">Thêm sách</button>
		</div>
	</div>
	
	<div class="overflow-auto">
		<table class="table table-hover table-striped">
			<thead>
				<tr class="table-secondary">
					<th scope="col">Id</th>
					<th scope="col">Tên</th>
					<th scope="col">Tác giả</th>
					<th scope="col">Nhà xuất bản</th>
					<th scope="col">Thao tác</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${books}" var="book">
					<tr>
						<td>${book.id}</td>
						<td>${book.name}</td>
						<td>${authors.stream().filter(author -> book.authorid == author.id).findFirst().orElse(null).name}</td>
						<td>${publishers.stream().filter(publisher -> book.publisherid == publisher.id).findFirst().orElse(null).name}</td>
						<td>
							<button class="btn btn-primary" data-bs-toggle="modal"
								data-bs-target="#editModal" onclick="edit(${book.id})">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
							<button class="btn btn-danger" data-bs-toggle="modal"
								data-bs-target="#deleteModal" onclick="deleteId(${book.id})">
								<i class="fa-solid fa-trash"></i>
							</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>


	<div class="modal fade modal-lg" id="addModal" tabindex="-1">
		<form method="post" action="/admin/books"
			enctype="multipart/form-data">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5">Thêm nhà xuất bản</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<div class="row mb-3">
							<div class="col col-8">
								<label for="bookName" class="form-label">Tên sách</label> <input
									type="text" class="form-control" id="bookName" name="bookName">
							</div>

							<div class="col col-4">
								<label for="bookPrice" class="form-label">Giá sách</label> <input
									type="number" class="form-control" id="bookPrice"
									name="bookPrice">
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-8">
								<label for="bookSize" class="form-label">Kích thước</label> <input
									type="text" class="form-control" id="bookSize" name="bookSize">
							</div>

							<div class="col col-4">
								<label for="bookPage" class="form-label">Số trang</label> <input
									type="number" class="form-control" id="bookPage"
									name="bookPage">
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-12">
								<label for="bookCate" class="form-label">Thể loại</label> <select
									class="selectpicker form-control" multiple id="bookCate"
									name="bookCate" data-live-search="true"
									title="Chọn thể loại sách">
									<c:forEach items="${categories}" var="category">
										<option value="${category.id}">${category.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-6">
								<label for="bookAuthor" class="form-label">Tác giả</label> <select
									class="selectpicker form-control" id="bookAuthor"
									name="bookAuthor" data-live-search="true">
									<c:forEach items="${authors}" var="author">
										<option value="${author.id}">${author.name}</option>
									</c:forEach>
								</select>
							</div>

							<div class="col col-6">
								<label for="bookPubl" class="form-label">Nhà xuất bản</label> <select
									class="selectpicker form-control" id="bookPubl" name="bookPubl"
									data-live-search="true">
									<c:forEach items="${publishers}" var="publisher">
										<option value="${publisher.id}">${publisher.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-12">
								<label for="bookDesc" class="form-label">Mô tả sách</label>
								<textarea type="text" class="form-control" id="bookDesc"
									name="bookDesc"></textarea>
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-12">
								<label for="bookImage" class="form-label">Thêm ảnh</label> <input
									class="form-control" type="file" id="bookImage"
									name="bookImage">
							</div>
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

	<div class="modal fade modal-lg" id="editModal" tabindex="-1">
		<form id="editForm" method="post" enctype="multipart/form-data">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5">Chỉnh sửa sách</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<div class="row mb-3">
							<div class="col col-8">
								<label for="bookName" class="form-label">Tên sách</label> <input
									type="text" class="form-control" id="bookNameEdit"
									name="bookName">
							</div>

							<div class="col col-4">
								<label for="bookPrice" class="form-label">Giá sách</label> <input
									type="number" class="form-control" id="bookPriceEdit"
									name="bookPrice">
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-8">
								<label for="bookSize" class="form-label">Kích thước</label> <input
									type="text" class="form-control" id="bookSizeEdit"
									name="bookSize">
							</div>

							<div class="col col-4">
								<label for="bookPage" class="form-label">Số trang</label> <input
									type="number" class="form-control" id="bookPageEdit"
									name="bookPage">
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-12">
								<label for="bookCate" class="form-label">Thể loại</label> <select
									class="selectpicker form-control" multiple id="bookCateEdit"
									name="bookCate" data-live-search="true"
									title="Chọn thể loại sách">
									<c:forEach items="${categories}" var="category">
										<option value="${category.id}">${category.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-6">
								<label for="bookAuthor" class="form-label">Tác giả</label> <select
									class="selectpicker form-control" id="bookAuthorEdit"
									name="bookAuthor" data-live-search="true">
									<c:forEach items="${authors}" var="author">
										<option value="${author.id}">${author.name}</option>
									</c:forEach>
								</select>
							</div>

							<div class="col col-6">
								<label for="bookPubl" class="form-label">Nhà xuất bản</label> <select
									class="selectpicker form-control" id="bookPublEdit"
									name="bookPubl" data-live-search="true">
									<c:forEach items="${publishers}" var="publisher">
										<option value="${publisher.id}">${publisher.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-12">
								<label for="bookDesc" class="form-label">Mô tả sách</label>
								<textarea type="text" class="form-control" id="bookDescEdit"
									name="bookDesc"></textarea>
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-12">
								<label for="bookImage" class="form-label">Thêm ảnh</label> <input
									class="form-control" type="file" id="bookImage"
									name="bookImage">
							</div>
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

	<div class="modal fade modal-lg" id="deleteModal" tabindex="-1">
		<form id="deleteForm" method="post" enctype="multipart/form-data">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5">Xóa nhà sách</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<div class="row mb-3">
							<div class="col col-8">
								<label for="bookName" class="form-label">Tên sách</label> <input
									type="text" class="form-control" id="bookNameDelete"
									name="bookName" disabled>
							</div>

							<div class="col col-4">
								<label for="bookPrice" class="form-label">Giá sách</label> <input
									type="number" class="form-control" id="bookPriceDelete"
									name="bookPrice" disabled>
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-8">
								<label for="bookSize" class="form-label">Kích thước</label> <input
									type="text" class="form-control" id="bookSizeDelete"
									name="bookSize" disabled>
							</div>

							<div class="col col-4">
								<label for="bookPage" class="form-label">Số trang</label> <input
									type="number" class="form-control" id="bookPageDelete"
									name="bookPage" disabled>
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-12">
								<label for="bookCate" class="form-label">Thể loại</label> <select
									class="selectpicker form-control" multiple id="bookCateDelete"
									name="bookCate" data-live-search="true"
									title="Chọn thể loại sách" disabled>
									<c:forEach items="${categories}" var="category">
										<option value="${category.id}">${category.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-6">
								<label for="bookAuthor" class="form-label">Tác giả</label> <select
									class="selectpicker form-control" id="bookAuthorDelete"
									name="bookAuthor" data-live-search="true" disabled>
									<c:forEach items="${authors}" var="author">
										<option value="${author.id}">${author.name}</option>
									</c:forEach>
								</select>
							</div>

							<div class="col col-6">
								<label for="bookPubl" class="form-label">Nhà xuất bản</label> <select
									class="selectpicker form-control" id="bookPublDelete"
									name="bookPubl" data-live-search="true" disabled>
									<c:forEach items="${publishers}" var="publisher">
										<option value="${publisher.id}">${publisher.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="row mb-3">
							<div class="col col-12">
								<label for="bookDesc" class="form-label">Mô tả sách</label>
								<textarea type="text" class="form-control" id="bookDescDelete"
									disabled name="bookDesc"></textarea>
							</div>
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

async function edit(bookid) {
	const response = await fetch('/admin/books/'+bookid);
	const book = await response.json();

	$("#bookNameEdit").val(book.name)
	$("#bookPriceEdit").val(book.price)
	$("#bookSizeEdit").val(book.size)
	$("#bookPageEdit").val(book.page)
	
	$("#bookDescEdit").val(book.description)
	
	$("#bookCateEdit").val(book.category.split(","))
	$("#bookCateEdit").selectpicker("destroy")
	$("#bookCateEdit").selectpicker()
	
	$("#bookPublEdit").val(book.publisherid)
	$("#bookPublEdit").selectpicker("destroy")
	$("#bookPublEdit").selectpicker()
	
	$("#bookAuthorEdit").val(book.authorid)
	$("#bookAuthorEdit").selectpicker("destroy")
	$("#bookAuthorEdit").selectpicker()
	

	$("#editForm").attr("action","/admin/books/"+book.id+"/edit")
}

async function deleteId(bookid) {
	const response = await fetch('/admin/books/'+bookid);
	const book = await response.json();

	$("#bookNameDelete").val(book.name)
	$("#bookPriceDelete").val(book.price)
	$("#bookSizeDelete").val(book.size)
	$("#bookPageDelete").val(book.page)
	
	$("#bookDescDelete").val(book.description)
	
	$("#bookCateDelete").val(book.category.split(","))
	$("#bookCateDelete").selectpicker("destroy")
	$("#bookCateDelete").selectpicker()
	
	$("#bookPublDelete").val(book.publisherid)
	$("#bookPublDelete").selectpicker("destroy")
	$("#bookPublDelete").selectpicker()
	
	$("#bookAuthorDelete").val(book.authorid)
	$("#bookAuthorDelete").selectpicker("destroy")
	$("#bookAuthorDelete").selectpicker()
	
	$("#deleteForm").attr("action","/admin/books/"+book.id+"/delete")
}
</script>
</html>
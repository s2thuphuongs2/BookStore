///////////////////////////////////////////////// AUTHOR /////////////////////////////////////////////////////////////
function editAuthor(id, name) {
    $("#authorNameEdit").val(name)
    $("#editForm").attr("action","/admin/authors/"+id+"/edit")
}

function deleteAuthor(id, name) {
    $("#authorNameDelete").val(name)
    $("#deleteForm").attr("action","/admin/authors/"+id+"/delete")
}
///////////////////////////////////////////////// BILL /////////////////////////////////////////////////////////////
var curBillid = 0;

async function viewBill(billid) {
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
///////////////////////////////////////////////// BOOK /////////////////////////////////////////////////////////////
async function editBook(bookid) {
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

async function deleteBook(bookid) {
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
///////////////////////////////////////////////// CATEGORY /////////////////////////////////////////////////////////////
function editCategory(id, name) {
    $("#categoryNameEdit").val(name)
    $("#editForm").attr("action","/admin/categories/"+id+"/edit")
}

function deleteCategory(id, name) {
    $("#categoryNameDelete").val(name)
    $("#deleteForm").attr("action","/admin/categories/"+id+"/delete")
}
///////////////////////////////////////////////// PUBLISHER /////////////////////////////////////////////////////////////
function editPublisher(id, name) {
    $("#publisherNameEdit").val(name)
    $("#editForm").attr("action","/admin/publishers/"+id+"/edit")
}

function deletePublisher(id, name) {
    $("#publisherNameDelete").val(name)
    $("#deleteForm").attr("action","/admin/publishers/"+id+"/delete")
}
///////////////////////////////////////////////// USER /////////////////////////////////////////////////////////////
function editUser(id) {
    $("#editForm").attr("action","/admin/users/"+id+"/edit")
}
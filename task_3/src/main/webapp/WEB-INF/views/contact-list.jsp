<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Manager</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f4f6f9; padding: 30px; }
        h1 { margin-bottom: 20px; color: #333; }
        .toast { background: #28a745; color: #fff; padding: 12px 20px; border-radius: 6px; margin-bottom: 20px; }
        .search-form { display: flex; gap: 8px; margin-bottom: 16px; }
        .search-form input { flex: 1; padding: 10px; border: 1px solid #ccc; border-radius: 6px; font-size: 14px; }
        .search-form button { padding: 10px 18px; background: #4a6cf7; color: #fff; border: none; border-radius: 6px; cursor: pointer; }
        .search-form a { padding: 10px 14px; color: #555; text-decoration: none; border: 1px solid #ccc; border-radius: 6px; }
        table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,.1); }
        th { background: #4a6cf7; color: #fff; padding: 12px; text-align: left; }
        td { padding: 11px 12px; border-bottom: 1px solid #eee; font-size: 14px; }
        tr:last-child td { border-bottom: none; }
        .empty { text-align: center; color: #999; padding: 30px; background: #fff; border-radius: 8px; }
        .fab { position: fixed; bottom: 30px; right: 30px; background: #4a6cf7; color: #fff;
               border-radius: 50px; padding: 14px 24px; text-decoration: none; font-size: 15px;
               box-shadow: 0 4px 12px rgba(74,108,247,.4); }
        .fab:hover { background: #3657d9; }
        .pagination { margin-top: 16px; display: flex; gap: 8px; }
        .pagination button { padding: 7px 14px; border: 1px solid #ccc; border-radius: 4px; cursor: pointer; background: #fff; }
        .pagination button.active { background: #4a6cf7; color: #fff; border-color: #4a6cf7; }
    </style>
</head>
<body>

<h1>📋 Contacts</h1>

<c:if test="${not empty sessionScope.success}">
    <div class="toast">${sessionScope.success}</div>
    <c:remove var="success" scope="session"/>
</c:if>

<form class="search-form" action="${pageContext.request.contextPath}/contacts" method="get">
    <input type="text" name="search" value="<c:out value='${search}'/>" placeholder="Search by name or email...">
    <button type="submit">Search</button>
    <c:if test="${not empty search}">
        <a href="${pageContext.request.contextPath}/contacts">Clear</a>
    </c:if>
</form>

<c:choose>
    <c:when test="${empty contacts}">
        <div class="empty">
            <c:choose>
                <c:when test="${not empty search}">No contacts found for "<c:out value='${search}'/>". <a href="${pageContext.request.contextPath}/contacts">Show all</a></c:when>
                <c:otherwise>No contacts yet. Click ➕ to add one.</c:otherwise>
            </c:choose>
        </div>
    </c:when>
    <c:otherwise>
        <table id="contactTable">
            <thead>
                <tr><th>#</th><th>Name</th><th>Email</th><th>Phone</th><th>Added</th></tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${contacts}" varStatus="s">
                <tr>
                    <td>${s.index + 1}</td>
                    <td><c:out value="${c.name}"/></td>
                    <td><c:out value="${c.email}"/></td>
                    <td><c:out value="${c.phone}"/></td>
                    <td>${c.createdAt}</td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="pagination" id="pagination"></div>
    </c:otherwise>
</c:choose>

<a href="${pageContext.request.contextPath}/contacts/add" class="fab">➕ Add Contact</a>

<script>
    const rowsPerPage = 5;
    let currentPage = 1;
    const tbody = document.querySelector('#contactTable tbody');
    const allRows = tbody ? Array.from(tbody.querySelectorAll('tr')) : [];

    function renderPage() {
        if (!tbody) return;
        allRows.forEach((r, i) => r.style.display = (i >= (currentPage-1)*rowsPerPage && i < currentPage*rowsPerPage) ? '' : 'none');
        const pages = Math.ceil(allRows.length / rowsPerPage) || 1;
        const pg = document.getElementById('pagination');
        pg.innerHTML = '';
        for (let i = 1; i <= pages; i++) {
            const btn = document.createElement('button');
            btn.textContent = i;
            if (i === currentPage) btn.classList.add('active');
            btn.onclick = () => { currentPage = i; renderPage(); };
            pg.appendChild(btn);
        }
    }
    renderPage();
</script>
</body>
</html>

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
        table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,.1); }
        th { background: #4a6cf7; color: #fff; padding: 12px; text-align: left; }
        td { padding: 11px 12px; border-bottom: 1px solid #eee; }
        tr:last-child td { border-bottom: none; }
        .empty { text-align: center; color: #999; padding: 30px; background: #fff; border-radius: 8px; }
        .search-bar { margin-bottom: 16px; width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px; font-size: 14px; }
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

<input class="search-bar" type="text" id="searchInput" placeholder="Search contacts..." onkeyup="filterTable()">

<c:choose>
    <c:when test="${empty contacts}">
        <div class="empty">No contacts yet. Click ➕ to add one.</div>
    </c:when>
    <c:otherwise>
        <table id="contactTable">
            <thead>
                <tr><th>#</th><th>Name</th><th>Email</th><th>Phone</th></tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${contacts}" varStatus="s">
                <tr>
                    <td>${s.index + 1}</td>
                    <td><c:out value="${c.name}"/></td>
                    <td><c:out value="${c.email}"/></td>
                    <td><c:out value="${c.phone}"/></td>
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
    const table = document.getElementById('contactTable');
    const tbody = table ? table.querySelector('tbody') : null;
    const allRows = tbody ? Array.from(tbody.querySelectorAll('tr')) : [];

    function renderPage() {
        if (!tbody) return;
        const visible = allRows.filter(r => r.style.display !== 'none');
        visible.forEach((r, i) => r.style.display = (i >= (currentPage-1)*rowsPerPage && i < currentPage*rowsPerPage) ? '' : 'none');
        const pages = Math.ceil(visible.length / rowsPerPage) || 1;
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

    function filterTable() {
        const q = document.getElementById('searchInput').value.toLowerCase();
        allRows.forEach(r => r.style.display = r.textContent.toLowerCase().includes(q) ? '' : 'none');
        currentPage = 1;
        renderPage();
    }

    renderPage();
</script>
</body>
</html>

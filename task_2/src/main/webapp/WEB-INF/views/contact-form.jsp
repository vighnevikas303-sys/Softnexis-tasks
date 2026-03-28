<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Contact</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f4f6f9; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
        .card { background: #fff; padding: 36px; border-radius: 10px; box-shadow: 0 4px 16px rgba(0,0,0,.1); width: 420px; }
        h2 { margin-bottom: 24px; color: #333; }
        .field { margin-bottom: 18px; }
        label { display: block; margin-bottom: 5px; font-size: 14px; color: #555; }
        input { width: 100%; padding: 10px 12px; border: 1px solid #ccc; border-radius: 6px; font-size: 14px; }
        input.invalid { border-color: #e53935; background: #fff6f6; }
        .err { color: #e53935; font-size: 12px; margin-top: 4px; }
        button[type=submit] { width: 100%; padding: 12px; background: #4a6cf7; color: #fff; border: none; border-radius: 6px; font-size: 15px; cursor: pointer; position: relative; }
        button[type=submit]:hover { background: #3657d9; }
        .spinner { display: none; width: 16px; height: 16px; border: 2px solid #fff; border-top-color: transparent; border-radius: 50%; animation: spin .6s linear infinite; margin-left: 8px; vertical-align: middle; }
        @keyframes spin { to { transform: rotate(360deg); } }
        .back { display: inline-block; margin-top: 14px; color: #4a6cf7; text-decoration: none; font-size: 14px; }
    </style>
</head>
<body>
<div class="card">
    <h2>Add New Contact</h2>

    <form action="${pageContext.request.contextPath}/contacts/add" method="post" onsubmit="handleSubmit(event)">

        <div class="field">
            <label for="name">Name *</label>
            <input type="text" id="name" name="name" value="<c:out value='${name}'/>"
                   class="${not empty errors.name ? 'invalid' : ''}" autofocus>
            <c:if test="${not empty errors.name}"><div class="err">${errors.name}</div></c:if>
        </div>

        <div class="field">
            <label for="email">Email *</label>
            <input type="text" id="email" name="email" value="<c:out value='${email}'/>"
                   class="${not empty errors.email ? 'invalid' : ''}">
            <c:if test="${not empty errors.email}"><div class="err">${errors.email}</div></c:if>
        </div>

        <div class="field">
            <label for="phone">Phone</label>
            <input type="text" id="phone" name="phone" value="<c:out value='${phone}'/>"
                   class="${not empty errors.phone ? 'invalid' : ''}" maxlength="10" placeholder="10 digits">
            <c:if test="${not empty errors.phone}"><div class="err">${errors.phone}</div></c:if>
        </div>

        <button type="submit" id="submitBtn">
            Submit <span class="spinner" id="spinner"></span>
        </button>
    </form>

    <a href="${pageContext.request.contextPath}/contacts" class="back">← Back to Contacts</a>
</div>

<script>
    // Auto-focus first invalid field
    const invalid = document.querySelector('input.invalid');
    if (invalid) invalid.focus();

    function handleSubmit(e) {
        document.getElementById('spinner').style.display = 'inline-block';
        document.getElementById('submitBtn').disabled = true;
    }
</script>
</body>
</html>

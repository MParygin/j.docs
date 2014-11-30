<%@ page import="nsbm.Meta" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="n"%>
<%@ taglib tagdir="/WEB-INF/tags/fw/page" prefix="p"%>
<%
    request.setCharacterEncoding("UTF-8");

    String md5 = request.getParameter("md5");

    String serie = request.getParameter("serie");
    String title = request.getParameter("title");
    String isbn = request.getParameter("isbn");
    String edition = request.getParameter("edition");
    String year = request.getParameter("year");
    String keywords = request.getParameter("keywords");
    String author = request.getParameter("author");
    String type = request.getParameter("type");
    String vendor = request.getParameter("vendor");
    String press = request.getParameter("press");
    if (title != null && keywords != null) {

        Meta meta = library.MetaCenter.meta(md5);

        meta.serie = serie.trim();
        meta.title = title.trim();
        meta.isbn = isbn.trim();
        meta.edition = edition.trim();
        meta.year = year.trim();
        meta.keywords = keywords.trim();
        meta.author = author.trim();
        meta.vendor = vendor.trim();
        meta.press = press.trim();
        meta.type = type.trim();

        // update meta
        library.MetaCenter.setMeta(md5, meta);

        response.sendRedirect("update.jsp?md5=" + md5);
        return;
    }

    Meta meta = library.MetaCenter.meta(md5);

    serie = meta.serie;
    title = meta.title;
    isbn = meta.isbn;
    edition = meta.edition;
    year = meta.year;
    keywords = meta.keywords;
    author = meta.author;
    vendor = meta.vendor;
    press = meta.press;
    type = meta.type;

%>
<html>
    <n:head/>
    <body>

    <n:tools/>

<form action="update.jsp" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="md5" value="<%=md5%>"/>

    <table class="st">
        <thead>
        <col width="20%"/>
        <col width="60%"/>
        <col width="20%"/>
        </thead>

    <tr class="sth">
                <td>Файл:</td>
                <td><a href='download?md5=<%=md5%>' target=d >Download</a>,<a href='upload.jsp?md5=<%=md5%>' target=d >Clone</a></td>
                <td></td>
    </tr>

    <tr class="sth">
                <td>Автор:</td>
                <td><input style="width: 100%" type="text" name="author" value="<%=author%>"/></td>
                <td></td>
    </tr>

    <tr class="sth">
                <td>Серия:</td>
                <td><input style="width: 100%" type="text" id="serie" name="serie" value="<%=serie%>"/></td>
                <td><select onchange="document.getElementById('serie').value=this.value;"><n:serie/></select></td>
    </tr>

     <tr class="sth">
                <td>Заголовок:</td>
                <td><input style="width: 100%" type="text" name="title" value="<%=title%>"/></td>
                <td></td>
    </tr>

     <tr class="sth">
                <td>Производитель:</td>
                <td><input style="width: 100%" type="text" id="vendor" name="vendor" value="<%=vendor%>"/></td>
                <td><select style="width: 100%" onchange="document.getElementById('vendor').value=this.value;"><n:vendor/></select></td>
    </tr>

     <tr class="sth">
                <td>Издательство:</td>
                <td><input style="width: 100%" type="text" id="press" name="press" value="<%=press%>"/></td>
                <td><select style="width: 100%" onchange="document.getElementById('press').value=this.value;"><n:press/></select></td>
    </tr>

     <tr class="sth">
                <td>Тэги:</td>
                <td><input style="width: 100%" type="text" name="keywords" value="<%=keywords%>"/></td>
                <td></td>
    </tr>

     <tr class="sth">
                <td>ISBN:</td>
                <td><input style="width: 100%" type="text" name="isbn" value="<%=isbn%>"/></td>
                <td></td>
    </tr>

     <tr class="sth">
                <td>Редакция:</td>
                <td><input style="width: 100%" type="text" name="edition" value="<%=edition%>"/></td>
                <td></td>
    </tr>

     <tr class="sth">
                <td>Тип:</td>
                <td><input style="width: 100%" type="text" id="type" name="type" value="<%=type%>"/></td>
                <td><select style="width: 100%" onchange="document.getElementById('type').value = this.value;"><n:types/></select></td>
    </tr>

     <tr class="sth">
                <td>Год:</td>
                <td><input style="width: 100%" type="text" name="year" value="<%=year%>"/></td>
                <td></td>
    </tr>

     <tr class="sth">
                <td></td>
                <td><input type="submit" value="Исправить"/></td>
                <td></td>
    </tr>

    </table>
</form>


</body>
</html>
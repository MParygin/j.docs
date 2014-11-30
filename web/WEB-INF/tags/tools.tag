<%@tag pageEncoding="UTF-8" %>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">Boookle</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="upload.jsp">Заливка</a></li>
            </ul>

            <form class="navbar-form navbar-left" role="search" action="index.jsp" method="POST" enctype="multipart/form-data">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Формула поиска" name="text" value='<%=application.getAttribute("text")%>'>
                </div>
                <button type="submit" class="btn btn-default">Поиск</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <li></li>
                <li></li>
                <li><a href="keywords.jsp">Теги</a></li>
                <li><a href="serie.jsp">Серии</a></li>
                <li><a href="type.jsp">Типы</a></li>
                <li><a href="author.jsp">Авторы</a></li>
                <li><a href="press.jsp">Издательства</a></li>
                <li><a href="vendor.jsp">Производители</a></li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>

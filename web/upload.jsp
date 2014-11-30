<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="n"%>
<%@ taglib tagdir="/WEB-INF/tags/fw/page" prefix="p"%>
<html>
    <n:head/>
    <body>
      <n:tools/>

      <%

        String serie = "";
        String title = "";
        String isbn = "";
        String edition = "";
        String year = "";
        String keywords = "";
        String author = "";
        String vendor = "";
        String type = "";
        String press = "";

        String md5 = request.getParameter("md5");
        if (md5 != null && md5.length() > 0) {
            nsbm.Meta meta = library.MetaCenter.meta(md5);
            serie = meta.serie;
            title = meta.title;
            isbn = meta.isbn;
            edition = meta.edition;
            year = meta.year;
            keywords = meta.keywords;
            author = meta.author;
            vendor = meta.vendor;
            type = meta.type;
            press = meta.press;
        }
      %>

      <form action="/upload" method="POST" enctype="multipart/form-data" id="main">

        <table class="st">

            <thead>
                <col width="20%"/>
                <col width="60%"/>
                <col width="20%"/>
            </thead>

            <!--tr class="sth">
                <td style="width: 15%;">Файл:</td>
                <td><input style="width: 100%" type="text" name="file" id="file"/></td>
                <td></td>
            </tr-->
            <tr class="sth">
                <td>Автор:</td>
                <td><input style="width: 100%"  type="text" name="author" id="author" value="<%=author%>" /></td>
                <td></td>
            </tr>
            <tr class="sth">
                <td>Серия:</td>
                <td><input style="width: 100%"  type="text" name="serie" id="serie" value="<%=serie%>" /></td>
                <td><select onchange="document.getElementById('serie').value=this.value;"><n:serie/></select></td>
            </tr>
            <tr class="sth">
                <td>Заголовок:</td>
                <td><input style="width: 100%"  type="text" name="title" id="title" value="<%=title%>" /></td>
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
                <td><input style="width: 100%"  type="text" name="keywords" id="keywords" value="<%=keywords%>" /></td>
                <td></td>
            </tr>
            <tr class="sth">
                <td>ISBN:</td>
                <td><input style="width: 100%"  type="text" name="isbn" id="isbn" value="<%=isbn%>" /></td>
                <td></td>
            </tr>
            <tr class="sth">
                <td>Редакция:</td>
                <td><input style="width: 100%"  type="text" name="edition" id="edition" value="<%=edition%>" /></td>
                <td></td>
            </tr>
            <tr class="sth">
                <td>Год:</td>
                <td><input style="width: 100%"  type="text" name="year" id="year" value="<%=year%>" /></td>
                <td></td>
            </tr>
            <tr class="sth">
                <td>Тип:</td>
                <td><input style="width: 100%" type="text" id="type" name="type" value="<%=type%>"/></td>
                <td><select style="width: 100%" onchange="document.getElementById('type').value = this.value;"><n:types/></select></td>
            </tr>
            <tr class="sth">
                <td>Файл:</td>
                <td><input style="width: 100%"  type="file" name="data" id="data"/></td>
                <td><!--p onclick="fcheck();" value="...">...</p--></td>
            </tr>
            <!--tr class="sth">
                <td>Ссылка:</td>
                <td><input style="width: 100%"  type="text" name="link" id="link"/></td>
                <td></td>
            </tr-->
            <tr class="sth">
                <td></td>
                <td><input style="width: 100%"  type="submit" value="Залить"/></td>
                <td></td>
            </tr>

        </table>


        <script type="text/javascript">
            function fcheck() {
                var ffile = document.getElementById("data").value;
                if (ffile.indexOf("fakepath", 0) != -1) ffile = ffile.substr(12, ffile.length - 12);
                var p = ffile.lastIndexOf('.');
                var file = ffile.substring(0, p).toLowerCase();
                var extension = ffile.substring(p + 1, ffile.length).toLowerCase();
                document.getElementById("file").value = file + '.' + extension;
            }
        </script>

    </form>


    </body>
</html>
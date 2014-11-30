<%@page import="org.apache.lucene.analysis.Analyzer" %>
<%@page import="org.apache.lucene.document.Document" %>
<%@page import="org.apache.lucene.document.Field" %>
<%@ page import="org.apache.lucene.index.IndexReader" %>
<%@ page import="org.apache.lucene.index.IndexWriter" %>
<%@ page import="org.apache.lucene.search.IndexSearcher" %>
<%@ page import="org.apache.lucene.search.TopDocs" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="n" %>
<%@ taglib tagdir="/WEB-INF/tags/fw/panel" prefix="l" %>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<n:head/>
<%

    int offset = nsbm.Utils.getParameterAsInt(request, "offset", 0);
    int limit = nsbm.Utils.getParameterAsInt(request, "limit", 20);
    String text = request.getParameter("text");

    // rewrite by keywords ?
    {
        String _ = request.getParameter("keywords");
        if (_ != null) {
            text = "keywords:" + _;
        }
    }

    // rewrite by type ?
    {
        String _ = request.getParameter("type");
        if (_ != null) {
            text = "type:" + _;
        }
    }

    // rewrite by vendor ?
    {
        String _ = request.getParameter("vendor");
        if (_ != null) {
            text = "vendor:" + _;
        }
    }

    // rewrite by serie ?
    {
        String _ = request.getParameter("serie");
        if (_ != null) {
            text = "serie:\"" + _ + "\"";
        }
    }

    // rewrite by author ?
    {
        String _ = request.getParameter("author");
        if (_ != null) {
            text = "author:\"" + _ + "\"";
        }
    }

    // rewrite by press ?
    {
        String _ = request.getParameter("press");
        if (_ != null) {
            text = "press:\"" + _ + "\"";
        }
    }

    // last
    if (text == null) {
        String last = (String) application.getAttribute("last");
        if (last != null) {
            text = last;
        } else {
            text = "";
        }
    } else {
        application.setAttribute("last", text);
    }
    application.setAttribute("text", text);


    System.out.println("--[");
    System.out.println("--[ " + text);
    System.out.println("--[");


    //text = "author:евстифеев";
%>
<body>
<div class="container-fluid">
<div class="row">
    <div class="col-md-12">
        <n:tools/>
    </div>
</div>
<div class="row">
<div class="col-md-12">

<%

    IndexWriter writer = new IndexWriter(
            org.apache.lucene.store.FSDirectory.open(new java.io.File("/tmp")),
            new org.apache.lucene.analysis.standard.StandardAnalyzer(org.apache.lucene.util.Version.LUCENE_CURRENT),
            true,
            IndexWriter.MaxFieldLength.LIMITED
    );

    for (String key : library.MetaCenter.ids()) {
        nsbm.Meta meta = library.MetaCenter.meta(key);
        Document doc = new Document();
        doc.add(new Field("md5", key, Field.Store.YES, Field.Index.ANALYZED));
        doc.add(new Field("author", meta.author, Field.Store.YES, Field.Index.ANALYZED));
        doc.add(new Field("title", meta.title, Field.Store.YES, Field.Index.ANALYZED));
        doc.add(new Field("serie", meta.serie, Field.Store.YES, Field.Index.ANALYZED));
        doc.add(new Field("keywords", meta.keywords, Field.Store.YES, Field.Index.ANALYZED));
        doc.add(new Field("type", meta.type, Field.Store.YES, Field.Index.ANALYZED));
        doc.add(new Field("vendor", meta.vendor, Field.Store.YES, Field.Index.ANALYZED));
        doc.add(new Field("press", meta.press, Field.Store.YES, Field.Index.ANALYZED));
        doc.add(new Field("year", meta.year, Field.Store.YES, Field.Index.ANALYZED));
        writer.addDocument(doc);
    }
    System.out.println("Stop");


    writer.optimize();
    writer.close();

    // store
    // application.setAttribute("index", writer);
    //}

    System.out.println(System.getProperty("temp.dir"));

    IndexReader reader = IndexReader.open(org.apache.lucene.store.FSDirectory.open(new java.io.File("/tmp")), true);
    IndexSearcher searcher = new IndexSearcher(reader);
    Analyzer analyzer = new org.apache.lucene.analysis.standard.StandardAnalyzer(org.apache.lucene.util.Version.LUCENE_CURRENT);
    org.apache.lucene.queryParser.QueryParser queryParser =
            new org.apache.lucene.queryParser.QueryParser(org.apache.lucene.util.Version.LUCENE_CURRENT, "title", analyzer);

    org.apache.lucene.search.Query qu = null;
    try {
        qu = queryParser.parse(text);
    } catch (Exception e) {
        e.printStackTrace();
%>

<p>Ошибка при разборе запроса</p>


<%
    }

    if (qu != null) {

        System.out.println("QP  " + qu);


        TopDocs top = searcher.search(qu, 10000);
        System.out.println("--> " + top);
        System.out.println("--> " + top.totalHits + " " + top.getMaxScore());


%>


<script type="text/javascript">
    function hd(id, value) {
        //var e = document.getElementById(id);
        //e.innerHTML = value;
        window.open('select.jsp?id=' + id + '&tag=&value=' + value, 'ajax');
    }
</script>


<div class="panel panel-primary">
    <div class="panel-heading">
        Выбрать: <a href="index.jsp?type=all">Все</a>, <a href="index.jsp?type=none">ничего</a>
        Hits: <%=top.totalHits%>
        <%
            for (int i = 0; i < top.totalHits; i += 50) {
        %>[<a href="index.jsp?offset=<%=i%>"><%=i%>-<%=i + 49%>
    </a>]<%
        }
    %>
    </div>
    <div class="panel-body">


        <table class="table">

            <%
                int to = Math.min(top.totalHits, offset + 50);
                for (int i = offset; i < to; i++) {
                    Document doc = searcher.doc(top.scoreDocs[i].doc);
                    String author = doc.get("author");
                    String vendor = doc.get("vendor");
                    String title = doc.get("title");
                    String year = doc.get("year");
                    if (year != null && year.length() > 0) {
                        title = title + " (" + year + ")";
                    }
                    String serie = doc.get("serie");
                    String type = doc.get("type");
                    String keywords = doc.get("keywords");
                    String md5 = doc.get("md5");
                    // check
                    if (author.isEmpty() && !vendor.isEmpty())
                        author = "<a href='index.jsp?vendor=" + vendor + "' class=sk >(" + vendor + ")</a>";
                    if (author.isEmpty() && !serie.isEmpty())
                        author = "<a href='index.jsp?serie=" + serie + "' class=sk >(" + serie + ")</a>";

            %>


            <tr>
                <td width="1%"><img src="img/dots.png" border="0"/></td>
                <td width="1%"><input type="checkbox" id="c" onclick="javascript:hd(this.id, this.checked);"></td>
                <td width="18%"><%=author%>
                </td>
                <td width="1%"><a href='update.jsp?md5=<%=md5%>'><img src="img/open.png" border="0"/></a></td>
                <td width="45%"><a href='download?md5=<%=md5%>' target=d class="sk"><%=title%>
                </a></td>
                <td width="1%"><img src="img/dots.png" border="0"/></td>
                <td width="35%"><%
                    String[] keys = keywords.split("\\ ");
                    for (String key : keys) {
                %><a href="index.jsp?keywords=<%=key%>" class="sk"><%=key%>
                </a> <%
                    }
                %></td>
                <td width="1%"><img src="img/type-<%=type%>.png" border="0"/></td>
                <td width="1%"><a href='download?md5=<%=md5%>' target=d><img src="img/attach.png" border="0"
                                                                             title="Скачать локально"/></a></td>
                <td width="1%">
                    <!--a href='to-cloud.jsp' target='to-cloud'><img src="img/to-cloud.png" border="0" title="На облако"/></a--></td>
                <td width="1%"><a href='remove?md5=<%=md5%>' title="Удалить"><img src="img/remove.png" border="0"/></a>
                </td>
            </tr>


            <%
                }
            %>
        </table>
    </div>
    <div class="panel-footer">
        <n:foot/>
    </div>
</div>


<%
    }
%>


</div>
</div>
</div>

</body>
</html>

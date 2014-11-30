<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctype = request.getParameter("type");
    if (ctype == null) {
        ctype = (String) session.getAttribute("ctype");
    }

%>
<select name="type" id="type">
    <option value=""></option>
    <option value="Datasheet" <% if ("Datasheet".equals(ctype)) out.print("selected=true"); %>>Datasheet</option>
    <option value="AppNote" <% if ("AppNote".equals(ctype)) out.print("selected=true"); %>>Application Note</option>
    <option value="AppNoteCode" <% if ("AppNoteCode".equals(ctype)) out.print("selected=true"); %>>Application Note Code</option>
    <option value="Summary" <% if ("Summary".equals(ctype)) out.print("selected=true"); %>>Summary</option>
    <option value="Preliminary" <% if ("Preliminary".equals(ctype)) out.print("selected=true"); %>>Preliminary</option>
    <option value="PreliminarySummary" <% if ("PreliminarySummary".equals(ctype)) out.print("selected=true"); %>>Preliminary Summary</option>
    <option value="Errata" <% if ("Errata".equals(ctype)) out.print("selected=true"); %>>Errata</option>
    <option value="Book" <% if ("Book".equals(ctype)) out.print("selected=true"); %>>Book</option>
    <option value="BookCode" <% if ("BookCode".equals(ctype)) out.print("selected=true"); %>>Book Code</option>
    <option value="Journal" <% if ("Journal".equals(ctype)) out.print("selected=true"); %>>Journal</option>
    <option value="JournalCover" <% if ("JournalCover".equals(ctype)) out.print("selected=true"); %>>Journal Cover</option>
    <option value="Article" <% if ("Article".equals(ctype)) out.print("selected=true"); %>>Article</option>
    <option value="Manual" <% if ("Manual".equals(ctype)) out.print("selected=true"); %>>Manual</option>
    <option value="Specification" <% if ("Specification".equals(ctype)) out.print("selected=true"); %>>Specification</option>
</select>

<%@ tag pageEncoding="UTF-8" %>
<%
    String sum = org.apache.commons.io.FileUtils.byteCountToDisplaySize(library.MetaCenter.count);
    long cnt = (long)library.MetaCenter.ids().length;
%>
Объем: <%=sum%>, Количество: <%=cnt%>
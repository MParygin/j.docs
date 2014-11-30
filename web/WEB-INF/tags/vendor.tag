<%@ tag pageEncoding="UTF-8" %>
<%
    java.util.Set<String> list = new java.util.HashSet<String>();

    for (String key : library.MetaCenter.ids()) {
        nsbm.Meta meta = library.MetaCenter.meta(key);
        String serie = meta.vendor;
        if ((serie == null) || serie.isEmpty()) continue;
        list.add(serie);
    }
    String[] strs = list.toArray(new String[list.size()]);

    java.util.Arrays.sort(strs);

    for (String str : list) {
        out.print("<option>");
        out.print(str);
        out.print("</option>");
    }
%>

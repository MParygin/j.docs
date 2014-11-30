<%@tag pageEncoding="UTF-8" description="Vendors" %>
 |
  <%
  java.util.Set<String> list = new java.util.HashSet<String>();

    for (String key : library.MetaCenter.ids()) {
        nsbm.Meta meta = library.MetaCenter.meta(key);
        String str = meta.vendor;
        if ((str == null) || str.isEmpty()) continue;
        list.add(str);
    }

         String[] l = list.toArray(new String[list.size()]);
      java.util.Arrays.sort(l);
      for (String item : l) {
         %><a href="index.jsp?vendor=<%=item%>" class="sk"><%=item%></a> | <%
      }
  %>
<%@tag pageEncoding="UTF-8" description="Types" %>
 | <%
    java.util.Set<String> list = new java.util.HashSet<String>();

    for (String key : library.MetaCenter.ids()) {
        nsbm.Meta meta = library.MetaCenter.meta(key);
        String str = meta.type;
        if ((str == null) || str.isEmpty()) continue;
        list.add(str);
    }

      String[] l = list.toArray(new String[list.size()]);
      java.util.Arrays.sort(l);
      for (String item : l) {
            %><a href="index.jsp?type=<%=item%>" class="sk"><%=item%></a> | <%
      }
  %>
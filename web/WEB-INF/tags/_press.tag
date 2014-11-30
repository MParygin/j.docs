<%@tag pageEncoding="UTF-8" description="Press" %>
 | <%
    java.util.Set<String> list = new java.util.HashSet<String>();

    for (String key : library.MetaCenter.ids()) {
        nsbm.Meta meta = library.MetaCenter.meta(key);
        String str = meta.press;
        if ((str == null) || str.isEmpty()) continue;
        list.add(str);
    }

      String[] l = list.toArray(new String[list.size()]);
      java.util.Arrays.sort(l);
      for (String item : l) {
          %><a href="index.jsp?press=<%=item%>" class="sk"><%=item%></a> | <%
      }
  %>
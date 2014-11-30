<%@tag pageEncoding="UTF-8" description="Authors" %>
 | <%
    java.util.Set<String> unique = new java.util.HashSet<String>();

    for (String key : library.MetaCenter.ids()) {
        nsbm.Meta meta = library.MetaCenter.meta(key);
        String str = meta.author;
        if ((str == null) || str.isEmpty()) continue;
        String[] tags = str.split("\\,");
        for (String tag : tags) {
           unique.add(tag.trim());
        }
    }

      String[] l = unique.toArray(new String[unique.size()]);
      java.util.Arrays.sort(l);
      for (String item : l) {
          %><a href="index.jsp?author=<%=item%>" class="sk"><%=item%></a> | <%
      }
  %>
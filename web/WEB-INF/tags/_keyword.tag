 | <%
    java.util.Set<String> unique = new java.util.HashSet<String>();

    for (String key : library.MetaCenter.ids()) {
        nsbm.Meta meta = library.MetaCenter.meta(key);
        String keywords = meta.keywords;
        if ((keywords == null) || keywords.isEmpty()) continue;
        String[] tags = keywords.split("\\ ");
        for (String tag : tags) {
           unique.add(tag);
        }
    }

      String[] l = unique.toArray(new String[unique.size()]);
      java.util.Arrays.sort(l);
      for (String item : l) {
            %><a href="index.jsp?keywords=<%=item%>" class="sk"><%=item%></a> | <%
      }
            %>
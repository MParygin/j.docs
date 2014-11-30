<%@tag pageEncoding="UTF-8" description="Series"%>
<%


    java.util.Set<String> list = new java.util.HashSet<String>();

    for (String key : library.MetaCenter.ids()) {
        nsbm.Meta meta = library.MetaCenter.meta(key);
        String serie = meta.serie;
        if ((serie == null) || serie.isEmpty()) continue;
        list.add(serie);
    }


      for (String item : list) {
         %><a href="index.jsp?serie=<%=item%>" class="sk"><%=item%></a> | <%
      }
  %>
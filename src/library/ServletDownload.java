package library;

import nsbm.Meta;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="download", urlPatterns={"/download"})
public class ServletDownload extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String md5 = request.getParameter("md5");
        if (md5 == null) return;

        byte[] data = MetaCenter.getContent(md5);
        String mime = library.Recognizer.getMIMEByContent(data);
        String ext = library.Recognizer.getExtensionByMIME(mime);
        Meta meta = library.MetaCenter.meta(md5);

        StringBuilder fname = new StringBuilder();
        if (meta.author != null && meta.author.length() > 0) fname.append(meta.author).append(' ');
        fname.append(meta.title);
        if (meta.year != null && meta.year.length() > 0) fname.append('(').append(meta.year).append(')');
        fname.append('.');
        fname.append(ext);

        response.setContentType(mime);
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fname + "\"");
        response.setContentLength(data.length);

        ServletOutputStream sos = response.getOutputStream();
        sos.write(data);
    }
}

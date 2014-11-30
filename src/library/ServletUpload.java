package library;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.FileUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

@WebServlet(name = "upload", urlPatterns = {"/upload"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 20, // 20MB
        maxFileSize = 1024 * 1024 * 100,      // 100MB
        maxRequestSize = 1024 * 1024 * 150)   // 150MB
public class ServletUpload extends HttpServlet {


    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String author = request.getParameter("author");
        String serie = request.getParameter("serie");
        String title = request.getParameter("title");
        String vendor = request.getParameter("vendor");
        String press = request.getParameter("press");
        String keywords = request.getParameter("keywords");
        String isbn = request.getParameter("isbn");
        String edition = request.getParameter("edition");
        String year = request.getParameter("year");
        String type = request.getParameter("type");

/*
        System.out.println("=============");
        System.out.println("UPL " + title);
        System.out.println("UPL " + keywords);
        System.out.println("=============");
*/

        if (title != null && keywords != null) {

            Part data = request.getPart("data");
            File f = File.createTempFile("docs-", "-file");
            data.write(f.getAbsolutePath());

            System.out.println(f.getAbsoluteFile());

            final byte[] x = FileUtils.readFileToByteArray(f);
            String md5 = DigestUtils.md5Hex(x);

            // meta
            nsbm.Meta meta = new nsbm.Meta();
            meta.author = author;
            meta.serie = serie;
            meta.title = title;
            meta.vendor = vendor;
            meta.press = press;
            meta.keywords = keywords;
            meta.type = type;
            meta.isbn = isbn;
            meta.edition = edition;
            meta.year = year;

            // update meta
            library.MetaCenter.setMeta(md5, meta);

            // update content
            library.MetaCenter.setContent(md5, x);

            response.sendRedirect("update.jsp?md5=" + md5);
        } else {
            response.sendRedirect("upload.jsp");
        }

    }
}

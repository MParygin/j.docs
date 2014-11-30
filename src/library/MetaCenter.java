package library;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import nsbm.Meta;
import org.apache.commons.io.FileUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebListener
public class MetaCenter implements ServletContextListener {

    private static File FILE_CONTENT;
    private static File FILE_META;

    public static long count = 0L; // todo
    private static List<String> ids = new ArrayList<String>();
    private static Map<String, Meta> id2meta = new HashMap<String, Meta>();

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();

        // load vars
        FILE_CONTENT = new File(context.getInitParameter("path_cache_content"));
        FILE_META = new File(context.getInitParameter("path_cache_meta"));

        // init
        Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
        try {
            File[] filemetas = FILE_META.listFiles();

            // get each
//            for (String md5 : ids) {
//                S3Object object = client.getObject(bucket, md5);
//                long length = object.getObjectMetadata().getContentLength();
//                InputStream is = object.getObjectContent();
//                byte[] data = new byte[(int)length];
//                is.read(data);
//                is.close();
//                String json = new String(data, "UTF-8");
//                System.out.println(json);
//                id2json.put(md5, json);
//                Meta meta = gson.fromJson(json, Meta.class);
//                id2meta.put(md5, meta);
//            }


            filemetas = FILE_META.listFiles();
            for (java.io.File fmeta : filemetas) {
                String md5 = fmeta.getName();
                ids.add(md5);
                count += fmeta.length();

                System.out.println("Parse: " + fmeta);

                String json = FileUtils.readFileToString(fmeta, "UTF-8");
//                id2json.put(md5, json);
                Meta meta = gson.fromJson(json, Meta.class);
                id2meta.put(md5, meta);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        //
    }

    public static String[] ids() {
        return ids.toArray(new String[ids.size()]);
    }

    public static Meta meta(String md5) {
        return id2meta.get(md5);
    }

    public static boolean setMeta(String md5, Meta meta) {
        try {
            // create json
            Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
            String json = gson.toJson(meta);

            // update local cache
            File fmeta = new File(FILE_META, md5);
            FileUtils.writeStringToFile(fmeta, json);

            // update local hash table
            id2meta.put(md5, meta);

            if (!ids.contains(md5)) ids.add(md5);
            return true;
        } catch (IOException ioex) {
            return false;
        }
    }

    public static boolean setContent(String md5, byte[] data) {
        try {
            // update local cache
            File fcache = new File(FILE_CONTENT, md5);
            FileUtils.writeByteArrayToFile(fcache, data);
            return true;
        } catch (IOException ioex) {
            return false;
        }
    }

    public static boolean remove(String md5) {
        if (md5 == null) return false;

        // remove from content
        new File(FILE_CONTENT, md5).delete();

        // remove from meta
        new File(FILE_META, md5).delete();

        // remove from cache
        id2meta.remove(md5);
        ids.remove(md5);

        return true;
    }

    public static byte[] getContent(String md5) throws IOException {
        return FileUtils.readFileToByteArray(new File(MetaCenter.FILE_CONTENT, md5));
    }

}

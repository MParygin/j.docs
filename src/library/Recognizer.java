package library;

/**
 *
 */
public class Recognizer {

    public static final String APPLICATION_MSWORD = "application/msword";
    public static final String APPLICATION_OCTET_STREAM = "application/octet-stream";
    public static final String APPLICATION_PDF = "application/pdf";
    public static final String APPLICATION_RTF = "application/rtf";
    public static final String APPLICATION_VND_MS_EXCEL = "application/vnd.ms-excel";
    public static final String APPLICATION_VND_MS_POWERPOINT = "application/vnd.ms-powerpoint";
    public static final String APPLICATION_X_GZIP = "application/x-gzip";
    public static final String APPLICATION_X_RAR = "application/x-rar";
    public static final String APPLICATION_ZIP = "application/zip";
    public static final String IMAGE_GIF = "image/gif";
    public static final String IMAGE_JPEG = "image/jpeg";
    public static final String IMAGE_PNG = "image/png";
    public static final String IMAGE_TIFF = "image/tiff";
    public static final String IMAGE_DJVU = "image/x.djvu";
    public static final String TEXT_HTML = "text/html";
    public static final String TEXT_PLAIN = "text/plain";
    public static final String TEXT_XML = "text/xml";

    /**
     * Get default extension by MIME type
     *
     * @param mime MIME type
     * @return Default extension
     */
    public static String getExtensionByMIME(String mime) {
        if (mime == null) return null;
        if (mime.equals(APPLICATION_MSWORD)) return "doc";
        if (mime.equals(APPLICATION_OCTET_STREAM)) return "exe";
        if (mime.equals(APPLICATION_PDF)) return "pdf";
        if (mime.equals(APPLICATION_RTF)) return "rtf";
        if (mime.equals(APPLICATION_VND_MS_EXCEL)) return "xls";
        if (mime.equals(APPLICATION_VND_MS_POWERPOINT)) return "ppt";
        if (mime.equals(APPLICATION_X_GZIP)) return "gz";
        if (mime.equals(APPLICATION_X_RAR)) return "rar";
        if (mime.equals(APPLICATION_ZIP)) return "zip";
        if (mime.equals(IMAGE_GIF)) return "gif";
        if (mime.equals(IMAGE_JPEG)) return "jpg";
        if (mime.equals(IMAGE_PNG)) return "png";
        if (mime.equals(IMAGE_TIFF)) return "tif";
        if (mime.equals(IMAGE_DJVU)) return "djvu";
        if (mime.equals(TEXT_HTML)) return "html";
        if (mime.equals(TEXT_PLAIN)) return "txt";
        if (mime.equals(TEXT_XML)) return "xml";

        // unknown
        return "bin";
    }



    /**
     * Get MIME type by binary content
     *
     * @param data Binary data
     * @return MIME type
     */
    public static String getMIMEByContent(byte[] data) {
        if (data == null || data.length == 0) return null;

        // exe
        if (data.length > 2 && data[0] == 0x4D && data[1] == 0x5A) return APPLICATION_OCTET_STREAM;

        // pdf
        if (data.length > 4 && data[0] == '%' && data[1] == 'P' && data[2] == 'D' && data[3] == 'F') return APPLICATION_PDF;

        // xml
        if (data.length > 5 && data[0] == '<' && data[1] == '?' && data[2] == 'x' && data[3] == 'm' && data[4] == 'l') return TEXT_XML;

        // djvu
        if (data.length > 5 && data[0] == 'A' && data[1] == 'T' && data[2] == '&' && data[3] == 'T' && data[4] == 'F') return IMAGE_DJVU;

        // unknown
        return null;
    }

}

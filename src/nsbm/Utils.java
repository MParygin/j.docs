package nsbm;

import javax.servlet.http.HttpServletRequest;

public class Utils {

    public static int getParameterAsInt(HttpServletRequest request, String name, int dflt) {
        String value = request.getParameter(name);
        if (value == null) return dflt;
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return dflt;
        }
    }

}

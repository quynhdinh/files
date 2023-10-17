import java.util.Arrays;

public final class Debug {
    private static <T> String ts(T t) {
        if (t == null) {
            return "null";
        }
        try {
            return ts((Iterable) t);
        } catch (ClassCastException e) {
            if (t instanceof int[]) {
                String s = Arrays.toString((int[]) t);
                return "{" + s.substring(1, s.length() - 1) + "}";
            } else if (t instanceof long[]) {
                String s = Arrays.toString((long[]) t);
                return "{" + s.substring(1, s.length() - 1) + "}";
            } else if (t instanceof char[]) {
                String s = Arrays.toString((char[]) t);
                return "{" + s.substring(1, s.length() - 1) + "}";
            } else if (t instanceof double[]) {
                String s = Arrays.toString((double[]) t);
                return "{" + s.substring(1, s.length() - 1) + "}";
            } else if (t instanceof boolean[]) {
                String s = Arrays.toString((boolean[]) t);
                return "{" + s.substring(1, s.length() - 1) + "}";
            }
            try {
                return ts((Object[]) t);
            } catch (ClassCastException e1) {
                return t.toString();
            }
        }
    }

    private static <T> String ts(T[] arr) {
        StringBuilder ret = new StringBuilder();
        ret.append("{");
        boolean first = true;
        for (T t : arr) {
            if (!first) {
                ret.append(", ");
                first = false;
            }
            ret.append(ts(t));
        }
        ret.append("}");
        return ret.toString();
    }

    private static <T> String ts(Iterable<T> iter) {
        StringBuilder ret = new StringBuilder();
        ret.append("{");
        boolean first = true;
        for (T t : iter) {
            if (!first) {
                ret.append(", ");
            }
            first = false;
            ret.append(ts(t));
        }
        ret.append("}");
        return ret.toString();
    }

    public static void dbg(Object... o) {
        System.out.print("Line #" + Thread.currentThread().getStackTrace()[2].getLineNumber() + ": [");
        for (int i = 0; i < o.length; i++) {
            if (i != 0) {
                System.out.print(", ");
            }
            System.out.print(ts(o[i]));
        }
        System.out.println("]");
    }
}

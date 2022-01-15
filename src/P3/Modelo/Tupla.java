package P3.Modelo;

import java.util.Objects;

/**
 * Tupla genérica de dos objetos.
 *
 * @param <A>
 * @param <B>
 */
public class Tupla<A, B> {

    public final A a;
    public final B b;

    /**
     * Construye una tupla de dos objetos.
     *
     * @param a
     * @param b
     */
    public Tupla(A a, B b) {
        this.a = a;
        this.b = b;
    }

    /**
     * Método sobreescrito hasCode().
     *
     * @return
     */
    @Override
    public int hashCode() {
        int hash = 3;
        hash = 73 * hash + Objects.hashCode(this.a);
        hash = 73 * hash + Objects.hashCode(this.b);
        return hash;
    }

    /**
     * Método sobreescrito equals().
     *
     * @param obj
     * @return
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Tupla<?, ?> other = (Tupla<?, ?>) obj;
        if (!Objects.equals(this.a, other.a)) {
            return false;
        }
        if (!Objects.equals(this.b, other.b)) {
            return false;
        }
        return true;
    }
}

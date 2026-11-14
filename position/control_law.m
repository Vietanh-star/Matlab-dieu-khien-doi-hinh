function dpdt = control_law(t, xi)

    global p_d L

    dpdt = -kron(L,eye(2))*(xi-p_d);

end
include("artist.jl")

rademacher(n) = rand([-1,1], n)

function radpoly(n)
    coefs = rademacher(n+1)
    return f(z) = abs(z)<1 ? sum(coefs.*[z^i for i in 0:n]) : 0
end

n = 2000 ; res = 2000
raf = radpoly(n)
plot()
axisrange = range(-1, 1, length=res)
dessin = paint_colorplot(raf, 
    res=res, mycm=ColorSchemes.cyclic_mygbm_30_95_c78_n256_s25.colors)
plot!(axisrange, axisrange, dessin ; plotarguments...)

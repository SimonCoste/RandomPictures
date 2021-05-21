include("artist.jl")


gaussian(n) = (randn(n) + rand(n) * 1im) / sqrt(2) #standard complex gaussian rv

function GEF(randcoefs, n)
    coefs = randcoefs(n+1) ./ [sqrt(factorial(big(k))) for k in 0:n]
    return f(z) = sum(coefs.*[z^k for k in 0:n]) 
end

n = 200 ; res = 500
f1 = GEF(gaussian, n)
b=8.
axisrange = range(-b, b, length=res)
dessin1 = paint_colorplot(f1, 
    bound=b, 
    res=res, mycm=ColorSchemes.cyclic_mygbm_30_95_c78_n256_s25.colors)


    #common arguments for nice plots
plotarguments = Dict(
    :xlims => (-b,b),
    :ylims => (-b, b),
    :yticks=> -b:0.5:b,
    :xticks=> -b:0.5:b,
    :tickfontfamily => "Computer Modern",
    :legend => :none,
    :border => :none)

p = plot(dpi=200)
plot!(p, axisrange, axisrange, dessin1 ; plotarguments...)

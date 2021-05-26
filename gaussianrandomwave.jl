using SpecialFunctions
include("artist.jl")

gaussian(n) = (randn(n) + rand(n) * 1im) #standard complex gaussian rv with variance 2

function GRW(K=1, M=10)
   coefs1 = gaussian(M) #positive coeffs
   coefs2 = gaussian(M) #negative coeffs
   function f(z)
        r = abs(z) ; θ = angle(z)
        B = [besselj(k, K*r) for k in 1:M]
        C_pos = [coefs1[k]*exp(1im * k * θ) for k in 1:M]
        C_neg = [coefs2[k]*exp(-1im * k * θ) for k in 1:M]
        return sum(B .* (C_pos + C_neg)) + besselj(0, K*r) * (randn() + randn()*1im)
   end 
   return f
end

M = 50 ; res = 3000
f1 = GRW(4, M)
b=10.
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

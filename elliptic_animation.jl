using LinearAlgebra, Plots, LaTeXStrings
include("artist.jl")

#parameters for the plot
res = Int(1e3)
a = 2. ; ℓ = 1.2*a
b = a+0.6
c = a+1
slider = 0.7*a
axisrange = range(-a, a, length=res)
insetrange = range(b, b+1, length=res)
inset=paint_colorplot(z->z) #for the inset

#the common underlying matrix, real Girko
n=Int(1e2)
X = randn(n,n)
Xᵗ = transpose(X)

θ = range(1, 2*pi+1, length=200)
animation = @animate for s in range(-0.9, 0.9, length=200)
    
    λ = eigvals(
        (X + s*Xᵗ) ./ √n
    )

    χ(z) = prod(z .* λ .- 1)
    ellipse(t) = (1+s)^2 * cos(t) + 1im * (1-s)^2 * sin(t)

    phaseportrait = paint_colorplot(χ, 
    bound=a, 
    res=res, 
    mycm=ColorSchemes.twilight.colors
    )
    plot(axisrange, axisrange, phaseportrait)

    scatter!(real( 1 ./ λ), imag( 1 ./ λ), 
        color=:white, 
        markerstrokewidth=0
        )
    plot!(real(1 ./ ellipse.(θ)), imag(1 ./ ellipse.(θ)), 
        lw=3, 
        color=:white
        )
    plot!(xlims=(-a, a+2), ylims=(-b, b), 
        legend=false, 
        border=:none, 
        size=(600,600)
        )
    plot!([-slider, slider], [ℓ,ℓ])
    annotate!(slider*s, 1.15*ℓ, L"\rho")
    annotate!(0, -ℓ, L"p(z) = \det(I_n - z X_\rho)")
    annotate!(0.9*a, ℓ, L"+1")
    annotate!(-0.9*a, ℓ, L"-1")

    scatter!([s*slider], [ℓ])
    println(s)
    plot!(insetrange, -insetrange .+ 2, inset)
    annotate!(a+0.4,-1.1, L"\mathbb{C}=")
    annotate!(c-0.1,0.3, L"X \sim \mathrm{Girko}_{\mathbb{R}}(n)")
    annotate!(c,1, L"X_\rho = \frac{X + \rho X^*}{\sqrt{n}}")

end

#gif(animation, "test.gif", fps = 10)


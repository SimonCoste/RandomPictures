using ComplexPortraits, Plots, ColorSchemes
@ComplexPortraits.import_huge

function paint_colorplot(func ; 
    bound=1, 
    res = Int64(100), 
    mycm=ColorSchemes.hsv.colors)
    """
    Paints the complex phase portrait of the complex
    function func in the box from upper_left to 
    lower_right, with given resolution. 
    """
    function mycolormap(; colormap=mycm)
      """
      Zero is always painted in white. 
      """
        stepfct = generate_stepfct(length(colormap))
        let cm = copy(colormap)
          return (z, fz) -> isapprox(fz, 0) ? RGB(1,1,1) : cm[stepfct(angle_zero_one(fz))]
        end
    end

    upper_left = -bound + 1im * bound
    lower_right = bound - 1im * bound
    return portrait(upper_left, lower_right, func; 
        no_pixels=(res, res), 
        point_color = mycolormap())
end

#common arguments for nice plots
plotarguments = Dict(
    :xlims => (-1,1),
    :ylims => (-1, 1),
    :yticks=> -1:0.5:1,
    :xticks=> -1:0.5:1,
    :tickfontfamily => "Computer Modern",
    :legend => :none,
    :border => :none)


#dr = paint_colorplot(z->z, res=1000)
#plot(dr)

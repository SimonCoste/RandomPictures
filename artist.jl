using ComplexPortraits, Plots, ColorSchemes
@ComplexPortraits.import_huge

function paint_colorplot(func ; 
    bound=2, 
    res = Int64(1e2), 
    mycm=ColorSchemes.twilight.colors)
    """
    Paints the complex phase portrait of the complex
    function func in the box from upper_left to 
    lower_right, with given resolution. 
    """
    function mycolormap(; colormap=mycm)
        stepfct = generate_stepfct(length(colormap))
        let cm = copy(colormap)
          return (z, fz) -> cm[stepfct(angle_zero_one(fz))]
        end
    end

    upper_left = -bound + 1im * bound
    lower_right = bound - 1im * bound
    return portrait(upper_left, lower_right, func; 
        no_pixels=(res, res), 
        point_color = mycolormap())
end

rien(z)=z
paint_colorplot(z->z)


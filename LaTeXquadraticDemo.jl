### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ d7244663-6200-4bc7-a986-bba3789792eb
begin	
	import Pkg
	using  Pkg
		
 	Pkg.activate(mktempdir())
	Pkg.add(["LaTeXStrings"])
	using LaTeXStrings
	
	md"""	
	⬅️ 📦 $(html"<b>packages</b>") 📦
	"""
end

# ╔═╡ 4f1ed5e2-de2c-11eb-050b-f31919bd40b2
html"""

<h1><center>
LaTeXStrings Function Demo
<br>

<small><small>Timothy R. Gaede</small></small>
<br>
<small><small><small>2021-07-06</small></small></small>
</center></h1>

"""

# ╔═╡ 74499af7-b6ae-4638-a1b9-32c703c91efa
size="LARGE"

# ╔═╡ aaa6cb28-a847-41ed-8c1b-d5451265ad23
a, b, c = "α + γ", 5+2+8, "{ -r^3 \\over 6 }"

# ╔═╡ c3e8cc45-77e1-4b40-8b07-8211116b495d
color_a, color_b = (0.2, 0.1, 0.9), "red"

# ╔═╡ 499b4099-6ea4-49f6-b9a9-e160a3a31de3
CP_c = @bind color_c html"<input type=color value=#45a849>"

# ╔═╡ 07590d6c-350e-44e9-a508-b75540d1cf61
html"""

<br><br><br><br>

"""

# ╔═╡ 5785f813-f8ca-4a07-bba2-0616ccc13162
html"""  
  
<br>
<div style="border-bottom: 1px solid blue"></div> 
"""

# ╔═╡ b7b0f998-8874-48b6-8c78-45b660c84cdc
html"""  
<div style="border-top: 1px solid blue"></div> 
<br>
<div style="border-bottom: 1px solid purple"></div> 
"""

# ╔═╡ 0b4553a8-1f12-4711-a780-70fdee1fec0e
# Timothy R. Gaede

# ToDo: refactor

# using LaTeXStrings

#=
sizes:  \tiny, \scriptsize, \footnotesize, \small, \normalsize,
        \large, \Large, \LARGE, \huge, \Huge

=#
function LaTeXquadratic( a, b, c;    raw=false, 
									 size="normalsize",
									 color_a=(0.0, 0.0, 0.0),
									 color_b=(0.0, 0.0, 0.0),
									 color_c=(0.0, 0.0, 0.0) )


	#---------------------------------------------------------
	function paren(str)

	if length(str) > 1;    return "(" * str * ")";    end


		occursin(str, "0123456789") ?  "(" * str * ")"  :  str		
	end 
	#---------------------------------------------------------


	#-----------------------------------------------
	function parenIsolated(str)

		re = r"^([0-9]+([.][0-9]*)?|[.][0-9]+)$"

		if occursin(re, str);    return str;    end

		length(str) > 1 ?  "(" * str * ")"  :  str

	end
	#-----------------------------------------------


	#------------------------------------------------------------
	function RGB(hex_code::String)
	if first(hex_code) == '#'  &&  length(hex_code) == 7		
		code = uppercase(hex_code[2 : end])

	elseif first(hex_code) !== '#'  &&  length(hex_code) == 6		
		code = uppercase(hex_code)

	else 
		msg = "\n In function, RGB()\n " *
		"the value for hex_code could not be parsed."

		throw(msg)
	end

		val = Dict('0'=> 0,  '1'=> 1,  '2'=> 2,  '3'=> 3,
				   '4'=> 4,  '5'=> 5,  '6'=> 6,  '7'=> 7,
				   '8'=> 8,  '9'=> 9,  'A'=>10,  'B'=>11,
				   'C'=>12,  'D'=>13,  'E'=>14,  'F'=>15)


		result = Vector{Int64}(undef, 3)

		for c = 1 : 3 
			result[c] = 16val[code[2c-1]] + val[code[2c]]
		end

		result # returned
	end 	
	#------------------------------------------------------------


	rawTeX = ""

	if typeof(color_a) == Tuple{Float64, Float64, Float64} || 
	   typeof(color_a) == Vector{Float64}

		rawTeX *= "\\definecolor{color_a}{rgb}{" * string(color_a[1]) * ", " *
												   string(color_a[2]) * ", " *
												   string(color_a[3]) * "}"
		
		txt_a = "{\\color{color_a}"
		

	elseif typeof(color_a) == Tuple{Int, Int, Int} || 
		   typeof(color_a) == Vector{Int}

		rawTeX *= "\\definecolor{color_a}{RGB}{" * string(color_a[1]) * ", " *
												   string(color_a[2]) * ", " *
												   string(color_a[3]) * "}"
		txt_a = "{\\color{color_a}"

	elseif typeof(color_a) == String
			 
		 
			try 
				clr_a = RGB(color_a)

				rawTeX *= "\\definecolor{color_a}{RGB}{" * string(clr_a[1]) * ", " *
														   string(clr_a[2]) * ", " *
														   string(clr_a[3]) * "}"
			
				txt_a = "{\\color{color_a}"
			
			catch thrown
			
				txt_a = "{\\color{$color_a}"
			end
			 

	end

 
	if typeof(color_b) == Tuple{Float64, Float64, Float64} || 
	   typeof(color_b) == Vector{Float64}

		rawTeX *= "\\definecolor{color_b}{rgb}{" * string(color_b[1]) * ", " *
												   string(color_b[2]) * ", " *
												   string(color_b[3]) * "}"
		
		txt_b = "{\\color{color_b}"
		

	elseif typeof(color_b) == Tuple{Int, Int, Int} || 
		   typeof(color_b) == Vector{Int}

		rawTeX *= "\\definecolor{color_b}{RGB}{" * string(color_b[1]) * ", " *
												   string(color_b[2]) * ", " *
												   string(color_b[3]) * "}"
		txt_b = "{\\color{color_b}"

	elseif typeof(color_b) == String
			 
		 
			try 
				clr_b = RGB(color_b)

				rawTeX *= "\\definecolor{color_b}{RGB}{" * string(clr_b[1]) * ", " *
														   string(clr_b[2]) * ", " *
														   string(clr_b[3]) * "}"
			
				txt_b = "{\\color{color_b}"
			
			catch thrown
			
				txt_b = "{\\color{$color_b}"
			end
			 

	end
 


	
	if typeof(color_c) == Tuple{Float64, Float64, Float64} || 
	   typeof(color_c) == Vector{Float64}

		rawTeX *= "\\definecolor{color_c}{rgb}{" * string(color_c[1]) * ", " *
												   string(color_c[2]) * ", " *
												   string(color_c[3]) * "}"
		
		txt_c = "{\\color{color_c}"
		

	elseif typeof(color_c) == Tuple{Int, Int, Int} || 
		   typeof(color_c) == Vector{Int}

		rawTeX *= "\\definecolor{color_c}{RGB}{" * string(color_c[1]) * ", " *
												   string(color_c[2]) * ", " *
												   string(color_c[3]) * "}"
		txt_c = "{\\color{color_c}"

	elseif typeof(color_c) == String
			 
		 
			try 
				clr_b = RGB(color_c)

				rawTeX *= "\\definecolor{color_c}{RGB}{" * string(clr_c[1]) * ", " *
														   string(clr_c[2]) * ", " *
														   string(clr_c[3]) * "}"
			
				txt_c = "{\\color{color_c}"
			
			catch thrown
			
				txt_c = "{\\color{$color_c}"
			end
			 

	end
 

	
	
	
	


	rawTeX *=  "{  -" * txt_b * parenIsolated(string(b)) * 
	           "}\\pm \\sqrt{" *  txt_b *   
			   parenIsolated(string(b)) * "}^2 - 4" * txt_a *
			   paren(string(a)) * "}" * txt_c * paren(string(c)) * 
	           "}}   \\over 2" * txt_a * paren(string(a)) * " }}" 



	raw	?  rawTeX  :  L"""\%$size{ %$rawTeX }""" 
end

# ╔═╡ 36bf6c8f-4159-44da-914e-277d2214dda8
LaTeXquadratic(a, b, c, size=size, color_a=color_a, color_b=color_b, color_c=color_c)

# ╔═╡ 57676075-6db7-40ba-87b5-bb87a8dc481b
begin
	LTXqrApsides = LaTeXquadratic("ϵ", "μ", "{ -h^2 \\over 2 }", raw=true)
	
	sizeApsides = "Large"
	
	L"""\%$sizeApsides{ \text{apsides = } %$LTXqrApsides }"""
end

# ╔═╡ Cell order:
# ╟─4f1ed5e2-de2c-11eb-050b-f31919bd40b2
# ╠═36bf6c8f-4159-44da-914e-277d2214dda8
# ╠═74499af7-b6ae-4638-a1b9-32c703c91efa
# ╠═aaa6cb28-a847-41ed-8c1b-d5451265ad23
# ╠═c3e8cc45-77e1-4b40-8b07-8211116b495d
# ╠═499b4099-6ea4-49f6-b9a9-e160a3a31de3
# ╟─07590d6c-350e-44e9-a508-b75540d1cf61
# ╠═57676075-6db7-40ba-87b5-bb87a8dc481b
# ╟─5785f813-f8ca-4a07-bba2-0616ccc13162
# ╟─d7244663-6200-4bc7-a986-bba3789792eb
# ╟─b7b0f998-8874-48b6-8c78-45b660c84cdc
# ╟─0b4553a8-1f12-4711-a780-70fdee1fec0e

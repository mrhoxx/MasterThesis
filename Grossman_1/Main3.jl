using JuMP, Ipopt


m=Model(with_optimizer(Ipopt.Optimizer))

@variable(m,x==1)
y=variable_by_name(m,"x")
println(y)
var=@variable(m)
set_name(var,"z")
test=variable_by_name(m,"xxy")
test2=variable_by_name(m,"z")
@variable(m,matr[1:2,1:2])

JuMP.optimize!(m)
println("Done, x=",JuMP.value(x))
println("Done, y=",JuMP.value(y))

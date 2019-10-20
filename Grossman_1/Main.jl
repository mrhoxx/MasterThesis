using JuMP, Ipopt



GD=Model(with_optimizer(Ipopt.Optimizer))

struct Two_port_device{Real}
    TV1::Real
    @variable(GD,xx_in[7])
    @variable(GD,xx_out[7])
end

device_2 = Two_port_device(2)
device_1 = Two_port_device(11)


@NLconstraint(GD,device_1.xx_in[7]==device_1.xx_out[7])

@variable(GD,0<=x<=40)
@constraint(GD, x>=2)
@objective(GD, Min,x+2)


JuMP.optimize!(GD)
println("Objective value: ",JuMP.objective_value(GD))
println("x=",JuMP.value(x))
println("y=",JuMP.value(y))

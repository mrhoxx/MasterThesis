using JuMP, Ipopt


TM=Model(with_optimizer(Ipopt.Optimizer))

mutable struct Test_Struct
    Num1::Real
    atk_model::Model
    @variable(atk_model, x_1)
end

ST = Test_Struct(3,TM)
println(ST.Num1)

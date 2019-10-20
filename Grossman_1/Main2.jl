using JuMP, Ipopt

Ex_DG= Model(with_optimizer(Ipopt.Optimizer))

@variable(Ex_DG,X_Feed[1:7]>=0)
#Flowvarable
#1: Temperature [K]
#2: Pressure [kPa]
#3: %A [-]
#4: %B [-]
#5: %C [-]
#6: %D [-]
#7: Flow [mol/s]

#Set First Variables
@constraint(Ex_DG,X_Feed[1]==310)
@constraint(Ex_DG,X_Feed[2]==2*101.325)
@constraint(Ex_DG,X_Feed[3]==0.45)
@constraint(Ex_DG,X_Feed[4]==0.50)
@constraint(Ex_DG,X_Feed[5]==0.05)
@constraint(Ex_DG,X_Feed[6]==0)
@constraint(Ex_DG,X_Feed[7]==10)

#Connect Variables Feed to Inlett Compressor_1
include("./Parts/Incl_Compressor_1.jl")
@constraint(Ex_DG,X_Feed[1:6].==X_C1_in[1:6]) #State Variables
@constraint(Ex_DG,X_Feed[7]+X_C1_in[7]==0)  #Flow Variable

#Connect Variables Outlet Compressor_1 to H3
@variable(Ex_DG,X_H3[1:7]>=0)
@constraint(Ex_DG,X_C1_out[1:6].==X_H3[1:6]) #State Variables
@constraint(Ex_DG,X_C1_out[7]+X_H3[7]==0)  #Flow Variable

#Connect H3 to Inlett Compressor_2
include("./Parts/Incl_Compressor_2.jl")
@constraint(Ex_DG,X_H3[1:6].==X_C2_in[1:6]) #State Variables
@constraint(Ex_DG,X_H3[7]+X_C2_in[7]==0)  #Flow Variable

#Connect Outlet Compressor_2 to C2
@variable(Ex_DG,X_C2[1:7]>=0)
@constraint(Ex_DG,X_C2_out[1:6].==X_C2[1:6]) #State Variables
@constraint(Ex_DG,X_C2_out[7]+X_C2[7]==0)  #Flow Variable

#Example Model
@constraint(Ex_DG,X_C2[2]>=X_Feed[2]+1000)
@objective(Ex_DG,Min,C1_Size*C1_Size*0.1+C2_Size)

JuMP.optimize!(Ex_DG)
println("Solution= ", JuMP.objective_value(Ex_DG))
println("C1_Size=",JuMP.value(C1_Size))
println("C2_Size=",JuMP.value(C2_Size))

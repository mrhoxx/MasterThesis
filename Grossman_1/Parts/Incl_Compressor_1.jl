#Define Inlet and Outlet Flow
@variable(Ex_DG,X_C1_in[1:7]>=0)
@variable(Ex_DG,X_C1_out[1:7]>=0)
@variable(Ex_DG,C1_Size>=0, start = 1)

#Structure doesn't Change
@constraint(Ex_DG,X_C1_in[3:6].==X_C1_out[3:6])
@constraint(Ex_DG,X_C1_in[7]+X_C1_out[7]==0)

#Pressure and Temperature Increase
@constraint(Ex_DG,X_C1_out[1]==X_C1_in[1]+10*C1_Size) # TemperatureIncrease by 10K*Size
@constraint(Ex_DG,X_C1_out[2]==X_C1_in[2]+50*C1_Size) #PressureIncrease by 50kpa*Size

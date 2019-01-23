function params = InitParams()
    params.Energy.transfer = 50*0.000000001*24;%50 nj  energy consumed by radio electronics in transmit mode(J/bit)
    params.Energy.receive = 50*0.000000001*24; % energy consumed by radio electronics in  receive mode(J/bit)
    params.packetLength = 1024;%64bytes * 8 bits: see papar: Directed diffusion
    params.Energy.aggr = 5*0.000000001;  % energy consumed for data aggregation(J/bit/signal)
    params.TxDistance = 10;
    params.Energy.freeSpace = 10*0.000000000001;
    
    params.Energy.mp=0.0013*0.000000000001;    %energy consumed by the power amplifier on the multi path model(J/bit/m4)
    params.numRounds = 9999;
    
    params.m = 0.75;
    params.a = 2;
    params.m0 = 0.525;
    params.b = 2.5;
    params.m1 = 0.225;
    params.u = 3;
    params.Cprob=0.02;%0.04; %Cluster Probability
    params.NON_CH					= 0;%			non cluster head
    params.TENTATIVE_CH			= 1; %			tentative cluster head				 
    params.FINAL_CH				= 2;%				final cluster head 
    params.TOS_LOCAL_ADDRESS = -1;       % TOS_LOCAL_ADDRESS  must <=0 

    params.numcluster = 0;
%     params.EnergyConsumptionTx = params.Energy.transfer * params.packetLength + params.Energy.freeSpace *  (params.TxDistance^2);
    params.EnergyConsumptionTx = params.Energy.transfer * params.packetLength + params.Energy.freeSpace * params.packetLength  *  (params.TxDistance^2);
    params.EnergyConsumptionRx = params.Energy.transfer * params.packetLength;
end
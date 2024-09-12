% GET THE CRITERION
if ((strcmp(EXPE.type_obj,'dephasing') || strcmp(EXPE.type_obj,'absorbing'))...
        && EXPE.flag_linearize)
    Crit = @(x) (critWLSlinear(x,EXPE.data,Propag,BackPropag,-1));
elseif ((strcmp(EXPE.type_obj,'unknown') && EXPE.flag_fienup) || strcmp(EXPE.flag_rec_meth,'Fienup'))
    Crit = @(x) (critFienup(x,sqrt(EXPE.data),Propag,BackPropag,-1));
else
    Crit = @(x) (critWLS(x,EXPE.data,Propag,BackPropag,-1));  
end

switch EXPE.flag_rec_meth
    case 'RI'
        [RECxopt,RECevolcost] = algoRI(EXPE.o0,Crit,RECoptions);
    case 'Fienup'
        [RECxopt,RECevolcost] = algoFienupER(EXPE.o0,Crit,RECoptions);
end
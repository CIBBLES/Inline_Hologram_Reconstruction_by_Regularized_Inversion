switch EXPE.flag_rec_meth
    case 'RI'
        [RECxopt,RECevolcost] = algoRI(EXPE.o0,Crit,RECoptions);
    case 'Fienup'
        [RECxopt,RECevolcost] = algoFienupER(EXPE.o0,Crit,RECoptions);
end
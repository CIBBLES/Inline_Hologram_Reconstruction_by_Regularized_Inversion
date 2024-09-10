% FILL EXPERIMENT REPORT STRUCT
EXPE.evolcost = RECevolcost;
EXPE.xopt = RECxopt;

% DISPLAY RECONSTRUCTION
if (EXPE.flag_display)
    %% Reconstruction
    if (~strcmp(EXPE.type_obj,'Fienup') && ((strcmp(EXPE.type_obj,'dephasing') || strcmp(EXPE.type_obj,'absorbing'))...
                && EXPE.flag_linearize))
        if (strcmp(EXPE.type_obj,'dephasing'))
            ihrri_show(RECxopt,'Reconstructed phase', phase_fig);
        elseif (strcmp(EXPE.type_obj,'absorbing'))
            ihrri_show(-RECxopt,'Reconstructed opacity', opacity_fig);
        end
    else
        RECxopt = 1.0 + RECxopt(:,:,1) + 1i * RECxopt(:,:,2);
        ihrri_show(angle(RECxopt),'Reconstructed phase', phase_fig);
        ihrri_show(abs(RECxopt),'Reconstructed modulus', opacity_fig);
    end
    %% Residues
    [fxopt,gxopt,c,residues] = Crit(EXPE.xopt);
    ihrri_show(residues,'Residues', residue_fig);
end
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
        angle_RECxopt = angle(RECxopt);
        abs_RECxopt = abs(RECxopt);

        % Pass true as fourth argument of ihrri_show to have a surface plot
        % instead of an image.
        % I'd recommend passing the image through some sort of low-pass
        % filter i.e. imgaussfilt(im).
        %angle_RECxopt = imgaussfilt(angle_RECxopt,1);
        
        ihrri_show(angle_RECxopt,'Reconstructed phase', phase_surf_fig, true);
        ihrri_show(angle_RECxopt,'Reconstructed phase', phase_fig);
        %ihrri_show(abs_RECxopt,'Reconstructed modulus', opacity_fig);
    end
    %% Residues
    [fxopt,gxopt,c,residues] = Crit(EXPE.xopt);
    %ihrri_show(residues,'Residues', residue_fig);
end
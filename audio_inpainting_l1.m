function sol = audio_inpainting_l1(sound_depleted, Mask, Psi, Psit, param)

    if nargin<5
        param = struct();
    end

    if ~isfield(param, 'verbose'), param.verbose = 1; end
    
    % noiseless case
    f2.prox = @(x,T) Psi( Psit(x) .* (1-  Mask )+ Mask.* sound_depleted );
    f2.eval = @(x) eps;

    % setting the function f1 (l1 norm of the Gabor transform)
    param_l1.verbose = param.verbose - 1;
    param_l1.tight = 1;

    f1.prox=@(x, T) prox_l1(x, T, param_l1);
    f1.eval=@(x) norm(x,1);   


    %param.do_ts = @(x) log_decreasing_ts(x, 10, 0.1, 80);

    % Change the stopping criterion to avoid computing the objective function
    % every iteration.
    param.stopping_criterion = 'rel_norm_primal'; 

    sol = Psit(solvep(Psi(sound_depleted),{f1,f2},param));

end
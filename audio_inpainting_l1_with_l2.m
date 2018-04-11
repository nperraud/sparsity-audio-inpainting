function sol = audio_inpainting_l1_with_l2(sound_depleted, Mask, Psi, Psit, weight_l2, param, time_step)
    
%     time_step = 2^(-3.5);
    param.gamma = time_step;
    sol_in = Psi(sound_depleted);

    % noiseless case
    f2.prox = @(x,T) l2_and_proj(x, Mask, Psi, Psit, sound_depleted, T*weight_l2);
    f2.eval = @(x) 0.5*weight_l2 * norm(x-sol_in) ;

    % setting the function f1 (l1 norm of the Gabor transform)
    param_l1.verbose = param.verbose - 1;
    param_l1.tight = 1;

    f1.prox=@(x, T) prox_l1(x, T, param_l1);
    f1.eval=@(x) norm(x,1);   


    %param.do_ts = @(x) log_decreasing_ts(x, 10, 0.1, 80);

    % Change the stopping criterion to avoid computing the objective function
    % every iteration.
    param.stopping_criterion = 'rel_norm_primal'; 

    sol = Psit(solvep(sol_in,{f1,f2},param));

end

function sol = l2_and_proj(x, Mask, Psi, Psit, sound_depleted, weight_l2)
    z = Psit(x);
    tmp = (z + weight_l2*sound_depleted)/(1+weight_l2) .* ( 1 -  Mask )+ Mask.* sound_depleted;
    sol = Psi( tmp );
end
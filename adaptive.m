function [seq_ada, w, et, sum_abs_et ] = adaptive(seq, N, k, maxsteps)
seq_ada = zeros(1, length(seq)); 
et = zeros(1, N);                
sum_abs_et = 0;
w = ones(N, 1);
w = w/N;
step = maxsteps;
while (step >= 0)
    for i = (N+1):(length(seq))
    	seq_ada(i) =  seq( (i-N):(i-1) )*flip(w);
        et(i) = seq(i) - seq_ada(i);
        for j = 1:N
            w(j) = w(j) + 2*k*et(i)*seq(i-j);
        end
        disp(w)
    end
    if( abs( sum_abs_et - sum( abs(et)) ) < k )
        fprintf("solving stoped : at step %d\n", maxsteps-step) 
        break
    else
        sum_abs_et = sum(abs(et));
    end
    step = step - 1;
end

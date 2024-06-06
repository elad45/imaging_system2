function vr = generate_random_vector(vr)
    big_or_small_vec = zeros(1,vr.amountTrials);
    ones_indices = randperm(vr.amountTrials, vr.amountTrials/2);
    big_or_small_vec(ones_indices) = 1;
    vr.big_or_small_vec = big_or_small_vec;
end


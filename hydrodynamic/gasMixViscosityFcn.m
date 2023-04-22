function mu_g = gasMixViscosityFcn(Cgas, T, mu_pure)

    n_gen  = Global.gen;
    [m, n] = size(Cgas);
    mu_p   = zeros(m, n_gen);

    yi_gas  = molarFractionFcn(Cgas);





    for i = 1:n

        tmp_1 = zeros(m, n);
        mu_p  = ;

        for j = 1:n

            tmp_1(:,j) = yi_gas(:,j).*((M(i)./M(j))^(1/2));

        end

        mum_gas(:,i) =  yi_gas(:,i).*mu_p./sum(tmp_1, 2);
        
    end

    mu_g = sum(mum_gas, 2);



end
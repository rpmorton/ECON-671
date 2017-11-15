
/* for PS 8 Q1 a ii (get unbiased to know numerator of CRLB is 1) */
/* Created by RM on 2017.11.04 */
/* This appears to be asymptotically unbiased but biased in small samples */

local theta = .9

local loops = 3000

local obs = 15

forv i = 1(1)`loops' {


clear

set obs `obs'



generate uni_rand = runiform()

g density_x = `theta' * uni_rand ^ (`theta'-1)

g sample = uni_rand * density_x

egen sample_mean = mean(sample)

g theta_hat_mme = (sample_mean)/ (1-sample_mean)

local theta_hat_mme_`i' = theta_hat_mme

}

clear
set obs `loops'

g theta_hat_mme = 0


forv j = 1(1)`loops' {

replace theta_hat_mme = `theta_hat_mme_`j'' if [_n] == `j'

}

su theta_hat_mme



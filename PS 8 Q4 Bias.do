
/* for PS 8 Q4 a ii */
/* Created by RM on 2017.11.04 */

local theta = .9

local loops = 3000

forv i = 1(1)`loops' {


clear

set obs `loops'



generate uni_rand = runiform()

g density_x = `theta' * uni_rand ^ (`theta'-1)

g sample = uni_rand * density_x

g sample_log = ln(sample)

egen sum_log_sample = sum(sample_log)

g theta_hat_mle = (- `loops')/ (sum_log_sample)

local theta_hat_mle_`i' = theta_hat_mle

}

clear
set obs `loops'

g theta_hat_mme = 0


forv j = 1(1)`loops' {

replace theta_hat_mle = `theta_hat_mle_`j'' if [_n] == `j'

}



su theta_hat_mle

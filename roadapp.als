module roadapp

one sig Cliente {
	carros: set Carro
}

sig Carro {
	servicos: set Servico
}

sig Servico {} 

fact restrictions {
	all ser: Servico | one ser.~servicos 
	all car: Carro | one car.~carros 
	#Carro > 1
	#Servico > 1
}

pred show[]{}

run show for 10

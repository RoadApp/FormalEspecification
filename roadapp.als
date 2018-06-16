module roadapp

one sig Cliente {
	carros: set Carro
}

sig Carro {
	servicos: set Servico
}

sig Servico {} 

fact restrictions {
	all car: Carro, cli: Cliente | car in (cli.carros)
	#Carro > 1
	#Servico > 1
	all ser: Servico | one ser.~servicos 

	//Um serviço nao pode pertencer a mais de um carro
	//all ser: Servico, c1,c2: Carro | (ser in c1.servicos) and (ser in c2.servicos) => c1 = c2
}

pred show[]{}

run show for 10

module roadapp

one sig Cliente {
	carros: set Carro
}

sig Carro {
	servicos: set Servico
}

sig Servico {} 


pred show[]{}

run show for 10

module roadapp

open util/ordering[Time]

sig Time {} 

sig Usuario {
	carros: set Carro->Time,
	cnh: one CNH
}

sig CNH {}

sig Carro {
	servicos: set Servico->Time,
	licenciamento: one Licenciamento
}

sig Licenciamento {}

sig Servico {} 

fact attribRestrictions {
	all usr: Usuario | #usr.carros > 0
	all usr: Usuario | one usr.cnh
	all car: Carro | one car.licenciamento
}

fact parentRestrictions {
	//all t:Time, ser: Servico | one ser.~(servicos.t)
	//all t:Time, car: Carro | one car.~(carros.t)
	all c: CNH | one c.~cnh
	all lic: Licenciamento | one lic.~licenciamento
}

fact quantRestrictions {
	#Carro > 1
	#Servico > 1
	#Usuario > 1
}

fact traces {
	init [first] 
	all pre: Time-last | let pos = pre.next | some u:Usuario, c:Carro | addCarro[u, c, pre, pos]
	all pre: Time-last | let pos = pre.next | some c:Carro, s:Servico | addServico[c, s, pre, pos]
}

pred init [t: Time] { 
	no (Usuario.carros).t 
	no (Carro.servicos).t 
}

pred addCarro[u:Usuario, c:Carro, t,t':Time] { 
	c !in (u.carros).t  
	(u.carros).t' = (u.carros).t + c 
}

pred addServico[c:Carro, s:Servico, t,t':Time] { 
	s !in (c.servicos).t  
	(c.servicos).t' = (c.servicos).t + s 
}

pred show[]{}

run show for 5

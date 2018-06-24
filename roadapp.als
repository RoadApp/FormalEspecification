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
	all usr: Usuario | one usr.cnh
	all car: Carro | one car.licenciamento
}

fact parentRestrictions {
	all t:Time, ser: Servico | #ser.~(servicos.t) <= 1
	all t:Time, car: Carro | #car.~(carros.t) <= 1
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
	all pre: Time-last | let pos = pre.next | all u:Usuario | addCarro[u, pre, pos] or mantemCarro[u, pre, pos]
	all pre: Time-last | let pos = pre.next | some c:Carro, s:Servico | addServico[c, s, pre, pos]
}

pred init [t: Time] { 
	no (Carro.servicos).t 
}

pred addCarro[u:Usuario, t,t':Time] { 
	some c:Carro | c !in (u.carros).t and (u.carros).t' = (u.carros).t + c 
}

pred mantemCarro[u:Usuario, t,t':Time] { 
	#(u.(carros.t)) <= #(u.(carros.t'))
}

pred addServico[c:Carro, s:Servico, t,t':Time] { 
	one u:Usuario | c in u.(carros.t')
	s !in (c.servicos).t  
	(c.servicos).t' = (c.servicos).t + s 
}

pred show[]{}

run show for 10

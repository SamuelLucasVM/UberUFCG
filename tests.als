module test
open main

assert PassageiroTemQueSerAlgo { not some p:Pessoa | p in Passageiro and p not in Aluno and p not in Professor and p not in Servidor }
check PassageiroTemQueSerAlgo

assert MotoristaTemQueSerAlgo { not some p:Pessoa | p in Motorista and p not in Aluno and p not in Professor and p not in Servidor }
check MotoristaTemQueSerAlgo

assert PassageiroTemDebito { all p:Pessoa | p in Passageiro => (one d:Debito | d in p) }
check PassageiroTemDebito

assert MotoristaTemCredito { all p:Pessoa | p in Motorista => (one c:Credito | c in p) }
check MotoristaTemCredito

assert PessoasTemRegioes { all p:Pessoa | one r:Regiao | r in p.regiao_morada}
check PessoasTemRegioes

assert CorridaTemMotorista { all c:Corrida | some p:Pessoa | p in c.motorista_corrida}
check CorridaTemMotorista

assert CorridaTemPassageiro { all c:Corrida | #c.passageiros_corrida > 0 && #c.passageiros_corrida < 4}
check CorridaTemPassageiro

assert CorridaTemRegiao { all c:Corrida | some r:Regiao | r in c.regiao_corrida}
check CorridaTemRegiao

assert CorridaTemHorario { all c:Corrida | some h:Horario | h in c.horario_corrida }
check CorridaTemHorario

assert MotoristaNaoEhPassageiro { all c:Corrida | c.motorista_corrida !in c.passageiros_corrida }
check MotoristaNaoEhPassageiro
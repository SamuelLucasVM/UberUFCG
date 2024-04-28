module main

sig Pessoa { regiao_morada: one Regiao }
sig Passageiro in Pessoa {}
fact { all p:Passageiro | p in Sistema.passageiros_sistema }
sig Motorista in Pessoa {}
fact { all m:Motorista | m in Sistema.motoristas_sistema }

sig Debito in Passageiro {}
sig Credito in Motorista {}
fact { all p:Passageiro | one d:Debito | d in p }
fact { all m:Motorista | one c:Credito | c in m }

sig Aluno, Professor, Servidor extends Pessoa {}

abstract sig Regiao {}
one sig Centro, Leste, Oeste, Norte, Sul extends Regiao {}

sig Corrida {
    motorista_corrida: one Motorista,
    passageiros_corrida: set Passageiro,
}
fact { all c:Corrida | c in Sistema.corridas_sistema }
pred MaximoPassageiros [c:Corrida] {
    #c.passageiros_corrida <= 3
}
pred MotoristaNaoPassageiro [c:Corrida] {
    c.motorista_corrida !in c.passageiros_corrida
}
fact { all c:Corrida | MaximoPassageiros[c] && MotoristaNaoPassageiro[c] }

one abstract sig Sistema {
    passageiros_sistema: set Passageiro,
    motoristas_sistema: set Motorista,
    corridas_sistema: set Corrida
}

pred PassageiroValido[p:Passageiro] {
    p in Aluno || p in Professor || p in Servidor
}
fact { all p:Passageiro | PassageiroValido[p] }

assert PassageiroTemQueSerAlgo { not some p:Pessoa | p in Passageiro and p not in Aluno and p not in Professor and p not in Servidor }
check PassageiroTemQueSerAlgo

assert PassageiroTemDebito { all p:Pessoa | p in Passageiro => (one d:Debito | d in p) }
check PassageiroTemDebito

assert MotoristaTemCredito { all p:Pessoa | p in Motorista => (one c:Credito | c in p) }
check MotoristaTemCredito

run {} for 5
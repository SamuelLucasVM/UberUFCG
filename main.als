module main

abstract sig Pessoa { regiao_morada: one Regiao }
sig Passageiro in Pessoa {}
sig Motorista in Pessoa {}

sig Debito in Passageiro {}
sig Credito in Motorista {}
fact { all p:Passageiro | one d:Debito | d in p }
fact { all m:Motorista | one c:Credito | c in m }

sig Aluno, Professor, Servidor extends Pessoa {}

abstract sig Regiao {}
one sig Centro, Leste, Oeste, Norte, Sul extends Regiao {}

abstract sig Horario {}
one sig Ida7, Ida9, Ida13, Ida15, Saida10, Saida12, Saida16, Saida18  extends Horario {}

sig Corrida {
    motorista_corrida: one Motorista,
    passageiros_corrida: set Passageiro,
    regiao_corrida: one Regiao,
    horario_corrida: one Horario
}

pred QuantidadePassageiro [c:Corrida] {
    #c.passageiros_corrida <= 3
    #c.passageiros_corrida > 0
}

pred MotoristaNaoPassageiro [c:Corrida] {
    c.motorista_corrida !in c.passageiros_corrida
}

fact { all c:Corrida | QuantidadePassageiro[c] && MotoristaNaoPassageiro[c] }

run {} for 5 but exactly 3 Corrida

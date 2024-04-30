module main

abstract sig Pessoa { regiao_morada: one Regiao }
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

abstract sig Horario {}
abstract sig Ida extends Horario {}
abstract sig Saida extends Horario {}
one sig Ida7, Ida9, Ida13, Ida15 extends Ida {}
one sig Saida10, Saida12, Saida16, Saida18 extends Saida {}

sig Corrida {
    motorista_corrida: one Motorista,
    passageiros_corrida: set Passageiro,
    regiao_corrida: one Regiao,
    horario_corrida: one Horario
}
fact { all c:Corrida | c in Sistema.corridas_sistema }
pred QuantidadePassageiro [c:Corrida] {
    #c.passageiros_corrida <= 3
    #c.passageiros_corrida > 0
}
pred MotoristaNaoPassageiro [c:Corrida] {
    c.motorista_corrida !in c.passageiros_corrida
}
fact { all c:Corrida | QuantidadePassageiro[c] && MotoristaNaoPassageiro[c] }

one abstract sig Sistema {
    passageiros_sistema: set Passageiro,
    motoristas_sistema: set Motorista,
    corridas_sistema: set Corrida
}

run {} for 5
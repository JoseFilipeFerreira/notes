#!/bin/bash

echo "
16, 1.0, Álgebra Linear EI
10, 1.0, Cálculo
15, 1.5, Elementos de Engenharia de Sistemas
17, 2.0, Laboratórios de Informática I
19, 1.0, Programação Funcional
15, 1.0, Tópicos de Matemática Discreta
12, 1.0, Análise
19, 2.0, Laboratórios de Informática II
10, 1.0, Lógica EI
14, 1.0, Programação Imperativa
15, 1.0, Sistemas de Computação
14, 1.5, Tópicos de Física Moderna
12, 1.0, Algoritmos e Complexidade
16, 2.0, Arquitetura de Computadores
10, 2.0, Comunicação de Dados
10, 1.5, Engenharia Económica
10, 1.5, Estatística Aplicada
10, 1.0, Introdução aos Sistemas Dinâmicos
13, 2.0, Cálculo de Programas
13, 1.5, Eletromagnetismo EE
18, 2.0, Laboratórios de Informática III
16, 1.0, Opção UMinho
14, 1.0, Programação Orientada aos Objetos
13, 2.0, Sistemas Operativos
15, 2.0, Bases de Dados
12, 2.0, Desenvolvimento de Sistemas de Software
11, 1.5, Métodos Numéricos e Otimização não Linear
11, 1.5, Modelos Determinísticos de Investigação Operacional
12, 2.0, Redes de Computadores
15, 2.0, Sistemas Distribuídos
18, 2.0, Computação Gráfica
16, 2.0, Comunicações por Computador
19, 2.0, Laboratórios de Informática IV
12, 1.5, Modelos Estocásticos de Investigação Operacional
17, 2.0, Processamento de Linguagens
15, 2.0, Sistemas de Representação de Conhecimento e Raciocínio
11, 2.0, Arquitecturas Avançadas
16, 2.0, Paradigmas de Computação Paralela
15, 2.0, Segurança de Sistemas Informáticos
11, 2.0, System Deployment and Benchmarking
17, 2.0, Visualização e Iluminação 1
16, 2.0, Visão por Computador
15, 2.0, Algoritmos Paralelos
12, 2.0, Engenharia de Sistemas de Computação
17, 2.0, Visualização e Iluminação II
16, 2.0, Tecnologias e Aplicações
18, 2.0, Laboratório em Engenharia Informática
17, 3.0, Projeto de Informática
0, 9.0, Dissertação
" | awk -F',' \
    '{ mult += $2; sum += $1 * $2 }
     $1 > 0 { mult0 += $2; sum0 += $1 * $2 }
     END {
         print "Media: " (sum / mult);
         print "Media sem zeros: " (sum0 / mult0)
     }
    '

# FPGA - VGA Project

* Alunos: Bernardo Capoferri / Diogo Duarte / Rafael Lima
* Cursos: Engenharia de Computação
* Semestres: 8 / 7 / 6
* Contato: bernardocc@al.insper.edu.br / diogord@al.insper.edu.br / rafaelmal@al.insper.edu.br
* Ano: 2023

## Começando
Para seguir este tutorial é necessário:
* Hardware: DE10-Standard, cabo VGA e Monitor
* Software: Quartus 18.01

Nota: Caso queira aplicar este projeto em outra placa Cyclone V, como por exemplo a DE10-Nano, é necessário apenas alterar o .qsf do arquivo com as pinagens corretas da placa. 
Este tipo de informação pode ser encontrado no manual de usuário das placas.

## Motivação
Como de costume, utilizávamos os LEDs, botões e o display hexadecimal da placa para realizar diversas entregas ou trabalhos. 
Com o desejo de aprofundar nosso conhecimento sobre a placa DE10-Standard, e principalmente sobre a parte gráfica da FPGA, 
decidimos desenvolver um projeto que explorasse outro componente presente nela: a porta VGA.

O tutorial utilizado como motivador e guia do projeto foi: https://projectf.io/posts/fpga-graphics/

## Porta VGA
Um cabo VGA, ou Video Graphics Array, é um tipo de cabo de vídeo que é responsável por conectar e transmitir imagens de um computador para um monitor, de forma analógica.

## Projeto
Neste repositório, foi implementado alguns arquivos em verilog, que tem como finalidade mostrar um retângulo em um monitor, atráves do sinal analógico transmitido pela VGA.
Para implementar em sua placa, basta clonar o repositório e compilar no Quartus. Ao compilar, gravar na placa, e quando finalizar, o retângulo estará na tela do seu monitor


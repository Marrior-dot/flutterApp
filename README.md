# Projeto de Rede social para Alunos da UFPA(Substituir Nome)
projeto que manda postagens para alunos ingressados na rede
* Este software é dividido em 2 camadas, uma para apresentação utilizando flutter e outra para armazenamento e lógico de servidor http e websocket utilizando django
* Versões Utilizadas
  * python 3.10.12
  * Dart SDK version: 3.3.1 (stable) (Wed Mar 6 13:09:19 2024 +0000) on "linux_x64"
  * Django 5.0.3
  * Flutter 3.19.3

## Bibliotecas e dependências
* no diretório `myapi` , executar o comando para instalar as bibliotecas em `requirements.txt`
  <br>
  `cd myapi/
  <br>
   pip install -r /path/to/requirements.txt
  `
* no diretório `projeto_perguntas`, executar o seguinte comando para instalar as dependências em flutter
  <br>
  `cd projeto_perguntas/
  <br>
   flutter pub get
  `
## Execução do código
No momento o projeto se encontra localmente

1. Primeiro, subir o servidor http e websocket
   `cd myapi/
    python3 manage.py runserver localhost:8000
   `
2. Em seguida subir o servidor de apresentação
   `cd projeto_perguntas
   flutter run
   `


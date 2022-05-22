#!/usr/bin/env bash

############################################
# Autor: Leonardo Teixeira                 #
# Server: Servidor firebird Super Server   #
# Version: firebird 2.5.9 x64              #
# CENTOS 7 - 8 e REDHAT derivados          #
# kernel 4.18.0-383.el8.x86_64             #
############################################

echo "atualizando o repositorios"
sudo yum update -y

echo "instalando dependendcias"
sudo yum install libstdc++.so.6 -y
sudo yum install ncurses-compat-libs.x86_64 -y
sudo yum install wget tar -y

echo "Baixando pacote firebird 2.5.9"
wget https://github.com/FirebirdSQL/firebird/releases/download/R2_5_9/FirebirdSS-2.5.9.27139-0.amd64.tar.gz

echo "movendo para opt firebird"
mv FirebirdSS-2.5.9.27139-0.amd64.tar.gz /opt/

echo "trocando de diretorio"
cd /opt/

echo "descompactando aqruivo"
tar -xvf /opt/FirebirdSS-2.5.9.27139-0.amd64.tar.gz

echo "renomeando diretorio firebird"
mv FirebirdSS-2.5.9.27139-0.amd64 firebird.ss

echo "mudando a proprieda do diretorio e arquivos"
chown $USER:$USER -R firebird.ss/

echo "entrando no diretorio firebird"
cd firebird.ss/

echo "instalando servidor"
./install.sh

echo "habilitando e liberando protocolos no firewalld"
sudo firewall-cmd --add-service=ssh --permanent   # conexao ssh
sudo firewall-cmd --add-port=3050/tcp --permanent # porta padrao firebird conexao em rede
sudo firewall-cmd --reload

echo "start service"
sudo service firebird status

echo "fim"

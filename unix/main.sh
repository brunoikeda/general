#/bin/sh
echo "Test"

######################## BASICO ################################
cd								# Change Dir
ls -ltr						# Lista os arquivos e diretorios da pasta ordenando por data de atualizacao.
echo "test"							# Printa na tela
echo "test" > file.txt   # write test in a file.txt
cat file.txt							# Abre o arquivo para leitura/ could use more to read on prompt
ps -ef | grep pid		#retorna os processos em execucao filtrando o pid 
kill -9 pid				#Mata o processo em execucao. OBS: Usar o primeiro numero do comando "ps -ef | grep nome_processo"
grep palavra arquivo			#Pega as linhas que contem a palavra no arquivo
cp arquivo diretorio			#Copia arquivo ou diretorios
mv arquivo diretorio			#Move arquivos
rm arquivo						#Deleta arquivos
mkdir Nome_diretorio			#Cria um diretorio
rmdir Nome_diretorio			#Deleta diretorios
cat arquivo						#Mostra conteudo de um arquivo (para concatenar os dados de dois arquivos usar "cat arquivo1.txt arquivo2.txt > arquivo3.txt"
tail -f arquivo					#Enquanto estiver carregando o arquivo, vai mostrando na tela.
du -hsb (nome do arquivo) 		#retorna o tamanho sempre em bytes (se trocar o -hs por -ha, o comando lista todos os arquivos);
du -hsk (nome do arquivo) 		#retorna o tamanho sempre em KB (se trocar o -hs por -ha, o comando lista todos os arquivos);
du -hsm (nome do arquivo) 		#retorna o tamanho sempre em MB (se trocar o -hs por -ha, o comando lista todos os arquivos); 
df -h							#Mostra a quantidade do disco da base usado
ls | wc -l						#Lista a quantidade de arquivos dentro da pasta.
ls | grep "teste" | wc -l 		#Lista a quantidade de arquivos dentro da pasta e que contenha a palavra "teste". Pode "brincar" com o grep, expr. Regulares dentro da ""...
grep -v 'palavra_excluida'		# Traz tudo menos a palavra excluida
find -iname	nome_do_arquivo		# Faz a busca pelo nome do arquivo no diretorio atual e nos subdiretorios. 
date +"%Y%m%d%H%M%S" 

######################## COMPACTAR ################################
gzip arquivo.txt - compacta removendo o arquivo original e criando o arquivo arquivo.txt.gz;
gzip -c arquivo.ext - faz o mesmo que a operacao acima, mas mantem o arquivo original;
gzip -9 nome.ext - faz uma compactacao maior, removendo o arquivo original e criando o arquivo arquivo.txt.gz;
gzip -cv1 file1.txt file2.txt - compactacao baixa, mantendo o arquivo original e criando os arquivos file1.txt.gz e file2.ext.gz. O parametro 'v' faz com que seja mostrado detalhes da operacao;
gzip -l infowester.gz - lista o conteudo do arquivo infowester.gz;

tar -cf ARQ_FINAL_RCT_MT_2009.TAR *FINAL_RCT_MT_2009* - Junta todos os arquivos com a descricao FINAL_RCT_MT_2009 no arquivo ARQ_FINAL_RCT_MT_2009.TAR
tar -cf NOME_DO_ARQUIVO_SAIDA.TAR MASCARA_DOS_ARQUIVOS


################### DESCOMPACTAR ##############################
gzip -d arquivo.txt.gz - descompacta o arquivo arquivo.txt.gz.
gunzip nomedoarquivo.gz
tar -xvf nomedoarquivo.tar

################### Transferir arquivos entre maquinas ###########################
#cd na pasta de destino e depois usar os comandos.
	sftp user@host  #sftp user@host
	password			 #Senha	
	get <NOME_ARQUIVO>	 #Ao inves do nome do arquivo, pode passar tambem o diretorio completo!	

################### OPERACOES #################################
# https://aurelio.net/shell/canivete/
## IF - String
PARAM_ENT="S"
if [ "$PARAM_ENT" = "S" ]; then
    echo "entrou"
else
    echo "saiu"
fi

## IF - Number
PARAM_ENT=1
if [ $PARAM_ENT -gt 0 ]; then
    echo "entrou"
else
    echo "saiu"
fi

#/bin/sh
echo "Test"

######################## BASICO ################################
cd								# Change Dir
ls -ltr						# Lista os arquivos e diret�rios da pasta ordenando por data de atualiza��o.
echo "test"							# Printa na tela
echo "test" > file.txt   # write test in a file.txt
cat file.txt							# Abre o arquivo para leitura/ could use more to read on prompt
ps -ef | grep pid		--retorna os processos em execu��o filtrando o pid 
kill -9 pid				--Mata o processo em execu��o. OBS: Usar o primeiro numero do comando "ps -ef | grep nome_processo"
grep palavra arquivo			--Pega as linhas que contem a palavra no arquivo
cp arquivo diret�rio			--Copia arquivo ou diret�rios
mv arquivo diret�rio			--Move arquivos
rm arquivo						--Deleta arquivos
mkdir Nome_diret�rio			--Cria um diret�rio
rmdir Nome_diret�rio			--Deleta diret�rios
cat arquivo						--Mostra conte�do de um arquivo (para concatenar os dados de dois arquivos usar "cat arquivo1.txt arquivo2.txt > arquivo3.txt"
tail -f arquivo					--Enquanto estiver carregando o arquivo, vai mostrando na tela.
du -hsb (nome do arquivo) 		--retorna o tamanho sempre em bytes (se trocar o -hs por -ha, o comando lista todos os arquivos);
du -hsk (nome do arquivo) 		--retorna o tamanho sempre em KB (se trocar o -hs por -ha, o comando lista todos os arquivos);
du -hsm (nome do arquivo) 		--retorna o tamanho sempre em MB (se trocar o -hs por -ha, o comando lista todos os arquivos); 
df -h							--Mostra a quantidade do disco da base usado
ls | wc -l						--Lista a quantidade de arquivos dentro da pasta.
ls | grep "teste" | wc -l 		--Lista a quantidade de arquivos dentro da pasta e que contenha a palavra "teste". Pode "brincar" com o grep, expr. Regulares dentro da ""...
grep -v 'palavra_excluida'		-- Traz tudo menos a palavra excluida
find -iname	nome_do_arquivo		-- Faz a busca pelo nome do arquivo no diret�rio atual e nos subdiret�rios. 

######################## COMPACTAR ################################
gzip arquivo.txt - compacta removendo o arquivo original e criando o arquivo arquivo.txt.gz;
gzip -c arquivo.ext - faz o mesmo que a opera��o acima, mas mant�m o arquivo original;
gzip -9 nome.ext - faz uma compacta��o maior, removendo o arquivo original e criando o arquivo arquivo.txt.gz;
gzip -cv1 file1.txt file2.txt - compacta��o baixa, mantendo o arquivo original e criando os arquivos file1.txt.gz e file2.ext.gz. O par�metro 'v' faz com que seja mostrado detalhes da opera��o;
gzip -l infowester.gz - lista o conte�do do arquivo infowester.gz;

tar -cf ARQ_FINAL_RCT_MT_2009.TAR *FINAL_RCT_MT_2009* - Junta todos os arquivos com a descri��o FINAL_RCT_MT_2009 no arquivo ARQ_FINAL_RCT_MT_2009.TAR
tar -cf NOME_DO_ARQUIVO_SAIDA.TAR MASCARA_DOS_ARQUIVOS


################### DESCOMPACTAR ##############################
gzip -d arquivo.txt.gz - descompacta o arquivo arquivo.txt.gz.
gunzip nomedoarquivo.gz
tar -xvf nomedoarquivo.tar

################### Transferir arquivos entre maquinas ###########################
--cd na pasta de destino e depois usar os comandos.
	sftp user@host  --sftp user@host
	password			 --Senha	
	get <NOME_ARQUIVO>	 --Ao inv�s do nome do arquivo, pode passar tambem o diret�rio completo!	

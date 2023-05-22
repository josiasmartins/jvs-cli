#!/bin/bash

# Mova o script "jvs" para um diretório do PATH
mv jvs.sh /user/local/bin/jvs

# Crie um alias para o comando "jvs" no arquivo de perfil do Bash
echo "alias jvs='bash /usr/local/bin/jvs'" >> ~/.bashrc

# Carregue as alterações no arquivo de perfil do Bash
source ~/.bashrc

echo "Configuração concluída. Agora você pode usar 'jvs' para executar o script."

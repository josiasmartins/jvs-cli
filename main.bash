#!/bin/bash

# Diretório onde as versões do Java serão armazenadas
JVS_DIR=~/.jvs

# Função para trocar a versão do Java
change_java_version() {
    read -p "Informe a versão do Java: " version
    if [ -d "$JVS_DIR/$version" ]; then
        ln -sf "$JVS_DIR/$version" "$JVS_DIR/current"  # Cria um link simbólico chamado 'current' para a versão selecionada
        echo "Versão do Java alterada para $version"
    else
        echo "Versão não encontrada. Use 'jvs list' para ver as versões disponíveis."
    fi
}

# Função para adicionar uma nova versão do Java
add_java_version() {
    read -p "Informe o caminho para a instalação do Java: " java_path
    if [ -d "$java_path" ]; then
        version=$(basename "$java_path")  # Extrai o nome da versão do diretório fornecido
        mkdir -p "$JVS_DIR/$version"  # Cria o diretório para a nova versão
        cp -R "$java_path"/* "$JVS_DIR/$version"  # Copia o conteúdo do diretório fornecido para a nova versão
        echo "Versão do Java adicionada: $version"
    else
        echo "Diretório não encontrado. Verifique o caminho fornecido."
    fi
}

# Função para listar as versões disponíveis do Java
list_java_versions() {
    if [ -d "$JVS_DIR" ] && [ "$(ls -A "$JVS_DIR")" ]; then
        echo "Versões do Java disponíveis:"
        ls -1 "$JVS_DIR"
    else
        echo "Nenhuma versão do Java encontrada. Use 'jvs add' para adicionar uma versão."
    fi
}

# Verifica se o diretório JVS_DIR existe, caso contrário, cria
if [ ! -d "$JVS_DIR" ]; then
    mkdir -p "$JVS_DIR"  # Cria o diretório JVS_DIR, incluindo qualquer diretório pai necessário
fi

command="$1"

# Verifica qual comando foi fornecido e executa a função correspondente
case $command in
    "use")
        change_java_version
        ;;
    "add")
        add_java_version
        ;;
    "list")
        list_java_versions
        ;;
    *)
        echo "Comando inválido. Use 'jvs use', 'jvs add' ou 'jvs list'."
        ;;
esac

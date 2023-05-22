#!/bin/bash

# Função para baixar e instalar uma nova versão do Java
function install_java() {
    local version=$1

    # URL do site da Oracle para download do Java
    local download_url="https://www.oracle.com/java/technologies/javase-jdk${version}-downloads.html"

    # Extrai o link do botão de download da página do Oracle para a versão especificada
    local download_link=$(curl -s "$download_url" | grep -oE 'https://.*jdk.*_windows-x64_bin.exe')

    if [ -z "$download_link" ]; then
        echo "Erro: Não foi possível encontrar o link de download para o Java versão $version."
        exit 1
    fi

    # Baixa o arquivo de instalação do Java
    local installer_filename="jdk${version}_installer.exe"
    curl -L -o "$installer_filename" "$download_link"

    # Executa o instalador silenciosamente para instalar o Java
    ./"$installer_filename" /s INSTALLDIR=/"Java/$version"

    # Remove o arquivo de instalação
    rm "$installer_filename"

    echo "Java versão $version instalado com sucesso."
}

# Função para alternar para uma versão do Java
function switch_java() {
    local version=$1

    # Verifica se o diretório da versão do Java existe
    local java_dir="$HOME/.jvs/Java/$version"
    if [ ! -d "$java_dir" ]; then
        echo "Erro: Java versão $version não está instalado."
        exit 1
    fi

    # Define o JAVA_HOME para a versão do Java selecionada
    export JAVA_HOME="$java_dir"

    echo "Java versão $version selecionado."
}

# Função para listar as versões disponíveis do Java
function list_java_versions() {
    local java_dir="$HOME/.jvs/Java"

    if [ ! -d "$java_dir" ]; then
        echo "Nenhuma versão do Java encontrada."
    else
        echo "Versões do Java disponíveis:"
        ls -1 "$java_dir"
    fi
}

# Função para exibir a versão atual do script
function show_script_version() {
    local version=$(grep -oP "(?<=^# Versão: ).*" "$0")
    echo "JVS - Java Version Switcher (versão $version)"
}

# Verifica o número de argumentos passados
if [ $# -lt 1 ]; then
    echo "Uso: jvs <comando> [argumento]"
    exit 1
fi

# Verifica o comando passado
case $1 in
    add)
        if [ $# -lt 2 ]; then
            echo "Uso: jvs add <versão>"
            exit 1
        fi
        install_java "$2"
        ;;
    use)
        if [ $# -lt 2 ]; then
            echo "Uso: jvs use <versão>"
            exit 1
        fi
        switch_java "$2"
        ;;
    list)
        list_java_versions
        ;;
    --version)
        show_script_version
        ;;
    *)
        echo "Comando inválido: $1"
        exit 1
        ;;
esac

# alias jvs="bash jvs.sh"


# #!/bin/bash

# # Diretório onde as versões do Java serão armazenadas
# JVS_DIR=~/.jvs

# # Função para trocar a versão do Java
# change_java_version() {
#     read -p "Informe a versão do Java: " version
#     if [ -d "$JVS_DIR/$version" ]; then
#         ln -sf "$JVS_DIR/$version" "$JVS_DIR/current"  # Cria um link simbólico chamado 'current' para a versão selecionada
#         echo "Versão do Java alterada para $version"
#     else
#         echo "Versão não encontrada. Use 'jvs list' para ver as versões disponíveis."
#     fi
# }

# # Função para adicionar uma nova versão do Java
# add_java_version() {
#     read -p "Informe o caminho para a instalação do Java: " java_path
#     if [ -d "$java_path" ]; then
#         version=$(basename "$java_path")  # Extrai o nome da versão do diretório fornecido
#         mkdir -p "$JVS_DIR/$version"  # Cria o diretório para a nova versão
#         cp -R "$java_path"/* "$JVS_DIR/$version"  # Copia o conteúdo do diretório fornecido para a nova versão
#         echo "Versão do Java adicionada: $version"
#     else
#         echo "Diretório não encontrado. Verifique o caminho fornecido."
#     fi
# }

# # Função para listar as versões disponíveis do Java
# list_java_versions() {
#     if [ -d "$JVS_DIR" ] && [ "$(ls -A "$JVS_DIR")" ]; then
#         echo "Versões do Java disponíveis:"
#         ls -1 "$JVS_DIR"
#     else
#         echo "Nenhuma versão do Java encontrada. Use 'jvs add' para adicionar uma versão."
#     fi
# }

# # Verifica se o diretório JVS_DIR existe, caso contrário, cria
# if [ ! -d "$JVS_DIR" ]; then
#     mkdir -p "$JVS_DIR"  # Cria o diretório JVS_DIR, incluindo qualquer diretório pai necessário
# fi

# command="$1"

# # Verifica qual comando foi fornecido e executa a função correspondente
# case $command in
#     "use")
#         change_java_version
#         ;;
#     "add")
#         add_java_version
#         ;;
#     "list")
#         list_java_versions
#         ;;
#     *)
#         echo "Comando inválido. Use 'jvs use', 'jvs add' ou 'jvs list'."
#         ;;
# esac

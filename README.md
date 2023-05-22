# JVS - Java Version Switcher

O JVS (Java Version Switcher) é um utilitário de linha de comando (CLI) em Bash que permite alternar entre diferentes versões do Java em sua máquina.

## Requisitos

- Bash (Bourne Again SHell)
- Java instalado nas versões que você deseja alternar

## Instalação

1. Faça o download do script `jvs` para o seu diretório preferido.
2. Abra um terminal e navegue até o diretório onde você salvou o arquivo `jvs`.
3. Dê permissão de execução ao arquivo `jvs` com o comando: `chmod +x jvs`.

## Uso

O script `jvs` oferece os seguintes comandos:

- `use`: Altera a versão do Java para a versão desejada.
- `add`: Adiciona uma nova versão do Java ao JVS.
- `list`: Lista as versões disponíveis do Java.

### Comando `use`

Use o comando `use` para selecionar uma versão específica do Java. O script solicitará que você informe a versão do Java desejada.

Exemplo:
```bash
jvs use

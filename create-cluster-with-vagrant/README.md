# Create Cluster with Vagrant

Este projeto utiliza o Vagrant para criar e configurar um cluster Kubernetes com uma máquina principal e dois nós.

## Estrutura do Projeto

```
create-cluster-with-vagrant/
├── .gitignore
├── ubuntu-bionic-18.04-cloudimg-console.log
├── Vagrantfile
├── .vagrant/
├── scripts/
│   ├── join.sh
│   ├── k8s-node.sh
│   ├── k8s-principal.sh
```

- **Vagrantfile**: Arquivo de configuração do Vagrant que define as máquinas virtuais.
- **scripts/**: Scripts de provisionamento para configurar as máquinas.

## Pré-requisitos

Certifique-se de ter os seguintes softwares instalados:

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)

## Como Subir o Cluster

1. Clone este repositório:

   ```bash
   git clone <URL_DO_REPOSITORIO>
   cd create-cluster-with-vagrant
   ```

2. Inicie as máquinas virtuais com o Vagrant:

   ```bash
   vagrant up
   ```

   Este comando criará e configurará as máquinas virtuais definidas no `Vagrantfile`.

3. Verifique se as máquinas estão rodando:

   ```bash
   vagrant status
   ```

   Você deve ver as máquinas `k8s-principal`, `k8s-node-01` e `k8s-node-02` listadas como "running".

## Acessando as Máquinas

Para acessar qualquer uma das máquinas, use o comando:

```bash
vagrant ssh <nome_da_maquina>
```

Por exemplo, para acessar a máquina principal:

```bash
vagrant ssh k8s-principal
```

## Limpando o Ambiente

Para destruir as máquinas virtuais e liberar recursos:

```bash
vagrant destroy -f
```

## Observações

- Certifique-se de que o VirtualBox tenha recursos suficientes (CPU, memória) para rodar as máquinas virtuais.
- Os scripts de provisionamento estão localizados na pasta `scripts/` e podem ser ajustados conforme necessário.

## Licença

Este projeto é distribuído sob a licença MIT.
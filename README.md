# Monitor de Backups Automático para FileZilla (Debian 13 / GNOME)

Este projeto cria um **backup automático dos arquivos editados no FileZilla** usando um diretório temporário (`TMPDIR`) e um script de monitoramento em Bash.
Funciona em qualquer Debian/GNOME sem precisar de pacotes adicionais.

---

## Funcionalidades

* Monitora uma pasta temporária onde o FileZilla salva arquivos editados.
* Cria backups diários com timestamp.
* Mantém uma cópia `latest_arquivo` para comparação.
* Gera log detalhado de todos os backups.
* Pode iniciar automaticamente junto com o GNOME.

---

## Estrutura final do backup

```
~/filezilla_backups/
├── backup.log
├── 2025-10-15/
│   ├── 12-15-30_index.html
│   ├── 12-16-05_config.php
│   └── latest_index.html
├── 2025-10-16/
│   └── ...
```

---

## Como usar

### 1️⃣ Preparar TMPDIR personalizado

```bash
mkdir -p ~/filezilla_temp
env TMPDIR=$HOME/filezilla_temp filezilla
```

Todos os arquivos editados serão salvos em `~/filezilla_temp`.

---

### 2️⃣ Instalar o script de monitoramento

1. Baixe o script `monitor_filezilla_backups.sh` para seu diretório home.
2. Dê permissão de execução:

```bash
chmod +x ~/monitor_filezilla_backups.sh
```

3. Teste manualmente:

```bash
~/monitor_filezilla_backups.sh &
```

---

### 3️⃣ Automatizar na inicialização do GNOME

1. Crie a pasta de autostart (se não existir):

```bash
mkdir -p ~/.config/autostart
```

2. Crie o arquivo `monitor_filezilla_backups.desktop`:

```ini
[Desktop Entry]
Type=Application
Name=Monitor FileZilla
Exec=/home/SEU_USUARIO/monitor_filezilla_backups.sh
Comment=Backup automático dos arquivos do FileZilla
X-GNOME-Autostart-enabled=true
```

Substitua `SEU_USUARIO` pelo seu usuário do Linux.

> Opcional: criar um `.desktop` para abrir o FileZilla automaticamente com TMPDIR.

---

### 4️⃣ Verificar monitor ativo

```bash
ps aux | grep monitor_filezilla_backups.sh
```

Se aparecer na lista, o monitor está funcionando.

---

## Observações

* Este script **não usa `inotify-tools`**, ele funciona apenas com comandos padrão do Linux.
* O monitor verifica alterações **a cada 5 segundos**, criando backups apenas quando o conteúdo do arquivo muda.

---

### Licença

MIT License

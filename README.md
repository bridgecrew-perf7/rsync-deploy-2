# 🍣 Rsync Deployment Action

A really lightweight GitHub Action which deploys files from **`GITHUB_WORKSPACE`** to a remote folder via rsync over SSH.

The underlaying base-image of the docker-image is very small, which results in fast deployments.

Use this action in your CD workflow which creates deployable code in **`GITHUB_WORKSPACE`** and copy afterwards via rsync to your remote destination server over SSH.


## Inputs

## `user`

**Required** The username of your remote SSH server.

## `server`

**Required** The servername as FQDN or IP.

## `port`

**Required** The remote server port. Default **`"22"`**.

## `ssh_private_key`

**Required** Your private SSH key which is created only for this action and stored in Github Secret.

## `local_path`

**Required** The path of your deployable code.

## `remote_path`

**Required** The destination of your deployed code.

## `switches` 

Possible switches which you can find here on the [rsync man page](https://download.samba.org/pub/rsync/rsync.1). Default **`"-azP"`** 

## Example usage

Example usage to sync thing your files in the workspace folder:

```
name: Deploy with Rsync
on: push
jobs:
  deploy:
    name: Deploy
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Deploy files
      uses: pace-engineering/rsync-deploy@main
      with:
          user: ${{ secrets.SSH_USER }}
          server: ${{ secrets.SSH_SERVER }}
          port: ${{ secrets.SSH_SERVER }}
          ssh_private_key: ${{ secrets.SSH_PRIVATE_KEY }}
          local_path: '/tmp'
          remote_path: '/www/html'
          switches: '-avzrP --delete --exclude node_modules --exclude '.git*''
```

## Input parameters

Input | Description | Required | Default
--- | --- | --- | ---
**user** |  | Yes | N/A
**server** | | Yes | N/A
**port** | | Yes | `22`
**ssh_private_key** | | Yes | N/A
**local_path** | | Yes | N/A
**remote_path** | | Yes | N/A
**switches** | | No | `-azP`

## Development

```bash
docker build -t rsync-deploy .
```

```bash
docker run \
-e INPUT_SERVER="host.pace.engineering" \
-e INPUT_PORT="22" \
-e INPUT_USER="root" \
-e INPUT_SSH_PRIVATE_KEY="~/.ssh/id_rsa" \
-e INPUT_LOCAL_PATH="./files" \
-e INPUT_REMOTE_PATH="./www" \
-e INPUT_SWITCHES="-azP" \
rsync-deploy:latest
```

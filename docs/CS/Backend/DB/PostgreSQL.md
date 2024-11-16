# PostgreSQL

[PostgreSQL Tutorial](https://www.postgresqltutorial.com/)
[DBA Roadmap: Learn to become a database administrator with PostgreSQL](https://roadmap.sh/postgresql-dba)

## Initial Config

### PostgreSQL

#### [Install](https://www.postgresql.org/download/linux/ubuntu/)

Automated repository configuration:

```bash
sudo apt install -y postgresql-common  
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
```

```bash
# Update the package lists:
sudo apt update

# Install the latest version of PostgreSQL:
# If you want a specific version, use 'postgresql-16' or similar instead of 'postgresql'
sudo apt -y install postgresql-16
```

start/stop app

```bash
sudo systemctl start/stop postgresql
```

start/stop as start up

```bash
sudo systemctl enable/disable postgresql
```

#### Configure PostgreSQL Server (remote)

[Install PostgreSQL on Linux (Ubuntu)](https://www.postgresqltutorial.com/postgresql-getting-started/install-postgresql-linux/)
set listening port as `listen_addresses = '*'`

```bash
sudo nano /etc/postgresql/16/main/postgresql.conf
```

enable remote connections

```bash
sudo sed -i '/^host/s/ident/md5/' /etc/postgresql/16/main/pg_hba.conf sudo sed -i '/^local/s/peer/trust/' /etc/postgresql/16/main/pg_hba.conf echo "host all all 0.0.0.0/0 md5" | sudo tee -a /etc/postgresql/16/main/pg_hba.conf
sudo systemctl restart postgresql
sudo ufw allow 5432/tcp
```

#### Connection

switch to `postgres` user and get into `psql`

```bash
sudo -u postgres psql
```

input your password then with `\q` to quit

```bash
\password postgres
```

> [!info] Default User
> username: postgres
> pswd: postgres
> port: 5423
> ip: localhost

### pgAdmin

#### [Install](https://www.pgadmin.org/download/pgadmin-4-apt/)

a web-based tool to connect to the PostgreSQL server

[PostgreSQL Administration](https://www.postgresqltutorial.com/postgresql-administration/)

Setup the Repository

```bash
# Install the public key for the repository (if not done previously):
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg

# Create the repository configuration file:
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
```

Install pgAdmin

```bash
# Install for both desktop and web modes:
sudo apt install pgadmin4

# Install for desktop mode only: for local development
sudo apt install pgadmin4-desktop

# Install for web mode only:  for remote server
sudo apt install pgadmin4-web 

# Configure the webserver, if you installed pgadmin4-web:
sudo /usr/pgadmin4/bin/setup-web.sh
```

Dark model `Preferences --> User Interface --> Themes --> Dark`

Register [Server Dialog — pgAdmin 4 8.11 documentation](http://127.0.0.1:37813/help/help/server_dialog.html)

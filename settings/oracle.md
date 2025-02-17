# Oracle

* [Install Linux Oracle Instant Client](#install-linux-oracle-instant-client)

## Install Linux Oracle Instant Client 

From Oracle [download site](https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html)

```bash
sudo mkdir -p /opt/oracle
sudo apt install libaio1t64 libaio-dev alien
sudo ln -s /usr/lib/x86_64-linux-gnu/libaio.so.1t64 /usr/lib/libaio.so.1

cd ~/Downloads
oracle_version=23.7.0.25.01
wget "https://download.oracle.com/otn_software/linux/instantclient/2370000/oracle-instantclient-basic-${oracle_version}-1.el9.x86_64.rpm"
wget "https://download.oracle.com/otn_software/linux/instantclient/2370000/oracle-instantclient-sqlplus-${oracle_version}-1.el9.x86_64.rpm"
wget "https://download.oracle.com/otn_software/linux/instantclient/2370000/oracle-instantclient-devel-${oracle_version}-1.el9.x86_64.rpm"


sudo alien -i oracle-instantclient-basic-${oracle_version}-1.el9.x86_64.rpm
sudo alien -i oracle-instantclient-sqlplus-${oracle_version}-1.el9.x86_64.rpm
sudo alien -i oracle-instantclient-sdk-${oracle_version}-1.el9.x86_64.rpm

oracle_folder=23

cd ~/
echo -e "\\nORACLE_HOME=\"/usr/lib/oracle/${oracle_folder}/client64\"" >> ~/.profile
echo -e "PATH=\"\$PATH:\$ORACLE_HOME/bin\"" >> ~/.profile
echo -e "OCI_LIB_DIR=\"\$ORACLE_HOME/lib\"" >> ~/.profile
echo -e "OCI_INC_DIR=\"/usr/include/oracle/${oracle_folder}/client64\"" >> ~/.profile
echo -e "([[ -n "\$LD_LIBRARY_PATH" ]] && LD_LIBRARY_PATH=\"\$LD_LIBRARY_PATH:\$ORACLE_HOME/lib\" || LD_LIBRARY_PATH=\"\$ORACLE_HOME/lib\")" >> ~/.profile

sudo echo -e "$ORACLE_HOME/lib" >> /etc/ld.so.conf.d/oracle.conf 
sudo chmod o+r /etc/ld.so.conf.d/oracle.conf
sudo ldconfig

sqlplus sys/xe@oracle-xe:1521/xe as sysdba

```

If you are using zsh, you need to add .profile to .zprofile with:

```bash
[[ -f "$HOME/.profile" ]] && source "$HOME/.profile"
```
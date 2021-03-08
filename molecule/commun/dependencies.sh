echo "Installation des dépendances"
/usr/bin/pip3 install --user -r requirements.yaml 
/usr/local/bin/ansible-galaxy install -r molecule/commun/requirements.yml
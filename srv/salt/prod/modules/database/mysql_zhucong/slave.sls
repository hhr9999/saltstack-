include:
  - modules.database.mysql.install

copy-my_conf:
  file.managed:
    - name: /etc/my.cnf.d/slave.cnf
    - source: salt://modules/database/mysql_zhucong/files/slave.cnf
    - user: root
    - group: root
    - mode: '0644'

mysqld.service:
  service.running:
    - reload: true
    - enable: true
    - watch:
      - file: /etc/my.cnf.d/slave.cnf

set-password:
  cmd.run:
    - name: {{ pillar['mysql_install_dir'] }}/mysql/bin/mysql -e "set password = password('{{ pillar['mysql_password'] }}');"
    - unless: {{ pillar['mysql_install_dir'] }}/mysql/bin/mysql -uroot -p{{ pillar['mysql_password'] }} -e 'exit'


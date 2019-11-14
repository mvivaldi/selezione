httpd:
  pkg.installed

httpd Service:
  service.running:
    - name: httpd
    - enable: True
    - require:
      - pkg: httpd
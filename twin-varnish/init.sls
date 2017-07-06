{% for ServiceId, Service in salt['pillar.get']('Services', {}).items() if Service.Type|default('') == 'twin-varnish' %}

varnish-ensure-fpfis-repo:
  file.managed:
    - name: /etc/yum.repos.d/fpfis.repo
    - source: http://repo.ne-dev.eu/el/6/fpfis.repo
    - creates: /etc/yum.repos.d/fpfis.repo
    - source_hash: sha256=5a329baf4d1aebc607f131926cb2b44d80330f85d85bac4f4647e02c2484267b

varnish-stack-installed:
  pkg.installed:
    - update: true
    - pkgs:
      - varnish
      - varnish-modules
      - vmod-drupal7
    - require:
      - file: varnish-ensure-fpfis-repo


/var/lib/varnish:
  file.directory:
    - user: {{ Service.UnixUser }}
    - mode: 2770
    - require:
      - pkg: varnish-stack-installed


{% endfor %}

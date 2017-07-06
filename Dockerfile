FROM fpfis/fpfis-base:latest
# Prepare salt :
ADD top.sls /srv/salt/top.sls
ADD tests/pillar.top.sls /srv/pillar/top.sls
ADD pillar.example /srv/pillar/pillar.sls
ADD twin-varnish /srv/salt/twin-varnish
RUN salt-call --local grains.append roles twin-varnish && salt-call --retcode-passthrough -l info --local state.apply
ADD tests /tests
EXPOSE 6032
EXPOSE 6033
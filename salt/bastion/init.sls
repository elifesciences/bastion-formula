ssh-config:
    file.managed:
        - name: /home/{{ pillar.elife.deploy_user.username }}/.ssh/config
        - contents: |
            Host *.elife.internal
                User elife
            Host *.elifesciences.org
                User elife
        - makedirs: True
        - user: {{ pillar.elife.deploy_user.username }}
        - group: {{ pillar.elife.deploy_user.username }}
        - mode: 644
        - require:
            - deploy-user

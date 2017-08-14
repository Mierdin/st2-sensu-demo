#!/bin/bash

st2 login st2admin --password Password1!

st2 pack install sensu

sudo cp /opt/stackstorm/packs/sensu/sensu.yaml.example /opt/stackstorm/configs/sensu.yaml

st2ctl reload --register-configs

# Sensu + StackStorm Demo

A simple, single-node demonstration of Sensu and StackStorm working together for the auto-remediation win.

This leverages scripts from [st2vagrant](https://github.com/StackStorm/st2vagrant) to install StackStorm, then some additional scripts to set up Sensu - all on a single virtual machine for demo purposes.

# Links

[Sensu Documentation](https://sensuapp.org/docs/)

[StackStorm Documentation](https://docs.stackstorm.com/)

[Sensu Pack for StackStorm](https://github.com/StackStorm-Exchange/stackstorm-sensu)

# Demo Summary

Instantiating this virtual machine with `vagrant up` should eventually yield a single-node installation where all Sensu and StackStorm components are running. You can run `vagrant ssh`, and then the following steps once inside the shell, to perform the demo:

We can see a list of Sensu actions:

```
st2 action list --pack=sensu
```

A good way to get a sense (get it?) of how things are set up, is to run the three actions for listing Sensu's clients, checks, and events (respectively):

```
st2 run sensu.client_list
st2 run sensu.check_list
st2 run sensu.event_list
```




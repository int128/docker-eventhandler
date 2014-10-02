Docker Event Handler
====================

A simple bash script which listens to Docker events and runs a command for each event.


Run
---

```sh
./eventhandler.sh
```

Past events can be replayed as follows:

```sh
./eventhandler.sh --since=2014-09-01
```

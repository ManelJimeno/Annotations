# Django

## How to debug a Django project using Visual Studio Code

Visual Studio and the VS Code use a server to debug Django websites. The implementation is inside packages [DEBUGPY](https://github.com/microsoft/debugpy/), If you're using Visual Studio 2019 16.5 or later, or [PTVSD](https://github.com/microsoft/ptvsd) for Visual Studio 2019 16.4 or earlier, including Visual Studio 2017. The use is the same for practical purposes, using one name or another in the manage.py or requirements.txt file. This example uses the PTVSD package, operational in version 1.61.2 of Visual Studio Code.

We need to add the requirement in the requirements.txt file

``` text
ptvsd == 4.3.2
```

or

``` text
debugpy
```

We need to configure manage.py to start the debug server, when the site is in DEBUG mode.

``` bash
#!/usr/bin/env python
import os
import sys

if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "web_fluendo.settings_fluendo")

    from django.core.management import execute_from_command_line
    from django.conf import settings

    if settings.DEBUG:
        if os.environ.get('RUN_MAIN') or os.environ.get('WERKZEUG_RUN_MAIN'):
            import ptvsd
            ptvsd.enable_attach(address = ('0.0.0.0', 3000))
            print("Attached remote debugger")

    execute_from_command_line(sys.argv)
```

## Debuggind a Django inside a Docker with VS Code

We need to opoen the debug port, if we're using docker-compose the section is ports:

``` Dockerfile
    ports:
      - "8000:8000"
      - "3000:3000"
```

We need to indicate in the launch.json file the server address and the equivalence between the local and remote volume.

``` json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Attach to Django docker",
            "type": "python",
            "request": "attach",
            "pathMappings": [
                {
                    "localRoot": "${workspaceFolder}",
                    "remoteRoot": "/web"
                }
            ],
            "port": 3000,
            "host": "127.0.0.1",
        }
    ]
}
```

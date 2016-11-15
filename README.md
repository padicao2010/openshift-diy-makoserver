## OpenShift Do-It-Yourself

The OpenShift `diy` cartridge documentation can be found [here](https://github.com/openshift/origin-server/blob/master/documentation/oo_cartridge_guide.adoc)

## Mako Server

[Mako Server](https://makoserver.net/) is a compact application and web server, helps developers rapidly design IoT and web applications.

Mako Server deploys **Lua Server Pages* (LSP), which are based on the Lua scripting language and make developing web applications extremely fast, simple, safe, and fun.

## How Mako Server works in OpenShift Do-It-Yourself

### Directory tree

+ **.openshift**: profiles for OpenShift Do-It-Yourself
+ **diy**: contents of the web application
+ **mako**: files related to Mako Server, including binary and configuration

### Modify Mako Server

Mako Server forcely binds both http port and https/ssl port. However, OpenShift DIY can only supports binding 8080. Therefore https/ssl must be disabled. 

I unzip *mako.zip*, comment all codes related to https/ssl in file *.openports*, and rezip *mako.zip*.

### Work with DIY

*.openshift/action_hooks/start* is responsible for starting the MakoServer. It generates *mako.conf*, and then starts *mako* in daemon mode.

```sh
# Part of start
MAKODIR=${OPENSHIFT_REPO_DIR}/mako
cat << EOF > ${MAKODIR}/mako.conf
port=$OPENSHIFT_DIY_PORT
host="$OPENSHIFT_DIY_IP"
apps={
    {
        name="", 
        path="$OPENSHIFT_REPO_DIR/diy"
    }
}
EOF
${MAKODIR}/mako -c ${MAKODIR}/mako.conf -d
```

*.openshift/action_hooks/stop* is responsible for stopping the MakoServer.

```sh
# Part of stop
kill `ps -ef | grep mako | grep -v grep | awk '{ print $2 }'`
```

### Example

See [DIY](https://diy.yvanhom.com).


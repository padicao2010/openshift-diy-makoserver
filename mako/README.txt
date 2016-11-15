*** Documentation:

The Mako Server is a (limited) derivative of the Barracuda Application
Server. The documentation for the Mako Server is therefore split into
two parts, (A) and (B) respectively, to avoid repetition.

Part A - Documentation which is unique and specific to the Mako Server.
Part B - API for the Barracuda Application Server relative to both environments.

The Mako Server documentation (Part A) can be found online,
starting at the following URL:
https://makoserver.net/documentation/manual/

The Barracuda Application Server documentation (Part B) is included in
the tutorial bundle, but can also be viewed online at the following
URL: https://realtimelogic.com/ba/doc/


*** Tutorials (bundle)

The included script rundemo.sh instructs the Mako Server to start the
application "tutorial/DownloadTutorials.zip". This application is
designed to download and start all tutorials and load the Barracuda
Application Server documentation. The tutorials and documentation is
downloaded and installed in $HOME/lspapps. We recommend using this
script each time you plan on loading the tutorials.

Run the script as follows from a command line shell: ./rundemo.sh

*** Use Behind a Proxy

Users behind a proxy must (manually) download the tutorials. The
application DownloadTutorials.zip will fail if started behind a
firewall.

How to manually download and run the tutorials is explained at the
following page: https://makoserver.net/documentation/manual/

Special Instruction: 

The script rundemo.sh asks you if you want to start the server as the
user root or using your current login credentials. Starting the server
as root (using sudo) enables the server to open the default ports 80
(HTTP) and 443 (HTTPS). The server is only running as root while the
port numbers are opened.

The rundemo.sh script instructs the Mako Server to downgrade the user
from root to your current user ID after opening the server ports.

The server will use alternate port numbers (above 1024) if it is
unable to open the default ports 80 and 443.

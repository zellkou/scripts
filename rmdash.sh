sudo ln -sf /bin/bash /bin/sh;
sudo ln -sf /bin/bash /bin/sh.distrib;
sudo sed -i 's/dash/bash/g' /var/lib/dpkg/diversions;
sudo apt purge dash

##function nord()
    {
        cd /etc/openvpn
        sudo wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip;
        sudo unzip -u ovpn.zip;
        sudo rm ovpn.zip;
        cd ovpn_tcp;
        sudo find . -type f -name \*.ovpn -exec sed -i.bak "s|auth-user-pass|auth-user-pass ../auth.txt|g" {} +;
        cd ../ovpn_udp;
        sudo find . -type f -name \*.ovpn -exec sed -i.bak "s|auth-user-pass|auth-user-pass ../auth.txt|g" {} +;
        cd ../;
        sudo touch auth.txt;
        echo "Input user for auth.txt";
        read user;
        sudo printf "$user" | sudo tee auth.txt;
        echo "Input passwd for auth.txt"
        read pass;
        sudo printf "$pass" | sudo tee auth.txt;
        cd ~/;
    }

nord();

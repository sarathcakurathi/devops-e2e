#!/bin/bash

mkdir -p /home/ec2-user/.ssh
cat <<FILE > /home/ec2-user/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9g+gsbWn1J7SzsCiLbwJvAt9XXEKvNSduSRtvyZ2FuTp6fojVBpUoc1g9EaVEv0je+zvFZmXk/9yo9iinrVMbaPWlJ+SCxr30yqMnpl2nsexh48kA4JO+5KEetFFaPEY7AsAU5jDt//BMsPmdKJL1tdAjw65q0sCXa28UTjn4Pi075UhOnwEJEr9iil1rF9YC9upKgvb+oKYkWD6zEUCDiNNFOW0mMNDQGHIUKfQuJrKqDmFJYZEKjHIdn4d6AIp/NZL+imnw256UlT0WmJyldjDLCLdbJ0XhbDHfQHwk5XacySgPC53rQEU/mlxlQZNGt54tkfKKJTCkieESsDHN sarath@sarath-VirtualBox
FILE

chown ec2-user:ec2-user /home/ec2-user/.ssh/authorized_keys
chmod 400 /home/ec2-user/.ssh/authorized_keys


SET d="C:\Users\usuario\Desktop\Vagrant\Virtualbox\Swarm"
FOR %%x IN (M1,Mx,Wx) DO (
 mkdir %%x
 cd %%x
 curl https://raw.githubusercontent.com/secobau/linux/master/Vagrant/Swarm/Virtualbox/%%x/Vagrantfile -O
 vagrant up --parallel
 cd %d% )
cd M1
vagrant ssh M1 -c "for x in $(sudo docker node ls -q -f name=M);do sudo docker node update --availability drain $x;done"
vagrant ssh M1 -c "curl https://raw.githubusercontent.com/secobau/linux/master/Vagrant/Swarm/Virtualbox/stack.yml -O"
vagrant ssh M1 -c "sudo docker stack deploy -c stack.yml my"
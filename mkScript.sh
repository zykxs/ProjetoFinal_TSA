#./mkScript.sh
#!/bin/bash

# Check if filename is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

#Set filename
touch $1.sh

#set execute perms
chmod +x $1.sh

#Set first lines in new script
echo "#./$1.sh" >> $1.sh
echo "#!/bin/bash" >> $1.sh
echo >> $1.sh
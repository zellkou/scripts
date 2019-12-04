#!/bin/bash
cd /mnt/downloads/
for archive in *.rar;
    do
        destination="${archive%.rar}"
        if [ ! -d "$destination" ] ; then
            mkdir "$destination";
        fi
# -x@list excludes files in list
        unrar e -x@finished.list "$archive" "$destination"
# If exit code = 0 then add archive to finished.list else rm destination
        Result=$?
        if [$Result =eq 0 ]; Then
            printf "$archive" -> finished.list;
        else
            rm -r $destination
        fi
done
